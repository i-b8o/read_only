import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';

import 'navigation_drawer_model.dart';

class FontSlider extends StatelessWidget {
  FontSlider({
    Key? key,
    required this.title,
    required this.color,
    required this.onChangeEnd,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final String title;
  final Color color;
  final double value;

  final void Function(double)? onChangeEnd;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NavigationDrawerViewModel>();
    L.info("Here value: $value ");
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
                    onChanged: (double value) => onChanged!(value),
                    onChangeEnd: (double value) => onChangeEnd!(value),
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
