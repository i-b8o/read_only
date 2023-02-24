import 'package:flutter/material.dart';

import 'menu_item.dart';
import 'menu_sub_item.dart';
import 'sound_slider.dart';
import 'voice_item.dart';

class SoundMenuItem extends StatelessWidget {
  const SoundMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      leadingIconData: Icons.volume_up_outlined,
      title: 'Звук',
      // index: index,
      onExpansionChanged: (bool) {},
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                MenuSubItem(
                  value: 1,
                  leading: 'Громкость',
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: SoundSlider(
                      title: 'Громкость',
                      text: '%',
                      color: const Color(0xFF552cf6),
                      value: 1,
                      onIconTap: () {},
                      onChanged: (double value) async {},
                      onChangeEnd: (value) {},
                    ),
                  ),
                ),
                MenuSubItem(
                  leading: 'Скорость',
                  value: 1,
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: SoundSlider(
                      title: 'Скорость',
                      text: '%',
                      // icon: Icons.volume_up_outlined,

                      color: const Color(0xFF475df9),
                      value: 1,
                      onIconTap: () {},
                      onChanged: (double value) async {},
                      onChangeEnd: (value) {},
                    ),
                  ),
                ),
                MenuSubItem(
                  leading: 'Высота',
                  value: 1,
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: SoundSlider(
                      title: 'Высота',
                      text: '%',
                      color: const Color(0xFF5aa9f7),
                      value: 1,
                      onIconTap: () {},
                      onChanged: (double value) {},
                      onChangeEnd: (value) {},
                    ),
                  ),
                ),
                const VoiceItem()
              ],
            ),
          ),
        )
      ],
    );
  }
}
