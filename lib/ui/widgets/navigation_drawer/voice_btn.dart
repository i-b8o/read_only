import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/domain/entity/speak_state.dart';

import 'navigation_drawer_model.dart';

class VoiceBtn extends StatefulWidget {
  const VoiceBtn({
    Key? key,
    required this.color,
    required this.stopSpeak,
  }) : super(key: key);
  final Color color;
  final Future<void> Function() stopSpeak;
  @override
  State<VoiceBtn> createState() => _VoiceBtnState();
}

class _VoiceBtnState extends State<VoiceBtn> {
  @override
  Future<void> dispose() async {
    L.info("_VoiceBtnState message disposed");
    widget.stopSpeak();
    super.dispose();
  }

  @override
  void initState() {
    L.info("_VoiceBtnState message inited");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DrawerViewModel>();
    final state = model.speakState;
    final onTap =
        state == SpeakState.speaking ? model.stopSpeak : model.startSpeak;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          state == SpeakState.speaking
              ? Icons.volume_off_outlined
              : Icons.volume_up_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
