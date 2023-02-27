import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

import 'voice_btn.dart';

class SoundRateSlider extends StatelessWidget {
  const SoundRateSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final rateValue = model.appSettings!.speechRate;
    final rateValueStr = (rateValue * 100).toStringAsFixed(0);
    final onRateChangeEnd = model.onRateChangeEnd;
    final onRateChanged = model.onRateChanged;
    final stopSpeak = model.stopSpeak;
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      child: Row(
        children: [
          VoiceBtn(
            color: const Color(0xFF475df9),
            stopSpeak: stopSpeak,
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
                        'Скорость',
                        style: Theme.of(context)
                            .navigationRailTheme
                            .unselectedLabelTextStyle,
                      ),
                      Text(
                        '$rateValueStr%',
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
                    activeColor: const Color(0xFF475df9),
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: onRateChanged,
                    onChangeEnd: onRateChangeEnd,
                    value: rateValue,
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
