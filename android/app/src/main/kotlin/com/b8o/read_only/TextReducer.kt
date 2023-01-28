package com.b8o.read_only

interface TextReducer  {
    fun reduce(text: String): List<String>
}

class TextReducerDefault(private val textCleaner:TextCleaner): TextReducer {
    override fun reduce(text: String): List<String> {
        if(text.length < 250) {
            var cleanText = textCleaner.dropPunctuations(text)
            return listOf(cleanText)
        }
//        Text is not short enough
        val preparedText = mutableListOf<String>()
        var sentences = text.split(". ")
        for(sentence:String in sentences){
            var words = sentence.split(" ")
            if (words.size <= 40){
                var cleanText = textCleaner.dropPunctuations(sentence)
                preparedText.add(cleanText)
                continue
            }
            var parts = sentence.split(",")
            for (part:String in parts){
//                var cleanText = textCleaner.dropPunctuations(part)
                preparedText.add(part)
            }
        }
        return preparedText
    }

}