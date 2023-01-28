import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'chapter_widget_app_bar.dart';
import 'chapter_widget_paragraph_list.dart';

class ChapterWidget extends StatelessWidget {
  const ChapterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final chapter = model.chapter;
    if (chapter == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.stop),
          onPressed: () {
            model.stopSpeak();
          },
        ),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Theme.of(context).appBarTheme.elevation ?? 74),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: const ReadOnlyAppBar(
              child: ChapterWidgetAppBar(),
            ),
          ),
        ),
        body: PageView.builder(
          itemCount: model.chapterCount,
          controller: model.pageController,
          onPageChanged: (_) {
            model.onPageChanged();
          },
          itemBuilder: (BuildContext context, int index) {
            return ParagraphList(
              itemScrollController: ItemScrollController(),
            );
          },
        ));
  }
}
