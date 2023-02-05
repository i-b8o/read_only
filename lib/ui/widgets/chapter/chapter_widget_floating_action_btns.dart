import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chapter_model.dart';

class ChapterWidgetFloatingActionBtns extends StatelessWidget {
  const ChapterWidgetFloatingActionBtns({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ChapterViewModel>();
    final state = model.speakState;
    if (state == SpeakState.silence) {
      return Container();
    } else if (state == SpeakState.speaking) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              model.pauseSpeak();
            },
            child: const Icon(Icons.pause),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.025,
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              model.stopSpeak();
            },
            child: const Icon(Icons.stop),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
            model.resumeSpeak();
          },
          child: const Icon(Icons.play_arrow),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.025,
        ),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () {
            model.stopSpeak();
          },
          child: const Icon(Icons.stop),
        ),
      ],
    );
  }
}
