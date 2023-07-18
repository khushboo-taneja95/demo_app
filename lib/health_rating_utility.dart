import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tres_connect/core/database/entity/health_rating_entity.dart';
import 'package:tres_connect/core/di/injection.dart';
import 'package:tres_connect/core/themes/palette.dart';
import 'package:tres_connect/gen/assets.gen.dart';
import 'package:tres_connect/global_configuration.dart';

class HealthRatingUtility {
  void checkHealthRating() {
    //Vaccination Report for 14 days
    //BT For last 24 hrs
    //OS for last 24 hrs
  }

  static Widget getRatingWidget(
      {HealthRatingEntity? ratingEntity,
      required VoidCallback onClick,
      double height = 40,
      bool showOnlyReason = false}) {
    Color barBGColor = Colors.green;
    Color reasonBGColor = Colors.white;
    String statusLabel = "Reading Normal";
    String statusReason = "";
    String reasonToShow = "";

    if (ratingEntity != null) {
      if (ratingEntity.riskValue != null) {
        if (ratingEntity.riskValue != null && ratingEntity.riskValue == "BT") {
          statusReason = "Body Temperature";
          if (ratingEntity.riskRating != null) {
            if (ratingEntity.riskRating == "Orange") {
              barBGColor = Palette.cautiousColor;
              reasonBGColor = const Color(0xffF8E2B3);
              reasonToShow =
                  "Your health status is cautious due to abnormal reading under BT ";
              statusLabel = "Caution Required";
            } else if (ratingEntity.riskRating == "Red") {
              barBGColor = const Color(0xffDF4242);
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "Your temperature was above normal continously for 3 days during the last 7 day";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskRating == "Green") {
              barBGColor = const Color(0xff4CAF50);
              reasonBGColor = const Color(0xffC6E5C6);
              reasonToShow =
                  "Your temperature was normal during the last 7 days";
              statusLabel = "Reading Normal";
            }
          }
        } else if (ratingEntity.riskValue != null &&
            ratingEntity.riskValue == "OS") {
          statusReason = "Oxygen Saturation";
          if (ratingEntity.riskRating != null) {
            if (ratingEntity.riskRating == "Orange") {
              barBGColor = Palette.cautiousColor;
              reasonBGColor = const Color(0xffF8E2B3);
              reasonToShow =
                  "Your health status is cautious due to abnormal reading under SPO2";
              statusLabel = "Caution Required";
            } else if (ratingEntity.riskRating == "Red") {
              barBGColor = const Color(0xffDF4242);
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "You need to consult your physician as your SPO2 in last 24 hours is low";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskRating == "Green") {
              barBGColor = const Color(0xff4CAF50);
              reasonBGColor = const Color(0xffC6E5C6);
              reasonToShow =
                  "Your oxygen saturation was normal during the last 7 days";
              statusLabel = "Reading Normal";
            }
          }
        }
      }

      if (ratingEntity.reasonToShow == null ||
          ratingEntity.reasonToShow == "") {
        if (ratingEntity.riskValue == "BT") {
          statusReason = "Body Temperature";
          if (ratingEntity.riskRating != null) {
            if (ratingEntity.riskRating == "Cautious") {
              barBGColor = Palette.cautiousColor;
              reasonBGColor = const Color(0xffF8E2B3);
              reasonToShow =
                  "Your health status is cautious due to abnormal reading under BT ";
              statusLabel = "Caution Required";
            } else if (ratingEntity.riskRating == "Risk") {
              barBGColor = const Color(0xffDF4242);
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "Your temperature was above normal continuously for 3 days during the last 7 day";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskRating == "Normal") {
              barBGColor = const Color(0xff4CAF50);
              reasonBGColor = const Color(0xffC6E5C6);
              statusLabel = "Reading Normal";
            }
          } else if (ratingEntity.riskValue == "OS") {
            statusReason = "Oxygen Saturation";

            if (ratingEntity.riskRating == "Cautious") {
              barBGColor = Palette.cautiousColor;
              reasonBGColor = const Color(0xffF8E2B3);

              reasonToShow =
                  "Your health status is cautious due to abnormal reading under SPO2";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskRating == "Risk") {
              barBGColor = const Color(0xffDF4242);
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "You need to consult your physician as your SPO2 in last 24 hours is low";
              statusLabel = "Consult Physician";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskRating == "Normal") {}
          } else {
            if (ratingEntity.riskValue == "CovidReport") {
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "You need to consult your physician as your covid report is positive.";
              statusLabel = "Consult Physician";
            } else if (ratingEntity.riskValue == "ANTIGEN") {
              reasonBGColor = const Color(0xffF5C6C6);
              reasonToShow =
                  "You need to consult your physician as your Antigen Report is positive.";
              statusLabel = "Consult Physician";
            }
          }
        } else {
          if (ratingEntity.riskValue == "CovidReport") {
            reasonBGColor = const Color(0xffF5C6C6);
            reasonToShow =
                "You need to consult your physician as your covid report is positive.";
            statusLabel = "Consult Physician";
          } else if (ratingEntity.riskValue == "ANTIGEN") {
            reasonBGColor = const Color(0xffF5C6C6);
            reasonToShow =
                "You need to consult your physician as your Antigen Report is positive.";
            statusLabel = "Consult Physician";
          }
        }
      }

      if (ratingEntity.riskRating != null &&
          ratingEntity.riskRating == "" &&
          ratingEntity.riskRating == "CovidReport") {
        reasonBGColor = const Color(0xffF5C6C6);
      } else if (ratingEntity.riskValue == "ANTIGEN") {
        reasonBGColor = const Color(0xffF5C6C6);
      } else {}

      if (ratingEntity.riskRating == "Red") {
        if (ratingEntity.riskValue == "CovidReport") {
          barBGColor = const Color(0xffDF4242);
          reasonBGColor = const Color(0xffF5C6C6);
          statusLabel = "Consult Physician";
          reasonToShow =
              "You need to consult your physician as your covid report is positive.";
        } else if (ratingEntity.riskValue == "ANTIGEN") {
          barBGColor = const Color(0xffDF4242);
          reasonBGColor = const Color(0xffF5C6C6);
          statusLabel = "Consult Physician";
          reasonToShow =
              "You need to consult your physician as your Antigen Report is positive.";
        }
      }

      if (ratingEntity.riskRating == "No Status") {
        barBGColor = Colors.grey;
        reasonBGColor = Colors.grey;
        statusLabel = "No Vitals in last 24 hrs";
      }
    } else {
      barBGColor = Colors.grey;
      statusLabel = "No Vitals in last 24 hrs";
    }

    //New Code
    if (ratingEntity != null && ratingEntity.riskRating!.isNotEmpty) {
      String color = ratingEntity.riskRating!;

      if (ratingEntity.riskValue!.toUpperCase() == "BT") {
        String statusReason = "Body Temperature";
        if (color == "Orange") {
          statusLabel = "Caution Required";
          reasonToShow =
              "Your health status is cautious due to abnormal reading under BT on ${ratingEntity.remarkStatusTime}";
        } else if (color == "RED") {
          statusLabel = "Consult Physician";
          reasonToShow =
              "Your temperature was above normal continuously for 3 days ${ratingEntity.remarkStatusTime} during the last 7 days";
        } else if (color == "Green") {
          statusLabel = "Reading Normal";
        } else if (color == "No Status") {
          statusLabel = "No Status";
        }
      } else if (ratingEntity.riskValue == "OS") {
        String statusReason = "Oxygen Saturation";
        if (color == "Orange") {
          statusLabel = "Caution Required";
          reasonToShow =
              "Your health status is cautious due to abnormal reading under SPO2 from ${ratingEntity.remarkStatusTime}";
        } else if (color == "RED") {
          statusLabel = "Consult Physician";
          reasonToShow =
              "You need to consult your physician as your SPO2 in the last 24 hours is low at ${ratingEntity.remarkStatusTime}";
        } else if (color == "Green") {
          statusLabel = "Reading Normal";
        } else if (color == "No Status") {
          statusLabel = "No Status";
        }
      } else {
        if (ratingEntity.riskValue == "CovidReport") {
          if (ratingEntity.travelStatus == "false") {
            reasonToShow =
                "You need to consult your physician as your covid report is positive.";
          } else {
            reasonToShow = "";
          }
        } else if (ratingEntity.riskValue == "ANTIGEN") {
          if (ratingEntity.travelStatus == "false") {
            reasonToShow =
                "You need to consult your physician as your Antigen Report is positive.";
          } else {
            reasonToShow = "";
          }
        }
      }
    }
    if (statusLabel == "No Status") {
      barBGColor = Colors.grey;
    } else if (statusLabel == "Rading Normal") {
      barBGColor = Colors.green;
    } else if (statusLabel == "Caution Required") {
      barBGColor = Colors.orange;
    } else if (statusLabel == "Consult Physician") {
      barBGColor = Colors.red;
    }
    getIt<GlobalConfiguration>().healthStatus = statusLabel;
    getIt<GlobalConfiguration>().healthStatusReason = reasonToShow;
    getIt<GlobalConfiguration>().healthStatusColor = barBGColor;
    getIt<GlobalConfiguration>().reason = ratingEntity?.remarks ?? "";
    bool isVisible = false;
    return Flexible(
      child: StatefulBuilder(
        builder: (context, setState) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: height,
                color: barBGColor,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        statusLabel,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Builder(builder: (context) {
                        bool flag = true;
                        if (statusLabel == "No Vitals in last 24 hrs") {
                          flag = false;
                        }
                        if (statusLabel == "Reading Normal") {
                          flag = false;
                        }
                        if (flag) {
                          return InkWell(
                            onTap: () {
                              onClick();
                            },
                            child: Assets.images.iButton.image(
                              height: 20,
                              width: 20,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showBottomSheet() {}
}
