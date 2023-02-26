package com.b8o.read_only
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import java.util.*
import android.os.Build
import android.os.Bundle

import io.flutter.Log
import kotlinx.coroutines.*
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.launch


class MainActivity: FlutterActivity(), EventChannel.StreamHandler {
    private lateinit var voiceService: VoiceService
    private var  eventSink: EventChannel.EventSink? = null
    private val TTS_CHANNEL = "com.b8o.read_only/tts"
    private val TTS_POSITION_CHANNEL = "com.b8o.read_only/tts_pos"
    private val TAG_NAME = "MainActivity"
    


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }
    
    override protected fun onDestroy() {
        super.onDestroy()
        voiceService.onDestroy()
    }
    
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        voiceService = VoiceService(this, eventSink)
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        var positionEvent = EventChannel(flutterEngine.dartExecutor.binaryMessenger, TTS_POSITION_CHANNEL)

        positionEvent.setStreamHandler(this)
        
       
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TTS_CHANNEL).setMethodCallHandler { call, result ->
           when(call.method){

               "highlighting" -> {
                    var good: Boolean
                    good = Build.VERSION.SDK_INT >= 26
                    result.success(good)
                }
               "getEngines" -> {
                   result.success(voiceService.getEngines())
               }
               "getLanguages" -> {
                   result.success(voiceService.getLanguages())
               }
               "getVoices" -> {
                   result.success(voiceService.getVoices())
               }
               "setLanguage" -> {
                   val language: String = call.arguments.toString()
                   result.success(voiceService.setLanguage(language))
               }
               "setVoice" -> {
                   val name: String? = call.arguments()
                   Log.d(TAG_NAME, "setVoice: " + name)
                   result.success(voiceService.setVoice(name))
               }
//               TODO doesn't work
               "setVolume" -> {
                   var value : String = call.arguments.toString()
                   Log.d(TAG_NAME, "setVolume: " + value)
                   try {
                       val newVolume: Float = value.toFloat()
                        result.success(voiceService.setVolume(newVolume))
                   } catch (e: NumberFormatException) {
                       Log.e(TAG_NAME, "toFloat: " + e.message)
                       result.success(false)
                   }
                }
               "setPitch" -> {
                    var value : String = call.arguments.toString()
                    Log.d(TAG_NAME, "setPitch: " + value)
                    try {
                        val newPitch: Float = value.toFloat()
                        voiceService.setPitch(newPitch)
                        result.success(true)
                    } catch (e: NumberFormatException) {
                        Log.e(TAG_NAME, "toFloat: " + e.message)
                        result.success(false)
                    }
               }
               "setRate" -> {
                   var value : String = call.arguments.toString()
                   Log.d(TAG_NAME, "setRate: " + value)
                   try {
                       val newSpeechRate: Float = value.toFloat()
                       result.success(voiceService.setSpeechRate(newSpeechRate))
                   } catch (e: NumberFormatException) {
                       Log.e(TAG_NAME, "toFloat: " + e.message)
                       result.success(false)
                   }
               }
               "speak" -> {
                   var text = call.arguments.toString()
                   val ch = Channel<Int>()
                   voiceService.speak(ch, text)
                   CoroutineScope(Dispatchers.IO).launch {
                       ch.receive()
                       result.success(true)
                   }
               }

              "stop" -> {
                  val ch = Channel<Int>()
                   voiceService.stop(ch)
                  CoroutineScope(Dispatchers.IO).launch {
                      ch.receive()
                      result.success(true)
                  }
               }

            }

        }
    }
}

