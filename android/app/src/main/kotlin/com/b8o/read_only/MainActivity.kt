package com.b8o.read_only
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*
import android.os.Build
import io.flutter.Log


class MainActivity: FlutterActivity() {
    private val TTS_CHANNEL = "com.b8o.read_only/tts"
    private val tag = "MainActivity"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        var tts = VoiceService(this)
        var cleaner = TextCleanerDefault()
        var reducer = TextReducerDefault(cleaner)
        var handler = TextHandler(cleaner, reducer)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TTS_CHANNEL).setMethodCallHandler { call, result ->
           when(call.method){

               "highlighting" -> {
                    var good: Boolean
                    good = Build.VERSION.SDK_INT >= 26
                    result.success(good)
                }
               "getEngines" -> {
                   result.success(tts.getEngines())
               }
               "getLanguages" -> {
                   result.success(tts.getLanguages())
               }
               "getVoices" -> {
                   result.success(tts.getVoices())
               }
               "setLanguage" -> {
                   val language: String = call.arguments.toString()
                   result.success(tts.setLanguage(language))
               }
               "setVoice" -> {
                   val voice: String? = call.arguments()
                   result.success(tts.setVoice(voice))
               }
//               TODO doesn't work
               "setVolume" -> {
                   var value : String = call.arguments.toString()

                   try {
                       val newVolume: Float = value.toFloat()
                       tts.setVolume(newVolume)
                       result.success(true)
                   } catch (e: NumberFormatException) {
                       Log.e(tag, "toFloat: " + e.message)
                       result.success(false)
                   }
                }
               "setPitch" -> {
                    var value : String = call.arguments.toString()
                    try {
                        val newPitch: Float = value.toFloat()
                        tts.setPitch(newPitch)
                        result.success(true)
                    } catch (e: NumberFormatException) {
                        Log.e(tag, "toFloat: " + e.message)
                        result.success(false)
                    }
               }


               "setSpeechRate" -> {
                   var value : String = call.arguments.toString()
                   try {
                       val newSpeechRate: Float = value.toFloat()
                       result.success(tts.setSpeechRate(newSpeechRate))
                   } catch (e: NumberFormatException) {
                       Log.e(tag, "toFloat: " + e.message)
                       result.success(false)
                   }
               }
               "speak" -> {
                   var text = call.arguments.toString()
                   tts.speak(handler.apply(text))

               }
               "paause" -> {
                   tts.stop()
               }
               "stop" -> {
                   tts.stop()
               }

            }

        }
    }
}

