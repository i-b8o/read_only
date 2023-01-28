package com.b8o.read_only
import android.content.Context
import android.speech.tts.*
import android.speech.tts.TextToSpeech
import java.util.*

class Voice(context:Context): TextToSpeech.OnInitListener {
    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts!!.setLanguage(Locale.US)
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                println("The Language not supported!")
            }
        }
    }

    private var tts = TextToSpeech(context, this)
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
