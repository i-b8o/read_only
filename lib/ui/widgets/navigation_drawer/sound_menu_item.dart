import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/sound_rate_slider.dart';
import 'package:read_only/ui/widgets/navigation_drawer/sound_volume_slider.dart';
import 'navigation_drawer_model.dart';
import 'menu_item.dart';
import 'menu_sub_item.dart';
import 'sound_pitch_slider.dart';
import 'voice_item.dart';

class SoundMenuItem extends StatelessWidget {
  const SoundMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final volumeValue = model.appSettings!.volume;
    final volumeValueStr = (volumeValue * 100).toStringAsFixed(0);
    final rateValue = model.appSettings!.speechRate;
    final rateValueStr = (rateValue * 100).toStringAsFixed(0);
    final pitchValue = model.appSettings!.pitch;
    final pitchValueStr = (pitchValue * 100).toStringAsFixed(0);
    final onExpanded = model.getVoices;
    return NavDrawerMenuItem(
      leadingIconData: Icons.volume_up_outlined,
      title: 'Звук',
      onExpansionChanged: (bool) => onExpanded(),
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                MenuSubItem(
                  value: volumeValueStr,
                  leading: 'Громкость',
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: SoundVolumeSlider(),
                  ),
                ),
                MenuSubItem(
                  leading: 'Скорость',
                  value: rateValueStr,
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: SoundRateSlider(),
                  ),
                ),
                MenuSubItem(
                  leading: 'Высота',
                  value: pitchValueStr,
                  alertDialog: AlertDialog(
                    backgroundColor:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    content: const SoundPitchSlider(),
                  ),
                ),
                const VoiceItem()
              ],
            ),
          ),
        )
      ],
    );
  }
}
