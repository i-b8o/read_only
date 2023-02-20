import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/sql/init.dart';

// TODO highlighting
class ReadOnlyNavigationDrawer extends StatelessWidget {
  const ReadOnlyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          ))
                        ])))
            : Container();
      },
    );
  }
}

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

class NavDrawerMenuItem extends StatelessWidget {
  const NavDrawerMenuItem({
    Key? key,
    this.children,
    required this.leadingIconData,
    required this.title,
    this.trailing,
    required this.onExpansionChanged,
  }) : super(key: key);
  final List<Widget>? children;
  final IconData leadingIconData;
  final void Function(bool)? onExpansionChanged;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: onExpansionChanged,
      trailing: trailing,
      backgroundColor: Theme.of(context).navigationRailTheme.indicatorColor,
      collapsedBackgroundColor:
          Theme.of(context).navigationRailTheme.backgroundColor,
      iconColor: Theme.of(context).navigationRailTheme.selectedIconTheme!.color,
      collapsedIconColor:
          Theme.of(context).navigationRailTheme.unselectedIconTheme!.color,
      textColor:
          Theme.of(context).navigationRailTheme.selectedLabelTextStyle!.color,
      collapsedTextColor:
          Theme.of(context).navigationRailTheme.unselectedLabelTextStyle!.color,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
        child: Text(
          title,
        ),
      ),
      leading: Icon(
        leadingIconData,
      ),
      children: children == null
          ? [Container()]
          : [
              Container(
                  color: Theme.of(context).navigationRailTheme.backgroundColor,
                  child: Column(children: children!))
            ],
    );
  }
}

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
                onTap: () async {
                  // TODO Drop
                  // await SqfliteClient.deleteDatabaseWithName(InitSQL.dbName);
                  L.info("database deleted");
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

class FontSlider extends StatelessWidget {
  const FontSlider({
    Key? key,
    required this.title,
    required this.color,
    required this.onChangeEnd,
    required this.onChanged,
    required this.text,
    required this.value,
  }) : super(key: key);
  final String title;
  final String text;
  final Color color;
  final double value;

  final void Function(double)? onChangeEnd;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Текст',
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Slider(
                    divisions: 7,
                    activeColor: color,
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: onChanged,
                    onChangeEnd: onChangeEnd,
                    value: value,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuSubItem extends StatelessWidget {
  const MenuSubItem({
    Key? key,
    required this.leading,
    required this.value,
    required this.alertDialog,
  }) : super(key: key);
  final String leading;
  final double value;
  final AlertDialog alertDialog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return alertDialog;
            });
      },
      child: Container(
        color: Theme.of(context).navigationRailTheme.backgroundColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leading,
              style: TextStyle(
                color: Theme.of(context)
                    .navigationRailTheme
                    .unselectedLabelTextStyle!
                    .color,
              ),
            ),
            Text(
              '${(value * 100).round()}%',
              style: TextStyle(
                color: Theme.of(context)
                    .navigationRailTheme
                    .unselectedLabelTextStyle!
                    .color,
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

class SoundSlider extends StatelessWidget {
  const SoundSlider({
    Key? key,
    required this.title,
    required this.color,
    required this.onChangeEnd,
    required this.onChanged,
    required this.text,
    required this.value,
    required this.onIconTap,
  }) : super(key: key);
  final String title;
  final String text;
  final Color color;
  final double value;

  final void Function(double)? onChangeEnd;
  final void Function(double)? onChanged;
  final void Function()? onIconTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      child: Row(
        children: [
          VoiceBtn(
            color: color,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .navigationRailTheme
                            .unselectedLabelTextStyle,
                      ),
                      Text(
                        text,
                        style: Theme.of(context)
                            .navigationRailTheme
                            .unselectedLabelTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Slider(
                    activeColor: color,
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: onChanged,
                    onChangeEnd: onChangeEnd,
                    value: value,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VoiceBtn extends StatelessWidget {
  const VoiceBtn({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          true ? Icons.volume_off_outlined : Icons.volume_up_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class VoiceItem extends StatelessWidget {
  const VoiceItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>? _voices = ["aaa", "bbb", "ccc"];
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              List<DropdownMenuItem<String>> _items = _voices
                  .map((v) => DropdownMenuItem(
                        value: v,
                        child: Text(v),
                      ))
                  .toList();
              return AlertDialog(
                backgroundColor:
                    Theme.of(context).navigationRailTheme.backgroundColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const VoiceBtn(
                      color: Color(0xFF5ec8ad),
                    ),
                    DropdownButton(
                      items: _items,
                      value: "state.voice",
                      style: Theme.of(context)
                          .navigationRailTheme
                          .unselectedLabelTextStyle,
                      dropdownColor:
                          Theme.of(context).navigationRailTheme.backgroundColor,
                      onChanged: (String? value) {},
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        color: Theme.of(context).navigationRailTheme.backgroundColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Голос',
              style: TextStyle(
                color: Theme.of(context)
                    .navigationRailTheme
                    .unselectedLabelTextStyle!
                    .color,
              ),
            ),
            const Text("state.voice"),
          ],
        ),
      ),
    );
  }
}
