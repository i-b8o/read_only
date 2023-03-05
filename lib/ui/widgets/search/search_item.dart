import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:read_only/domain/entity/search_item.dart';

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({
    super.key,
    required this.item,
  });

  final SearchItem item;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () async {},
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
