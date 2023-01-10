import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChapterWidget extends StatelessWidget {
  ChapterWidget({Key? key}) : super(key: key);
  // final ChapterArguments args;
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    final model = context.watch<ChapterViewModel>();
    final chapter = model.chapter;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.stop),
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
            child: ReadOnlyAppBar(
              child: ChapterAppBar(
                controller: controller,
                totalChapters: 15,
                pageController: pageController,
              ),
            ),
          ),
        ),
        body: chapter == null
            ? Container()
            : ScrollablePositionedList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: HtmlWidget(chapter.paragraphs[index].content),
                  );
                },
                itemCount: chapter.paragraphs.length,
              ));
  }
}

class ChapterAppBar extends StatelessWidget {
  const ChapterAppBar({
    Key? key,
    required this.totalChapters,
    required this.controller,
    required this.pageController,
  }) : super(key: key);
  final int totalChapters;
  final TextEditingController controller;
  final PageController pageController;

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
        ChapterAppBarPagination(
            controller: controller,
            pageController: pageController,
            totalChapters: totalChapters),
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

class ChapterAppBarPagination extends StatelessWidget {
  const ChapterAppBarPagination({
    Key? key,
    required this.controller,
    required this.pageController,
    required this.totalChapters,
  }) : super(key: key);

  final TextEditingController controller;
  final PageController pageController;
  final int totalChapters;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            int? pageNum = int.tryParse(controller.text);
            if (pageNum == 1) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Это первая страница!'),
              ));
              return;
            }
            pageController.previousPage(
                duration: const Duration(seconds: 1), curve: Curves.ease);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        Container(
            height: 30,
            width: 30,
            child: TextFormField(
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  int pageNum = int.tryParse(controller.text) ?? 1;
                  if (pageNum > totalChapters) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          '${pageNum}-ой страницы не существует, страниц в документе всего $totalChapters!'),
                    ));
                    return;
                  } else if (pageNum < 1) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${pageNum}-ой страницы не существует!'),
                    ));
                    return;
                  }
                  pageController.animateToPage(pageNum - 1,
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                },
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).iconTheme.color),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text.rich(TextSpan(
              text: ' стр. из ',
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
              children: <InlineSpan>[
                TextSpan(
                  text: '$totalChapters',
                  style: TextStyle(
                      color: Theme.of(context).appBarTheme.titleTextStyle ==
                              null
                          ? Colors.black
                          : Theme.of(context).appBarTheme.titleTextStyle!.color,
                      fontWeight: FontWeight.w400),
                )
              ])),
        ),
        IconButton(
          onPressed: () async {
            int? pageNum = int.tryParse(controller.text);
            if (pageNum == null) {
              return;
            }
            if (pageNum == totalChapters) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Это последняя страница!'),
              ));
              return;
            }

            pageController.nextPage(
                duration: const Duration(seconds: 1), curve: Curves.ease);
          },
          icon: Icon(
            Icons.arrow_forward_ios,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
        )
      ],
    );
  }
}
