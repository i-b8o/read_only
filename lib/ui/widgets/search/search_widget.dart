import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:read_only/domain/entity/search_item.dart';

import 'search_app_bar.dart';
import 'search_item.dart';
import 'search_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = context.watch<SearchViewModel>();
    final searchItems = model.searchResults ?? [];
    final searchItemsLength = searchItems.length;
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
                SearchItem item = searchItems[index];
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
                        SearchItemWidget(item: item),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
