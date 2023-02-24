import 'package:flutter/material.dart';

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
