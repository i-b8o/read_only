import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class RegularTable extends StatelessWidget {
  const RegularTable({super.key, required this.content});
  final String content;
  HtmlWidget buildHtmlTable(String content, BuildContext context) {
    return HtmlWidget(
      content,
      textStyle: Theme.of(context).textTheme.headline2,
      customStylesBuilder: (element) {
        switch (element.localName) {
          case 'table':
            return {
              'border': '1px solid',
              'border-collapse': 'collapse',
              'font-size': '16px',
              'line-height': '18px',
              'letter-spacing': '0',
              'font-weight': '400',
              'font-family': 'Times New Roman',
            };
          case 'td':
            return {'border': '1px solid', 'vertical-align': 'top'};
        }
        if (element.className.contains('align_center')) {
          return {'text-align': 'center', 'width': '100%'};
        }
        return null;
      },
      onTapUrl: (href) async {
        print("tappeddddddddddddddddddddddddddddd");
        return false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Theme.of(context).textTheme.headline2!.backgroundColor,
        child: buildHtmlTable(content, context),
      ),
    );
  }
}
