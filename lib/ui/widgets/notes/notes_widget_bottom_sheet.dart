import 'package:flutter/material.dart';

class NotesBottomSheet extends StatelessWidget {
  const NotesBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(alignment: WrapAlignment.center, children: [
      GestureDetector(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Row(children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Icon(
              Icons.date_range,
              color: Theme.of(context).appBarTheme.toolbarTextStyle!.color,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            const Text(
              'Сортировать по дате',
            ),
          ]),
        ),
      ),
      Container(
        height: 1,
        width: MediaQuery.of(context).size.width * 0.95,
        color: Theme.of(context).bottomAppBarColor,
      ),
      GestureDetector(
        onTap: () async {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Row(children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Icon(Icons.color_lens_outlined,
                color: Theme.of(context).appBarTheme.toolbarTextStyle!.color),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            const Text('Сортировать по цвету'),
          ]),
        ),
      ),
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.95,
          child: const Center(child: Text("Отменить")),
        ),
      ),
    ]);
  }
}
