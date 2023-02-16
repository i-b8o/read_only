import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
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
        '<div style="margin-bottom:20px;overflow: scroll;display: flex;align-items: center;justify-content: start;">${content.replaceAll("<td", "<td style='border:1px solid black;margin:0;' ").replaceAll("<table", "<table style='width:100%;' ")}</div>';

    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        L.info(request.url.toString());
        return NavigationDecision.prevent;
      },
      gestureRecognizers: gestureRecognizers,
      initialUrl: 'about:blank',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
        _loadHtmlFromString(content);
        // _controller.runJavascript(
        //     'document.addEventListener("load", function () {alert("Its loaded!")})');
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
