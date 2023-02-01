package com.b8o.read_only
import io.flutter.Log
import android.os.Build
import android.os.Bundle
import android.content.Context
import android.speech.tts.*
import java.util.*
import kotlin.collections.ArrayList
import kotlinx.coroutines.*
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.launch


class VoiceService(context:Context): TextToSpeech.OnInitListener {
    private val tag = "Voice"
    private val googleTtsEngine = "com.google.android.tts"
    private var currentText: List<String>? = null
    private var speaking = false
    private var currentPartIndex = 0
    private var start = 0
    private var end = 0
    private var totalParts: Int = 0
    private var currentLanguageTag = "ru-RU"
    private var bundle: Bundle = Bundle()
    private val SYNTHESIZE_TO_FILE_PREFIX = "STF_"
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
            currentPartIndex++
            Log.d(tag, "currentPartIndex: $currentPartIndex")
            Log.d(tag, "Utterance ID has started: $utteranceId")
        }

        override fun onDone(utteranceId: String) {
            Log.d(tag, "CURRENT $currentPartIndex TOTAL $totalParts")
            if (currentPartIndex == totalParts){
                speaking = false
                currentText = null
                currentPartIndex = 0
                Log.d(tag, "All Utterance has completed")
            }
            Log.d(tag, "Utterance ID has completed: $utteranceId")
        }

        override fun onStop(utteranceId: String, interrupted: Boolean) {
            Log.d(tag,"Utterance ID has been stopped: $utteranceId. Interrupted: $interrupted")
        }

        private fun onProgress(utteranceId: String?, startAt: Int, endAt: Int) {
            if (utteranceId != null) {
                start = startAt
                end = endAt
                Log.d(tag,"Utterance ID: $utteranceId on progress startAt $startAt. andAt: $endAt, $currentPartIndex == $totalParts")
            }
        }

        override fun onRangeStart(utteranceId: String, startAt: Int, endAt: Int, frame: Int) {
            if (!utteranceId.startsWith(SYNTHESIZE_TO_FILE_PREFIX)) {
                onProgress(utteranceId, startAt, endAt)
            }
        }
        @Deprecated("")
        override fun onError(utteranceId: String) {
            Log.d(tag,"Utterance ID: $utteranceId ")
        }

        override fun onError(utteranceId: String, errorCode: Int) {
            if (utteranceId.startsWith(SYNTHESIZE_TO_FILE_PREFIX)) {
                Log.d(tag,"Utterance ID: $utteranceId on ")
            }
        }
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

    fun speak(ch: Channel<Int>, texts:List<String>){
        Log.d(tag, "speaking")
        if (texts.isEmpty()) return
        speaking = true
        currentText = texts
        Log.d(tag, "texts: $texts currentText: $currentText")
        currentPartIndex = 0
        totalParts = texts.size
        Log.d(tag, "totalParts: $totalParts")
        for (text:String in texts){
            tts!!.speak(text, TextToSpeech.QUEUE_ADD, null,"")
        }
        waitSpeakFinish(ch)
    }

    fun resume (ch: Channel<Int>){
        if (currentText == null) {
            CoroutineScope(Dispatchers.IO).launch {
                ch.send(0)
                ch.close()
            }
            return
        }
        if (currentText!!.isEmpty()) return
        var temp = currentText
        if (temp != null){
           var texts = temp.subList(currentPartIndex-1, totalParts)
            for (text:String in texts){
                tts!!.speak(text, TextToSpeech.QUEUE_ADD, null,"")
            }
        }
        waitSpeakFinish(ch)
    }

    private fun waitSpeakFinish(ch: Channel<Int>){
        CoroutineScope(Dispatchers.IO).launch {
            while (speaking){}
            Log.d(tag, "sending...")
            ch.send(1)
            Log.d(tag, "sent successfully")
            ch.close()
            Log.d(tag, "closed")
        }
    }

    fun pause() {
        tts!!.stop()
    }

    fun stop(){
        tts!!.stop()
        currentText = null
        currentPartIndex = 0
        start = 0
        end = 0

    }
}