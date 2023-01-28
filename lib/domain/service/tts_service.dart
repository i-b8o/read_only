import 'package:read_only/main.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsProvider {}

class TtsService implements ChapterViewModelTtsService {
  const TtsService();
  @override
  Future<void> pauseSpeak() async {
    // return await ttsClient.pause();
  }

  @override
  Future<void> startSpeak(String text) async {
    if (text.isEmpty) {
      return;
    }
    await platform.invokeMethod("speak", text);
  }

  @override
  Future<void> stopSpeak() async {
    await platform.invokeMethod("stop");
  }
}
