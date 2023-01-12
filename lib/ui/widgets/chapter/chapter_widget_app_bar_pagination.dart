import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chapter_model.dart';

class ChapterWidgetAppBarPagination extends StatelessWidget {
  const ChapterWidgetAppBarPagination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final String textEditingText = model.textEditingController.text;
    final int pageIndex = model.currentPage;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            // move to model
            int? pageNum = int.tryParse(textEditingText);
            if (pageNum == 1) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Это первая страница!'),
              ));
              return;
            }
            model.pageController.previousPage(
                duration: const Duration(seconds: 1), curve: Curves.ease);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        SizedBox(
            height: 30,
            width: 30,
            child: TextFormField(
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  int pageNum =
                      int.tryParse(model.textEditingController.text) ?? 1;
                  if (pageNum > model.chapterCount) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          '$pageNum-ой страницы не существует, страниц в документе всего ${model.chapterCount}!'),
                    ));
                    return;
                  } else if (pageNum < 1) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('$pageNum-ой страницы не существует!'),
                    ));
                    return;
                  }
                  model.pageController.animateToPage(pageNum - 1,
                      duration: const Duration(seconds: 1), curve: Curves.ease);
                },
                controller: model.textEditingController,
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
                  text: '${model.chapterCount}',
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
            int? pageNum = int.tryParse(model.textEditingController.text);
            if (pageNum == null) {
              return;
            }
            if (pageNum == model.chapterCount) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Это последняя страница!'),
              ));
              return;
            }

            model.pageController.nextPage(
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
