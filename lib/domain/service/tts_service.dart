import 'package:read_only/library/text/text.dart';
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
    final clearText = parseHtmlString(text);
    // return await ttsClient.speak(clearText);
  }

  @override
  Future<void> stopSpeak() async {
    // return await ttsClient.stop();
  }
}
