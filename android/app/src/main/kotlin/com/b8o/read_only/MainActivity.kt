package com.b8o.read_only
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel



class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.b8o.read_only"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        var tts = Voice(this)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when(call.method){
                "speak" -> {
                    var text = call.arguments.toString()
                    var cleaner = TextCleanerDefault()
                    var reducer = TextReducerDefault(cleaner)
                    var handler = TextHandler(text, cleaner, reducer)
                    tts.speak(handler.apply())
                }
                "stop" -> {
                    tts.stop()
                }
            }

        }
    }
}

