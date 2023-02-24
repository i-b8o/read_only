import 'package:flutter/material.dart';

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
