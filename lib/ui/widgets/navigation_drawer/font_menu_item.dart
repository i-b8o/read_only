import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/menu_item.dart';

import 'font_slider.dart';
import 'menu_sub_item.dart';
import 'navigation_drawer_model.dart';

class FontMenuItem extends StatelessWidget {
  const FontMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final _model = context.watch<NavigationDrawerViewModel>();
    final _fontSize = _model.appSettings!.fontSize;
    final _fontWeight = _model.appSettings!.fontWeight.toDouble();
    final _onFontSizeChanged = _model.onFontSizeChanged;
    final _onFontSizeChangeEnd = _model.onFontSizeChangeEnd;
    L.info("And here: $_fontSize");
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
              Consumer<NavigationDrawerViewModel>(
                  builder: (context, _model, child) {
                return MenuSubItem(
                  leading: 'Размер',
                  value: 11,
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: FontSlider(
                      title: 'Размер',
                      // text: 'text%',
                      color: const Color(0xFF5aa9f7),
                      value: _fontSize / 40,
                      onChanged: (double value) {
                        _onFontSizeChanged(value);
                      },
                      onChangeEnd: (value) {
                        _onFontSizeChangeEnd(value);
                      },
                    ),
                  ),
                );
              }),
              MenuSubItem(
                leading: 'Насыщенность',
                value: _model.appSettings!.fontSize,
                alertDialog: AlertDialog(
                  backgroundColor:
                      Theme.of(context).navigationRailTheme.backgroundColor,
                  content: FontSlider(
                    title: 'Насыщенность',
                    color: const Color(0xFF5aa9f7),
                    value: _fontWeight,
                    onChanged: (double value) {
                      L.info("Weight onChanged: $value");
                    },
                    onChangeEnd: (value) {
                      L.info("Weight onChangeEnd: $value");
                    },
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
