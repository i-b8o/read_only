import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:read_only/domain/entity/search_item.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/search/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = context.watch<SearchViewModel>();
    final searchItems = model.searchResults;
    if (searchItems == null) {
      return const Center(child: Text("Нет ничего"));
    }
    final searchItemsLength = searchItems.length;

    // final state =
    //     context.select((SearchCubit searchCubit) => searchCubit.state);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
        child: const SearchAppBar(),
      ),
      body: (searchItemsLength == 0)
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
              itemCount: searchItemsLength,
              itemBuilder: (context, index) {
                SearchItem _item = searchItems[index];
                return Card(
                  elevation: 0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.zero,
                  shape: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Theme.of(context).shadowColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.01, width * 0.06, width * 0.01, width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  SizedBox(
                                    width: width * 0.85,
                                    child: HtmlWidget(
                                      _item.text,
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
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: ReadOnlyAppBar(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: Theme.of(context).appBarTheme.iconTheme!.size,
                  color: Theme.of(context).appBarTheme.iconTheme!.color,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextField(
                  autofocus: true,
                  // controller: context.read<SearchCubit>().searchController,
                  cursorColor: Theme.of(context).appBarTheme.foregroundColor,
                  style: Theme.of(context).appBarTheme.toolbarTextStyle,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 22, maxHeight: 22),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color!)),
                    isDense: true,
                    hintText: 'Поиск',
                  ),
                  onChanged: (content) {},
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.search,
            //     size: Theme.of(context).appBarTheme.iconTheme!.size,
            //     color: Theme.of(context).appBarTheme.iconTheme!.color,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
