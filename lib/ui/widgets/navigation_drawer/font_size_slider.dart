import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app/app_model.dart';

class FontSizeSlider extends StatelessWidget {
  const FontSizeSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AppViewModel>();
    double absValue = model.getFontSizeInAbs();

    final onFontSizeChanged = model.onFontSizeChanged;
    final onFontSizeChangeEnd = model.onFontSizeChangeEnd;
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
                    divisions: 5,
                    activeColor: const Color(0xFF5aa9f7),
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: (double val) => onFontSizeChanged(val),
                    onChangeEnd: (double val) => onFontSizeChangeEnd(val),
                    value: absValue,
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
