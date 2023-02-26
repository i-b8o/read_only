import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';
import 'package:rolling_switch/rolling_switch.dart';

import 'font_menu_item.dart';
import 'notes_menu_item.dart';
import 'sound_menu_item.dart';

// TODO highlighting
class ReadOnlyNavigationDrawer extends StatelessWidget {
  const ReadOnlyNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    if (model.appSettings == null) {
      return Container();
    }
    final rollingSwitchInitState = model.appSettings!.darkModeOn;
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Drawer(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                    ),
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: ((context, index) {
                                if (index == 0) {
                                  return const NotesMenuItem();
                                } else if (index == 1) {
                                  return const FontMenuItem(index: 1);
                                }
                                return const SoundMenuItem(index: 2);
                              }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              leading: Icon(Icons.dark_mode,
                                  color: Theme.of(context).indicatorColor),
                              trailing: Transform.scale(
                                scale: 0.7,
                                child: RollingSwitch.widget(
                                  initialState: rollingSwitchInitState,
                                  onChanged: (bool state) {
                                    model.onDarkModeStateChanged();
                                  },
                                  rollingInfoRight: RollingWidgetInfo(
                                      icon: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFff9500),
                                            shape: BoxShape.circle),
                                      ),
                                      backgroundColor: const Color(0xFF191c1e),
                                      text: const Text('ВКЛ')),
                                  rollingInfoLeft: RollingWidgetInfo(
                                    backgroundColor: const Color(0xFFfdecd9),
                                    text: const Text(
                                      'ВЫКЛ',
                                      style:
                                          TextStyle(color: Color(0xFF5a5a5a)),
                                    ),
                                    icon: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFff9500),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])))
            : Container();
      },
    );
  }
}
