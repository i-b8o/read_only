import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:provider/provider.dart';

import 'chapter_model.dart';

// TODO make jumpTo
class ParagraphTable extends StatelessWidget {
  final int index;
  const ParagraphTable({Key? key, required this.index}) : super(key: key);

  Image base64ImageRender(context, element) {
    // print('src=${element.attributes["src"]}');
    // final decodedImage = base64.decode(element.attributes["src"] != null
    //     ? element.attributes["src"]!.split("base64,")[1].trim()
    //     : "about:blank");
    final decodedImage = base64.decode(
        "data:image/png;base64,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"
            .split("base64,")[1]
            .trim());
    return Image.memory(
      decodedImage,
      width: 10,
      height: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final model = context.read<ChapterViewModel>();
    final content =
        model.chapter!.paragraphs[index].content.trim().replaceAll("\n", " ");

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
            child: Html(
              data: content,
              // textStyle: Theme.of(context).textTheme.headline2,
              // customWidgetBuilder: (element) {
              //   if (element.attributes['src'] == null) {
              //     return null;
              //   }
              //   base64ImageRender(context, element);
              //   // if (element.attributes['src']!.startsWith('')) {
              //   //   print(
              //   //       'src=${element.attributes['src']!.replaceFirst("data:image/png;base64,", "")}');
              //   //   return Image.memory(base64Decode(element.attributes['src']!
              //   //       .replaceFirst("data:image/png;base64,", "")));
              //   // }
              // },
              // customStylesBuilder: (element) {
              //   switch (element.localName) {
              //     case 'table':
              //       return {
              //         'border': '1px solid',
              //         'border-collapse': 'collapse',
              //         'font-size': '16px',
              //         'line-height': '18px',
              //         'letter-spacing': '0',
              //         'font-weight': '400',
              //         'font-family': 'Times New Roman',
              //       };
              //     case 'td':
              //       return {'border': '1px solid', 'vertical-align': 'top'};
              //   }
              //   if (element.className.contains('align_center')) {
              //     return {'text-align': 'center', 'width': '100%'};
              //   }
              //   print("null");
              //   return null;
              // },
              // onTapUrl: (href) async {
              //   return false;
              // },
            ),
          ),
        ),
      ],
    );
  }
}
