import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app/app_model.dart';

class FontWeightSlider extends StatelessWidget {
  const FontWeightSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AppViewModel>();
    final value = model.getFontWeightDouble();
    final onFontWeightChanged = model.onFontWeightChanged;
    final onFontWeightChangeEnd = model.onFontWeightChangeEnd;
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
                    divisions: 10,
                    activeColor: const Color(0xFF5aa9f7),
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: (double value) => onFontWeightChanged(value),
                    onChangeEnd: (double value) => onFontWeightChangeEnd(value),
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
