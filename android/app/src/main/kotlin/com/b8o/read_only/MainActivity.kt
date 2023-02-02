package com.b8o.read_only
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.util.*
import android.os.Build
import io.flutter.Log
import kotlinx.coroutines.*
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.launch
import android.os.Handler
import android.os.Bundle
import java.util.Objects;


class MainActivity: FlutterActivity() {
    private val TTS_CHANNEL = "com.b8o.read_only/tts"
    private val TTS_POSITION_CHANNEL = "com.b8o.read_only/tts_pos"
    private var attachEvent: EventChannel.EventSink? = null
    private var count = 1
    private var handler: Handler? = null


    private val TAG_NAME = "MainActivity"

    private val runnable: Runnable = object : Runnable {

        override fun run() {
            val TOTAL_COUNT = 100
            if (count > TOTAL_COUNT) {
                attachEvent!!.endOfStream()
            } else {
                val percentage = count as Double / TOTAL_COUNT
                Log.w(TAG_NAME, "\nParsing From Native:  $percentage")
                attachEvent!!.success(percentage)
            }
            count++
            handler!!.postDelayed(this, 200)
        }
    }

    override protected fun onDestroy() {
        super.onDestroy()
        handler!!.removeCallbacks(runnable)
        handler = null
        attachEvent = null
    }




    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        var voice = VoiceService(this)
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
                   result.success(voice.getEngines())
               }
               "getLanguages" -> {
                   result.success(voice.getLanguages())
               }
               "getVoices" -> {
                   result.success(voice.getVoices())
               }
               "setLanguage" -> {
                   val language: String = call.arguments.toString()
                   result.success(voice.setLanguage(language))
               }
               "setVoice" -> {
                   val name: String? = call.arguments()
                   result.success(voice.setVoice(name))
               }
//               TODO doesn't work
               "setVolume" -> {
                   var value : String = call.arguments.toString()

                   try {
                       val newVolume: Float = value.toFloat()
                       voice.setVolume(newVolume)
                       result.success(true)
                   } catch (e: NumberFormatException) {
                       Log.e(TAG_NAME, "toFloat: " + e.message)
                       result.success(false)
                   }
                }
               "setPitch" -> {
                    var value : String = call.arguments.toString()
                    try {
                        val newPitch: Float = value.toFloat()
                        voice.setPitch(newPitch)
                        result.success(true)
                    } catch (e: NumberFormatException) {
                        Log.e(TAG_NAME, "toFloat: " + e.message)
                        result.success(false)
                    }
               }
               "setSpeechRate" -> {
                   var value : String = call.arguments.toString()
                   try {
                       val newSpeechRate: Float = value.toFloat()
                       result.success(voice.setSpeechRate(newSpeechRate))
                   } catch (e: NumberFormatException) {
                       Log.e(TAG_NAME, "toFloat: " + e.message)
                       result.success(false)
                   }
               }
               "speak" -> {
                   var text = call.arguments.toString()
                   val ch = Channel<Int>()
                   voice.speak(ch, text)
                   CoroutineScope(Dispatchers.IO).launch {
                       ch.receive()
                       result.success(true)
                   }
               }

              "stop" -> {
                   voice.stop()
               }

            }

        }
    }
}

