import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/navigation_drawer_model.dart';

import 'voice_btn.dart';

class SoundVolumeSlider extends StatelessWidget {
  const SoundVolumeSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final volumValue = model.appSettings!.volume;
    final volumValueStr = (volumValue * 100).toStringAsFixed(0);

    final onVolumeChangeEnd = model.onVolumeChangeEnd;
    final onVolumeChanged = model.onVolumeChanged;
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      child: Row(
        children: [
          const VoiceBtn(
            color: Color(0xFF552cf6),
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
                        'Громкость',
                        style: Theme.of(context)
                            .navigationRailTheme
                            .unselectedLabelTextStyle,
                      ),
                      Text(
                        "$volumValueStr%",
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
                    activeColor: const Color(0xFF552cf6),
                    inactiveColor: const Color(0xFFedecf1),
                    onChanged: onVolumeChanged,
                    onChangeEnd: onVolumeChangeEnd,
                    value: volumValue,
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
