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
    final paragraph = model.chapter!.paragraphs[index];
    final pClass = paragraph.className;
    final content = paragraph.content;
    return HtmlWidget(
      content,
      textStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyText2!.color,
      ),
      onTapUrl: (href) async {
        print("tapped $href");
        // goTo(context, href);
        return false;
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
