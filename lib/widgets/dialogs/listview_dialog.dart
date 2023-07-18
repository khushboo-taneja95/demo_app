import 'package:flutter/material.dart';

typedef OnItemTap = void Function(int index);

class ListViewDialogWidget extends StatelessWidget {
  final List<String>? itemTitles;
  final List<Widget>? items;
  final String dialogTitle;
  final int selectedItemIndex;
  final OnItemTap onTap;

  const ListViewDialogWidget(
      {super.key,
      this.itemTitles,
      this.items,
      required this.dialogTitle,
      required this.selectedItemIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (itemTitles != null) {
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dialogTitle,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onTap(index);
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(itemTitles![index]),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                );
              },
              itemCount: itemTitles!.length,
              shrinkWrap: true,
            ),
          ],
        ),
      );
    } else if (items != null) {
      return Dialog(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                onTap(index);
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: items![index],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
          itemCount: items!.length,
          shrinkWrap: true,
        ),
      );
    } else {
      return Container();
    }
  }
}
