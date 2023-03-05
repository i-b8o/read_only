import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/search/search_model.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.read<SearchViewModel>();
    final search = model.search;
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
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    search(value);
                  },
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
          ],
        ),
      ),
    );
  }
}
