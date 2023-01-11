import 'package:flutter/material.dart';

import 'chapter_widget_app_bar_pagination.dart';

class ChapterWidgetAppBar extends StatelessWidget {
  const ChapterWidgetAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
        const ChapterWidgetAppBarPagination(),
        IconButton(
          onPressed: () async {
            Navigator.pushNamed(
              context,
              '/searchScreen',
            );
          },
          icon: Icon(
            Icons.search,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
      ],
    );
  }
}
