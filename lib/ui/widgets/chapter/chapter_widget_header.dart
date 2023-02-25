import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app/app_model.dart';

import 'chapter_model.dart';

class ChapterWidgetHeader extends StatelessWidget {
  const ChapterWidgetHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final pClass = model.paragraphs[0].paragraphclass;
    final header = model.chapter!.name;
    final appModel = context.watch<AppViewModel>();
    final fontSize = appModel.getFontSizeInPx() * 1.5;
    return Padding(
      padding: pClass == "align_right"
          ? const EdgeInsets.all(25.0)
          : const EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
                fontSize: fontSize),
          )),
        ],
      ),
    );
  }
}
