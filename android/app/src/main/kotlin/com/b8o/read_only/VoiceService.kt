package com.b8o.read_only
import io.flutter.Log
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.speech.tts.*
import java.util.*
import kotlin.collections.ArrayList
import kotlinx.coroutines.*
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.launch
import io.flutter.plugin.common.EventChannel


class VoiceService(context:Context, sink:EventChannel.EventSink?): TextToSpeech.OnInitListener {
    private val TAG_NAME = "Voice"
    private val googleTtsEngine = "com.google.android.tts"
    private var speaking = false
    private var currentLanguageTag = "ru-RU"
    private var bundle: Bundle = Bundle()
    private val SYNTHESIZE_TO_FILE_PREFIX = "STF_"
    private var tts = TextToSpeech(context, this, googleTtsEngine)

    fun onDestroy(){
        tts.shutdown()
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts!!.setOnUtteranceProgressListener(utteranceProgressListener)
            val result = tts!!.setLanguage(Locale.US)
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                println("The Language not supported!")
            }
        }
    }

    private val utteranceProgressListener: UtteranceProgressListener =
        object : UtteranceProgressListener() {
        override fun onStart(utteranceId: String) {

        }

        override fun onDone(utteranceId: String) {

            speaking = false
        }

        override fun onStop(utteranceId: String, interrupted: Boolean) {
            speaking = false

        }

        private fun onProgress(utteranceId: String?, startAt: Int, endAt: Int) {
            if (sink == null) return
            val values  = listOf<Int>(startAt, endAt)
            (context as FlutterActivity).runOnUiThread {
                sink.success(values)
            }

        }

        override fun onRangeStart(utteranceId: String, startAt: Int, endAt: Int, frame: Int) {
            if (!utteranceId.startsWith(SYNTHESIZE_TO_FILE_PREFIX)) {
                onProgress(utteranceId, startAt, endAt)
            }
        }
        @Deprecated("")
        override fun onError(utteranceId: String) {
        }

        override fun onError(utteranceId: String, errorCode: Int) {
            if (utteranceId.startsWith(SYNTHESIZE_TO_FILE_PREFIX)) {
            }
        }
    }

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
                    }
                }
            }
        } catch (e: MissingResourceException) {
            Log.d(TAG_NAME, "getLanguages: " + e.message)
        } catch (e: NullPointerException) {
            Log.d(TAG_NAME, "getLanguages: " + e.message)
        }
        return languages
    }

    //    TODO getVoices with their features
    fun getVoices():ArrayList<String>? {
        val voices = ArrayList<String>()
        try {
            for (voice in tts!!.getVoices()) {
                if (voice.getLocale().toLanguageTag() != currentLanguageTag){
                    continue
                }
                val voice = voice.name as String
                voices.add(voice)
            }
            return voices
        } catch (e: NullPointerException) {
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
        Log.d(TAG_NAME, "Voice name not found: $voiceName")
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

    fun speak(ch: Channel<Int>, text:String){
        speaking = true
        tts!!.speak(text, TextToSpeech.QUEUE_ADD, null,"")
        waitSpeakFinish(ch)
    }

    private fun waitSpeakFinish(ch: Channel<Int>){
        CoroutineScope(Dispatchers.IO).launch {
            while (speaking){}
            ch.send(1)
            ch.close()
        }
    }

    fun stop(ch: Channel<Int>){
        tts!!.stop()
        waitSpeakFinish(ch)
    }
}