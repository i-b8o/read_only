import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
          child: SearchAppBar(),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) => (state.paragraphs.length == 0)
              ? Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Text(
                      'По вашему запросу ничего не найдено.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: state.paragraphs.length,
                  itemBuilder: (context, index) {
                    EditableContentParagraph _paragraph =
                        state.paragraphs[index];
                    return Card(
                      elevation: 0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.zero,
                      shape: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Theme.of(context).shadowColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(_width * 0.01,
                            _width * 0.06, _width * 0.01, _width * 0.05),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    List<int> chapterAndParagraphOrderNums =
                                        context
                                            .read<RegulationCubit>()
                                            .getChapterAndParagraphOrderNums(
                                                _paragraph.paragraph.chapterID,
                                                _paragraph.paragraph.id);

                                    ChapterArguments args = ChapterArguments(
                                        chapterOrderNum:
                                            chapterAndParagraphOrderNums[0],
                                        totalChapters: context
                                            .read<TableOfContentsBloc>()
                                            .chapters
                                            .length,
                                        scrollTo:
                                            chapterAndParagraphOrderNums[1]);
                                    Navigator.pushNamed(context, '/chapter',
                                        arguments: args);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: _width * 0.05,
                                      ),
                                      SizedBox(
                                        width: _width * 0.85,
                                        child: HtmlWidget(
                                          _paragraph.content,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ));
  }
}
