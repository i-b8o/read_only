import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/notes/notes_model.dart';

import 'notes_widget_app_bar.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = context.watch<NotesViewModel>();
    final notes = model.notes;
    final itemCount = notes == null ? 0 : notes.length;
    final onTap = model.onTap;
    final onDrop = model.onDrop;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
          child: const NotesAppBar(),
        ),
        body: notes == null
            ? const Center(
                child: Text("У Вас пока нет заметок"),
              )
            : ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  final chapterID = note.chapterID;
                  final paragraphID = note.paragraphID;
                  final color = note.docColor;
                  final text = note.text;
                  final docName = note.docName;
                  return GestureDetector(
                    onTap: () async {
                      // Navigator.popAndPushNamed(context, '/chapter',);
                      onTap(context, chapterID, paragraphID);
                    },
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.zero,
                      shape: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Theme.of(context).shadowColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.04, width * 0.06,
                            width * 0.075, width * 0.05),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          color: Color(color),
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                            docName,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: width * 0.045,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: width * 0.04,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * 0.1,
                                        ),
                                        SizedBox(
                                          width: width * 0.65,
                                          child: Text(
                                            text,
                                            // _bookMark.link.text,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: width * 0.03,
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .toolbarTextStyle!
                                                    .color,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async =>
                                      onDrop(paragraphID, chapterID),
                                  child: Icon(
                                    Icons.close,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })

        // return Center(
        //   child: Text("У вас пока нет заметок"),
        // );

        );
  }
}
