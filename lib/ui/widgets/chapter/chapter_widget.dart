import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'chapter_widget_app_bar.dart';

class ChapterWidget extends StatelessWidget {
  const ChapterWidget({Key? key}) : super(key: key);

  buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final chapter = model.chapter;
    print("Rebuild ${chapter == null}");
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.stop),
          onPressed: () {},
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
        body: chapter == null
            ? Container(
                color: Colors.blue,
              )
            : PageView.builder(
                itemCount: model.chapterCount,
                onPageChanged: (index) {
                  buildShowDialog(context);
                  model.onPageChanged(index);
                  Navigator.pop(context);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ScrollablePositionedList.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: HtmlWidget(chapter.paragraphs[index].content),
                      );
                    },
                    itemCount: chapter.paragraphs.length,
                  );
                },
              ));
  }
}
