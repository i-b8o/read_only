import 'package:flutter/material.dart';
import 'package:read_only/ui/widgets/app_bar/app_bar.dart';

import 'notes_widget_bottom_sheet.dart';

class NotesAppBar extends StatelessWidget {
  const NotesAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: ReadOnlyAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
          Text('Заметки', style: Theme.of(context).appBarTheme.titleTextStyle),
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const NotesBottomSheet();
                  });
            },
            icon: Icon(
              Icons.sort,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
        ],
      )),
    );
  }
}
