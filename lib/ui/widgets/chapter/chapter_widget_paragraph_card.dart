import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:provider/provider.dart';
import 'package:read_only/library/text/text.dart';

import 'chapter_model.dart';
import 'chapter_widget_focused_menu_holder.dart';
import 'chapter_widget_focused_menu_item.dart';
import 'chapter_widget_paragraph_bottom.dart';
import 'chapter_widget_paragraph_nft.dart';
import 'chapter_widget_paragraph_selectable_text.dart';
import 'chapter_widget_paragraph_table.dart';

class ParagraphCard extends StatelessWidget {
  const ParagraphCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  Future<void> share(String text) async {
    await FlutterShare.share(
      title: 'Поделиться',
      text: text,
      // linkUrl: 'market://details?id=com.i_rm.poteu',
    );
  }

  Card buildCard(
      BuildContext context, String pClass, content, bool isNFT, isTable) {
    return Card(
      elevation: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.zero,
      child: pClass == "indent"
          ? const SizedBox(
              height: 15,
            )
          : Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: pClass == "" ? 16.0 : 2.0),
              child: isNFT
                  ? ParagraphNFT(
                      content: content,
                      index: index,
                    )
                  : isTable
                      ? ParagraphTable(
                          index: index,
                        )
                      : SelectableTextWidget(
                          passedContext: context,
                          index: index,
                        )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterViewModel>();
    final paragraph = model.paragraphs[index];
    final paragraphClass = paragraph.paragraphclass;
    final content = paragraph.content;
    final isNFT = paragraph.isNFT;
    final isTable = paragraph.isTable;

    return (isNFT || paragraph.isTable)
        ? buildCard(context, paragraphClass, content, isNFT, isTable)
        : FocusedMenuHolder(
            menuItems: [
              FocusedMenuItem(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: const Text("Редактировать"),
                onPressed: () async {
                  model.setActiveParagraphIndex(index);
                  TextEditingController controller = TextEditingController();
                  controller.text = parseHtmlString(content);
                  showDialog(
                      context: context,
                      builder: (_) => OrientationBuilder(
                            builder:
                                (BuildContext _, Orientation orientation) =>
                                    AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              content: TextFormField(
                                style: Theme.of(context).textTheme.bodyText1,
                                keyboardType: TextInputType.multiline,
                                minLines: 2,
                                maxLines: 25,
                                controller: controller,
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(_);
                                    },
                                    child: const Text('Сохранить')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(_);
                                    },
                                    child: const Text('Отменить')),
                              ],
                            ),
                          ));
                },
                trailingIcon: Icon(
                  Icons.edit,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text("Поделиться"),
                  onPressed: () async {
                    share(parseHtmlString(content));
                  },
                  trailingIcon: Icon(
                    Icons.share,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text("Прослушать"),
                  onPressed: () async {
                    BuildContext parentContext = context;

                    model.setActiveParagraphIndex(index);
                    showModalBottomSheet(
                        isDismissible: false,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return ParagraphCardBottomSheet(
                            parentContext: parentContext,
                          );
                        });
                  },
                  trailingIcon: Icon(
                    Icons.hearing_rounded,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text("Добавить в заметки"),
                  onPressed: () {
                    model.setActiveParagraphIndex(index);
                  },
                  trailingIcon: Icon(
                    Icons.note_alt_outlined,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
            ],
            onPressed: () {},
            bottomBorderColor: Colors.transparent,
            openWithTap: true,
            menuWidth: MediaQuery.of(context).size.width * 0.9,
            blurBackgroundColor: Theme.of(context).focusColor,
            menuOffset: 10,
            blurSize: 1,
            menuItemExtent: 60,
            child: buildCard(context, paragraphClass, content, isNFT, isTable),
          );
  }
}
