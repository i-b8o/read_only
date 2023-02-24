import 'package:flutter/material.dart';

import 'menu_item.dart';

class NotesMenuItem extends StatelessWidget {
  const NotesMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      onExpansionChanged: (bool val) async {
        Navigator.of(context).pop();
        Navigator.pushNamed(
          context,
          '/notes_screen',
        );
      },
      trailing: const SizedBox(),
      leadingIconData: Icons.note_alt_outlined,
      title: 'Заметки',
    );
  }
}
