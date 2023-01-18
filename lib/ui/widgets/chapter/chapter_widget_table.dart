import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:provider/provider.dart';

import 'chapter_model.dart';

// TODO make jumpTo
class ParagraphTable extends StatelessWidget {
  final int index;
  const ParagraphTable({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final model = context.read<ChapterViewModel>();
    final content =
        model.chapter!.paragraphs[index].content.trim().replaceAll("\n", " ");
    print(
        "content ,<====='${content.substring(content.length - 150)}'===============>");
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     TextButton(
        //         onPressed: () {},
        //         child: Row(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.only(top: 2.0),
        //               child: Icon(
        //                 Icons.arrow_drop_down,
        //                 color: Theme.of(context).iconTheme.color,
        //               ),
        //             ),
        //             Text("Свернуть",
        //                 style: TextStyle(
        //                     color: Theme.of(context).iconTheme.color,
        //                     fontWeight: FontWeight.w400))
        //           ],
        //         )),
        //   ],
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            color: Theme.of(context).textTheme.headline2!.backgroundColor,
            child: HtmlWidget(
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
                print("null");
                return null;
              },
              onTapUrl: (href) async {
                return false;
              },
            ),
          ),
        ),
      ],
    );
  }
}
