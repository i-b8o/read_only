import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chapter_model.dart';

class ParagraphCardBottomSheet extends StatelessWidget {
  const ParagraphCardBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    return Wrap(alignment: WrapAlignment.center, children: [
      GestureDetector(
        onTap: () async {
          Navigator.pop(context);
          model.startSpeakParagraph();
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
              Icons.code_outlined,
              color: Theme.of(context).appBarTheme.toolbarTextStyle!.color,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            const Text(
              'Абзац',
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
          model.startSpeakChapter();
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
            Icon(Icons.feed_outlined,
                color: Theme.of(context).appBarTheme.toolbarTextStyle!.color),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            const Text('Главу'),
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
