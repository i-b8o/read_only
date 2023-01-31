import 'package:read_only/main.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsProvider {}

class TtsService implements ChapterViewModelTtsService {
  const TtsService();
  @override
  Future<void> pauseSpeak() async {
    await ttsChannel.invokeMethod("pause");
  }

  @override
  Future<bool> startSpeak(String text) async {
    if (text.isEmpty) {
      return false;
    }
    print("Speaking started!");
    bool ok = await ttsChannel.invokeMethod("speak", text);
    print("Speaking stoped with $ok");
    return ok;
  }

  @override
  Future<void> stopSpeak() async {
    await ttsChannel.invokeMethod("stop");
  }
  @override
  Future<dynamic> getLanguages() async {
    final languages = await ttsChannel.invokeMethod('getLanguages');
    return languages;
  }

  Future<bool> highlighting() async{
    return await ttsChannel.invokeMethod("highlighting") as bool;
  }

  @override
  Future<List<String>?> getVoices() async {
    final voices = await ttsChannel.invokeMethod('getVoices') as List<dynamic>?;
    if (voices != null){
      return List<String>.from(voices);
    }
    return null;
  }

  @override
  Future<bool> setLanguage(String language) async {
    return await ttsChannel.invokeMethod('setLanguage', language) as bool;
  }

  Future<bool> setVoice(String voice) async =>
      await ttsChannel.invokeMethod('setVoice', voice) as bool;

  @override
  Future<bool> setVolume(double volume) async =>
      await ttsChannel.invokeMethod('setVolume', volume) as bool;

  Future<bool> setPitch(double pitch) async =>
      await ttsChannel.invokeMethod('setPitch', pitch) as bool;

  @override
  Future<bool> setSpeechRate(double rate) async =>
      await ttsChannel.invokeMethod('setSpeechRate', rate) as bool;
}
