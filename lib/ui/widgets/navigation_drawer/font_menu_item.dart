import 'package:flutter/material.dart';
import 'package:read_only/ui/widgets/navigation_drawer/menu_item.dart';

import 'font_slider.dart';
import 'menu_sub_item.dart';

class FontMenuItem extends StatelessWidget {
  const FontMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      leadingIconData: Icons.font_download_outlined,
      title: 'Шрифт',
      // index: index,
      onExpansionChanged: (bool) {},
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SingleChildScrollView(
                child: Column(children: [
              MenuSubItem(
                leading: 'Размер',
                value: 11,
                alertDialog: AlertDialog(
                  backgroundColor:
                      Theme.of(context).navigationRailTheme.backgroundColor,
                  content: FontSlider(
                    title: 'Размер',
                    text: 'text%',
                    color: const Color(0xFF5aa9f7),
                    value: 11,
                    onChanged: (double value) {},
                    onChangeEnd: (value) {},
                  ),
                ),
              ),
              MenuSubItem(
                leading: 'Насыщенность',
                value: 11,
                alertDialog: AlertDialog(
                  backgroundColor:
                      Theme.of(context).navigationRailTheme.backgroundColor,
                  content: FontSlider(
                    title: 'Насыщенность',
                    text: "",
                    color: const Color(0xFF5aa9f7),
                    value: 11,
                    onChanged: (double value) {},
                    onChangeEnd: (value) {},
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  color: Theme.of(context).navigationRailTheme.backgroundColor,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сбросить настройки",
                        style: TextStyle(
                          color: Theme.of(context)
                              .navigationRailTheme
                              .unselectedLabelTextStyle!
                              .color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])),
          ),
        )
      ],
    );
  }
}
