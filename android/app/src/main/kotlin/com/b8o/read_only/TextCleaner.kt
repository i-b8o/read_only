package com.b8o.read_only
import org.jsoup.Jsoup

interface TextCleaner {
    fun dropHtml(text:String):String

}

class TextCleanerDefault : TextCleaner {
    override fun dropHtml(textWithHtml: String): String {
        if (textWithHtml.isEmpty()) {
            return ""
        }
        return Jsoup.parse(textWithHtml).text();
    }

}