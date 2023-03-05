import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/domain/entity/search_item.dart';

import 'search_model.dart';

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({
    super.key,
    required this.item,
  });

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = context.read<SearchViewModel>();
    final onTap = model.onTap;
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            L.info(
                "doc: ${item.docID} chapter: ${item.chapterID} paragarph: ${item.paragraphID}");
            await onTap(context, item.docID, item.chapterID, item.paragraphID);
          },
          child: Row(
            children: [
              SizedBox(
                width: width * 0.05,
              ),
              SizedBox(
                width: width * 0.85,
                child: HtmlWidget(
                  item.text,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
