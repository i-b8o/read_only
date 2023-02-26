import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/app/app_model.dart';

class FontWeightSlider extends StatelessWidget {
  const FontWeightSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final model = context.watch<AppViewModel>();
    final value = model.getFontWeightDouble();
    final onFontWeightChangeEnd = model.onFontWeightChangeEnd;
    final weights = [
      'W200',
      'W400',
      'W600',
      'W800',
    ];
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weights
            .map((fontWeight) => GestureDetector(
                  onTap: () => onFontWeightChangeEnd(
                      (weights.indexOf(fontWeight) + 1) * 2),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF5aa9f7),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    alignment: Alignment.center,
                    height: screenWidth * 0.1,
                    width: screenWidth * 0.14,
                    child: Text(
                      fontWeight,
                      style: TextStyle(
                          fontSize: screenWidth * 0.02, color: Colors.white),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
