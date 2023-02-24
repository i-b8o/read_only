import 'package:flutter/material.dart';

import 'voice_btn.dart';

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
