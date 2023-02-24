import 'package:flutter/material.dart';

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
