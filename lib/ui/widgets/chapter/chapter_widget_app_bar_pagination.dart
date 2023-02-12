import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chapter_model.dart';

class ChapterWidgetAppBarPagination extends StatelessWidget {
  const ChapterWidgetAppBarPagination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final errorMessage = model.errorMessage;
    final chapterCount = model.chapterCount;
    return errorMessage != null
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _BackBtn(),
              const SizedBox(height: 30, width: 30, child: _TextFormField()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text.rich(TextSpan(
                    text: ' стр. из ',
                    style: Theme.of(context).appBarTheme.toolbarTextStyle,
                    children: <InlineSpan>[
                      TextSpan(
                        text: '$chapterCount',
                        style: TextStyle(
                            color:
                                Theme.of(context).appBarTheme.titleTextStyle ==
                                        null
                                    ? Colors.black
                                    : Theme.of(context)
                                        .appBarTheme
                                        .titleTextStyle!
                                        .color,
                            fontWeight: FontWeight.w400),
                      )
                    ])),
              ),
              const _ForwardBtn()
            ],
          );
  }
}

class _TextFormField extends StatelessWidget {
  const _TextFormField();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final controller = model.textEditingController;
    final onChanged = model.onAppBarTextFormFieldChanged;
    final onEditingComplete = model.onAppBarTextFormFieldEditingComplete;
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).iconTheme.color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: () {
        FocusScope.of(context).unfocus();
        onEditingComplete(context);
      },
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();
  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final onPressed = model.onPrevPressed;
    return IconButton(
      onPressed: () => onPressed(context),
      icon: Icon(
        Icons.arrow_back_ios,
        size: Theme.of(context).iconTheme.size,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}

class _ForwardBtn extends StatelessWidget {
  const _ForwardBtn();

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final onPressed = model.onForwardPressed;
    return IconButton(
      onPressed: () => onPressed(context),
      icon: Icon(
        Icons.arrow_forward_ios,
        size: Theme.of(context).iconTheme.size,
        color: Theme.of(context).iconTheme.color,
      ),
    );
  }
}
