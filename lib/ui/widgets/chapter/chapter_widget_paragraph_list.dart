import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'chapter_model.dart';
import 'chapter_widget_header.dart';
import 'chapter_widget_paragraph_card.dart';

class ParagraphList extends StatelessWidget {
  const ParagraphList({
    Key? key,
    required this.itemScrollController,
  }) : super(key: key);
  final ItemScrollController itemScrollController;

  void scrollToItem(int orderNum) {
    if (orderNum < 1) {
      return;
    }
    if (!itemScrollController.isAttached) {
      return;
    }
    itemScrollController.jumpTo(index: orderNum);
  }

  ParagraphCard _buildParagraphCard(int index) {
    return ParagraphCard(
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final chapter = model.chapter;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToItem(model.paragraphOrderNum - 1));

    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemCount: chapter!.paragraphs.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const ChapterWidgetHeader(),
              _buildParagraphCard(index),
            ],
          );
        } else if ((index == (chapter.paragraphs.length - 1))) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildParagraphCard(index),
            ],
          );
        }
        return _buildParagraphCard(index);

        // return Card(
        //   child: HtmlWidget(
        //     chapter.paragraphs[index].content,
        //     onTapUrl: (href) => model.onTapUrl(context, href),
        //   ),
        // );
      },
    );
  }
}
