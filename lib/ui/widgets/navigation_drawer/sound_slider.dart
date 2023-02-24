import 'package:flutter/material.dart';

import 'voice_btn.dart';

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
