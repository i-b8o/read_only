import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

import 'voice_btn.dart';

class SoundPitchSlider extends StatelessWidget {
  const SoundPitchSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final pitchValue = model.appSettings!.pitch;
    final pitchValueStr = (pitchValue * 100).toStringAsFixed(0);
    final onPitchChangeEnd = model.onPitchChangeEnd;
    final onPitchChanged = model.onPitchChanged;
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      child: Row(
        children: [
          const VoiceBtn(
            color: Color(0xFF475df9),
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
                        'Высота',
                        style: Theme.of(context)
                            .navigationRailTheme
                            .unselectedLabelTextStyle,
                      ),
                      Text(
                        '$pitchValueStr%',
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
                    onChanged: onPitchChanged,
                    onChangeEnd: onPitchChangeEnd,
                    value: pitchValue,
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
