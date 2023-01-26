import 'package:read_only/library/text/text.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:tts_client/tts_client.dart';

abstract class TtsProvider {}

class TtsService implements ChapterViewModelTtsService {
  final TtsClient ttsClient;

  const TtsService(this.ttsClient);
  @override
  Future<void> pauseSpeak() async {
    return await ttsClient.pause();
  }

  @override
  Future<void> startSpeak(String text) async {
    if (text.isEmpty) {
      return;
    }
    final clearText = parseHtmlString(text);
    return await ttsClient.speak(clearText);
  }

  @override
  Future<void> stopSpeak() async {
    return await ttsClient.stop();
  }
}
