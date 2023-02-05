import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TableWithBigPictures extends StatelessWidget {
  TableWithBigPictures({super.key, required this.content});
  final String content;
  late final WebViewController _controller;
  _loadHtmlFromString(String htmlString) async {
    _controller.loadUrl(Uri.dataFromString(htmlString,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  Widget buildHtmlTable(String content, BuildContext context) {
    content =
        '<div style="margin-bottom:20px;overflow: scroll;display: flex;align-items: center;justify-content: start;">$content</div>';

    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        print(request.url.toString());
        return NavigationDecision.prevent;
      },
      gestureRecognizers: gestureRecognizers,
      initialUrl: 'about:blank',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _loadHtmlFromString(content);
        _controller.runJavascript(
            'let tds = document.getElementsByTagName("td");alert("aasdffgghgfjugthykj"+tds.length);');
      },
    );
  }

  // ignore: prefer_collection_literals
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black,
            width: 1,
          )),
          child: Container(
            color: Theme.of(context).textTheme.headline2!.backgroundColor,
            child: buildHtmlTable(content, context),
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
