import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'chapter_model.dart';
import 'chapter_widget_regular_table.dart';
import 'chapter_widget_table_with_big_picture.dart';

// TODO make jumpTo
// class ParagraphTable extends StatelessWidget {
//   final int index;
//   ParagraphTable({Key? key, required this.index}) : super(key: key);
//   late WebViewController _controller;
//   @override
//   Widget build(BuildContext context) {
//     final model = context.read<ChapterViewModel>();
//     final content =
//         model.chapter!.paragraphs[index].content.trim().replaceAll("\n", " ");

//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: Container(
//         color: Theme.of(context).textTheme.headline2!.backgroundColor,
//         child: buildHtmlTable(content, context),
//       ),
//     );
//   }

//   _loadHtmlFromString(String htmlString) async {
//     _controller.loadUrl(Uri.dataFromString(htmlString,
//             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//         .toString());
//   }

//   WebView buildHtmlTable(String content, BuildContext context) {
//     return WebView(
//       initialUrl: 'about:blank',
//       onWebViewCreated: (WebViewController webViewController) {
//         _controller = webViewController;
//         _loadHtmlFromString(content);
//       },
//     );
//   }

//   // HtmlWidget buildHtmlTable(String content, BuildContext context) {
//   //   return HtmlWidget(
//   //     content,
//   //     textStyle: Theme.of(context).textTheme.headline2,
//   //     customStylesBuilder: (element) {
//   //       switch (element.localName) {
//   //         case 'table':
//   //           return {
//   //             'border': '1px solid',
//   //             'border-collapse': 'collapse',
//   //             'font-size': '16px',
//   //             'line-height': '18px',
//   //             'letter-spacing': '0',
//   //             'font-weight': '400',
//   //             'font-family': 'Times New Roman',
//   //           };
//   //         case 'td':
//   //           return {'border': '1px solid', 'vertical-align': 'top'};
//   //       }
//   //       if (element.className.contains('align_center')) {
//   //         return {'text-align': 'center', 'width': '100%'};
//   //       }
//   //       return null;
//   //     },
//   //     onTapUrl: (href) async {
//   //       return false;
//   //     },
//   //   );
//   // }
// }

// TODO make jumpTo
class ParagraphTable extends StatelessWidget {
  final int index;
  const ParagraphTable({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final content =
        model.chapter!.paragraphs[index].content.trim().replaceAll("\n", " ");
    bool hasBase64 = content.contains("data:image/png;base64");

    return hasBase64
        ? TableWithBigPictures(
            content: content,
          )
        : RegularTable(
            content: content,
          );
  }
}
