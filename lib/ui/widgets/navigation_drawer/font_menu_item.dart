import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';
import 'package:read_only/ui/widgets/navigation_drawer/menu_item.dart';

import 'font_size_slider.dart';
import 'font_weight_slider.dart';
import 'menu_sub_item.dart';

class FontMenuItem extends StatelessWidget {
  const FontMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    int pxValue = model.getFontSizeInPx().round();
    int fwValue = model.getFontWeight();
    final onReset = model.fontReset;

    return NavDrawerMenuItem(
      leadingIconData: Icons.font_download_outlined,
      title: 'Шрифт',
      // index: index,
      onExpansionChanged: (bool val) {
        L.info("onExpansionChanged $val");
      },
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Consumer<DrawerViewModel>(builder: (context, model, child) {
                return MenuSubItem(
                  leading: 'Размер',
                  value: "$pxValue px",
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: const FontSizeSlider(),
                  ),
                );
              }),
              MenuSubItem(
                leading: 'Насыщенность',
                value: "${fwValue}00",
                alertDialog: AlertDialog(
                  backgroundColor:
                      Theme.of(context).navigationRailTheme.backgroundColor,
                  content: const FontWeightSlider(),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await onReset();
                },
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
