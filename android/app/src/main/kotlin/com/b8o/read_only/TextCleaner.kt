package com.b8o.read_only
import org.jsoup.Jsoup

interface TextCleaner {
    fun dropHtml(text:String):String
    fun dropPunctuations(text: String): String
}

class TextCleanerDefault : TextCleaner {
    override fun dropHtml(textWithHtml: String): String {
        return Jsoup.parse(textWithHtml).text();
    }

    override fun dropPunctuations(text: String): String {
        return text.replace("[!\"#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]".toRegex(), "")
    }

}