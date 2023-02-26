import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'chapter_model.dart';

class SelectableTextWidget extends StatelessWidget {
  const SelectableTextWidget({
    Key? key,
    required this.index,
    required this.passedContext,
  }) : super(key: key);

  final int index;
  final BuildContext passedContext;

  @override
  Widget build(BuildContext context) {
    final model = passedContext.read<ChapterViewModel>();
    final paragraph = model.paragraphs[index];
    final pClass = paragraph.paragraphclass;
    final content = paragraph.content;
    final onTapUrl = model.onTapUrl;
    final fontSize = model.getFontSizeInPx();
    final fontWeight = model.getFontWeight();

    return HtmlWidget(
      content,
      textStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.bodyText2!.fontFamily,
          color: Theme.of(context).textTheme.bodyText2!.color,
          fontSize: fontSize,
          fontWeight: FontWeight.values[fontWeight]),
      onTapUrl: (href) async {
        return await onTapUrl(context, href);
      },
      customStylesBuilder: pClass == ""
          ? null
          : (element) {
              return {
                'text-align':
                    pClass == "align_right" || pClass == "align_right no-indent"
                        ? 'right'
                        : 'center'
              };
            },
    );
  }
}
