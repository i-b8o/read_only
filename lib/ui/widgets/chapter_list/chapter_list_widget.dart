import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_widget.dart';

import 'chapter_list_model.dart';

class ChapterListWidget extends StatelessWidget {
  const ChapterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterListViewModel>();
    final doc = model.doc;
    final chapters = model.chapters;

    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: const ReadOnlyAppBar(child: TypeListAppBar()),
            ),
          ),
          drawer: Builder(
            builder: (context) => const ReadOnlyNavigationDrawer(),
          ),
          body: doc == null
              ? Center(
                  child: Text("Нет такого документа",
                      style: TextStyle(
                          color: Theme.of(context).focusColor,
                          decoration: TextDecoration.none)),
                )
              : ListView(
                  children: chapters
                      .map((e) => TypeCard(
                            name: e.name,
                            id: e.id,
                          ))
                      .toList(),
                )),
    );
  }
}

class TypeListAppBar extends StatelessWidget {
  const TypeListAppBar({
    Key? key,
  }) : super(key: key);

  Widget _buildChild() {
    return const InitAppBAr();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }
}

class InitAppBAr extends StatelessWidget {
  const InitAppBAr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return MediaQuery.of(context).orientation == Orientation.portrait
                ? IconButton(
                    onPressed: () async {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: Theme.of(context).appBarTheme.iconTheme!.size,
                      color: Theme.of(context).appBarTheme.iconTheme!.color,
                    ),
                  )
                : Container();
          },
        ),
        IconButton(
          onPressed: () async {
            Navigator.pushNamed(
              context,
              '/search_screen',
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

class TypeCard extends StatelessWidget {
  const TypeCard({
    Key? key,
    required this.name,
    required this.id,
  }) : super(key: key);
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    final model = context.read<ChapterListViewModel>();
    return GestureDetector(
        onTap: () => model.onTap(context, id),
        child: Card(
          margin: EdgeInsets.zero,
          shape: Border(
            bottom:
                BorderSide(width: 1.0, color: Theme.of(context).shadowColor),
          ),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ));
  }
}
