package com.b8o.read_only
import io.flutter.Log
import android.os.Build
import android.os.Bundle
import android.content.Context
import android.speech.tts.*
import java.util.*
import kotlin.collections.ArrayList


class VoiceService(context:Context): TextToSpeech.OnInitListener {
    private val tag = "Voice"
    private val googleTtsEngine = "com.google.android.tts"
    private var currentText: String? = null
    private var currentLanguageTag: String = "ru-RU"
    private var bundle: Bundle = Bundle()

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts!!.setLanguage(Locale.US)
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                println("The Language not supported!")
            }
        }
    }

    private val utteranceProgressListener: UtteranceProgressListener = object : UtteranceProgressListener(){

    }

    private var tts = TextToSpeech(context, this, googleTtsEngine)
    fun getEngines():ArrayList<String>{
        val engines = ArrayList<String>()
        for (engin in tts.getEngines()){
            engines.add(engin.name)
        }
        return engines
    }
    private fun isLanguageAvailable(locale: Locale?): Boolean {
        return tts!!.isLanguageAvailable(locale) >= TextToSpeech.LANG_AVAILABLE
    }

    fun getLanguages():ArrayList<String>{
        val languages = ArrayList<String>()
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                for (locale in tts!!.availableLanguages) {
                    languages.add(locale.toLanguageTag())
                }
            } else {
                for (locale in Locale.getAvailableLocales()) {
                    if (locale.variant.isEmpty() && isLanguageAvailable(locale)) {
                        languages.add(locale.toLanguageTag())
                        Log.d(tag, "getLanguages: " + locale.toLanguageTag())
                    }
                }
            }
        } catch (e: MissingResourceException) {
            Log.d(tag, "getLanguages: " + e.message)
        } catch (e: NullPointerException) {
            Log.d(tag, "getLanguages: " + e.message)
        }
        return languages
    }

    //    TODO getVoices with their features
    fun getVoices():ArrayList<String>? {
        val voices = ArrayList<String>()
        try {
//            val voices: MutableSet<Voice> =

            for (voice in tts!!.getVoices()) {
                if (voice.getLocale().toLanguageTag() != currentLanguageTag){
                    continue
                }
                val voice = voice.name as String
                voices.add(voice)
            }
            return voices
        } catch (e: NullPointerException) {
            Log.d(tag, "getVoices: " + e.message)
            return  null
        }
    }
    fun setLanguage(languageTag: String?): Boolean {
        val locale: Locale = Locale.forLanguageTag(languageTag!!)
        if (isLanguageAvailable(locale)) {
            tts!!.setLanguage(locale)
            currentLanguageTag = languageTag
            return true
        }
            return false
    }

    fun setVoice(voiceName: String?): Boolean {
        for (ttsVoice in tts!!.voices) {
            if (ttsVoice.name == voiceName && ttsVoice.locale
                    .toLanguageTag() == currentLanguageTag
            ) {
                tts!!.setVoice(ttsVoice)
                return true
            }
        }
        Log.d(tag, "Voice name not found: $voiceName")
        return false
    }

    private fun cutOff(value: Float): Float {
        var newValue: Float = if (value < 0)  0.0f else value
        return if (newValue > 1.0f) 1.0f else value
    }
    fun setVolume(volume: Float) {
        val newVolume = cutOff(volume)
        bundle!!.putFloat(TextToSpeech.Engine.KEY_PARAM_VOLUME, newVolume)
    }
    fun setPitch(pitch: Float) {
        val newPitch = cutOff(pitch)*1.5f+0.5f
        tts!!.setPitch(newPitch)

    }
    fun setSpeechRate(pitch: Float): Boolean {
        val newSpeechRate = cutOff(pitch)*2f
        val ok: Int = tts!!.setSpeechRate(newSpeechRate)
        return ok == 1

    }
//    TODO https://stackoverflow.com/questions/58888101/flutter-how-to-get-a-data-stream-with-an-event-channel-from-native-to-the-flut
    fun speak(texts:List<String>){
        for (text:String in texts){
            tts!!.speak(text, TextToSpeech.QUEUE_FLUSH, null,"")
        }
    }
    fun stop(){
        tts!!.stop()
        tts!!.shutdown()
    }

}

//private class Voice implements TextToSpeech.OnInitListener {
//    Context context = getApplicationContext ();
//    TextToSpeech tts = new TextToSpeech(context, this);
//
//    public void onInit(int initStatus) {
//        if (initStatus == TextToSpeech.SUCCESS) {
//            tts.setLanguage(Locale.US);
//            // try it!
//            voice.say("Can you hear this sentence?");
//            // If you want to another "say", check this log.
//            // Your voice will say after you see this log at logcat.
//            Log.i("TAG", "TextToSpeech instance initialization is finished.");
//        }
//    }
//
//    private void say(String announcement) {
//        tts.speak(announcement, TextToSpeech.QUEUE_FLUSH, null);
//    }
//}
