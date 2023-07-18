import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tres_connect/core/database/entity/vaccination_entity.dart';
import 'package:tres_connect/core/utility/utils.dart';
import 'package:tres_connect/gen/assets.gen.dart';

class VaccinatedDialog extends StatefulWidget {
  final VaccinationTestEntity vaccinationTestEntity;
  const VaccinatedDialog({super.key, required this.vaccinationTestEntity});

  @override
  State<VaccinatedDialog> createState() => _VaccinatedDialogState();
}

class _VaccinatedDialogState extends State<VaccinatedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    height: 220,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                      color: Color(0xff42BB25),
                    ),
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Assets.images.icEmojiFull.image(
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity)),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: const Color(0x3E000000),
                      child: ListTile(
                        dense: true,
                        leading: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            Utils.getInitials(
                                widget.vaccinationTestEntity.beneficiaryName ??
                                    ""),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        title: Text(
                            widget.vaccinationTestEntity.beneficiaryName ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            widget.vaccinationTestEntity.beneficiaryGender ??
                                "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
                      )),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.person_outline_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Beneficiary ID",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.normal)),
                      Text(widget.vaccinationTestEntity.referenceNumber ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                ],
              ),
            ),
            const Divider(height: 0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.cake_outlined),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Year of birth",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.normal)),
                      Text(
                          "${DateTime.now().year - int.parse(widget.vaccinationTestEntity.beneficiaryAge ?? "0")}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400))
                    ],
                  )
                ],
              ),
            ),
            const Divider(height: 0),
            const SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          width: 300,
                          height: 300,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                padding: const EdgeInsets.all(20),
                                child: Image.memory(
                                  base64Decode(widget.vaccinationTestEntity
                                      .vaccinationQRCode!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: SizedBox(
                height: 70,
                width: 70,
                child: Image.memory(
                  base64Decode(widget.vaccinationTestEntity.vaccinationQRCode!),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            const Text(
              "Click to enlarge",
              style: TextStyle(color: Colors.grey, fontSize: 9),
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
