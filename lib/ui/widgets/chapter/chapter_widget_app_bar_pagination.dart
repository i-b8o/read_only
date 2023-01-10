import 'package:flutter/material.dart';

class ChapterWidgetAppBarPagination extends StatelessWidget {
  const ChapterWidgetAppBarPagination({
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
