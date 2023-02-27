import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_drawer_model.dart';
import 'voice_btn.dart';

class VoiceItem extends StatelessWidget {
  const VoiceItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final voices = model.appSettings!.voices;
    final onVoiceChanged = model.onVoiceChanged;
    final stopSpeak = model.stopSpeak;
    if (voices == null) {
      return Row(
        children: const [Text("Нет")],
      );
    }

    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              List<DropdownMenuItem<String>> items = voices
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
                    VoiceBtn(
                      color: const Color(0xFF5ec8ad),
                      stopSpeak: stopSpeak,
                    ),
                    DropdownButton(
                      items: items,
                      value: voices[0],
                      style: Theme.of(context)
                          .navigationRailTheme
                          .unselectedLabelTextStyle,
                      dropdownColor:
                          Theme.of(context).navigationRailTheme.backgroundColor,
                      onChanged: (Object? value) {
                        if (value != null) {
                          onVoiceChanged(value);
                        }
                      },
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
            Text(voices![0]),
          ],
        ),
      ),
    );
  }
}
