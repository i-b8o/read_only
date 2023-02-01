import 'package:read_only/main.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class TtsProvider {}

class TtsService implements ChapterViewModelTtsService {
  TtsService();

  int _currentParagraphIndex = 0;
  List<String> _texts = [];

  Future<bool> _speak(List<String> texts) async {
   for (var i = 0; i < texts.length; i++) {
      _currentParagraphIndex = i;
      final text = texts[i].trim();
      bool ok = await ttsChannel.invokeMethod("speak", text);
      if (!ok){
        print("was returned false in _speak");
        return false;
      }
    }
    return true;
  }

  @override
  Future<bool> startSpeak(List<String> texts) async {
    if (texts.isEmpty) {
      return false;
    }
    _texts = texts;
    return await _speak(texts);
  }

  @override
  Future<bool> resumeSpeak() async {
    print("resume");
    bool ok = await ttsChannel.invokeMethod("resume");
    if (!ok){
      print("was returned false in _resumespeak");
      return false;
    }
    final texts = _texts.skip(_currentParagraphIndex+1).toList();
    print("resumeSpeak ${texts.length}");
    return await _speak(texts);

  }

  @override
  Future<void> pauseSpeak() async {
    await ttsChannel.invokeMethod("pause");
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
