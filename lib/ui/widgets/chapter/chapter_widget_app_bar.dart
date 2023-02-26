import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chapter_model.dart';
import 'chapter_widget_app_bar_pagination.dart';

class ChapterWidgetAppBar extends StatelessWidget {
  const ChapterWidgetAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final stopSpeak = model.stopSpeak;
    final resumeSpeak = model.resumeSpeak;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            resumeSpeak();
            stopSpeak();
            Navigator.of(context).pop();
          },
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
