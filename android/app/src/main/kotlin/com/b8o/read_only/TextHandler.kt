package com.b8o.read_only



class TextHandler(private val textCleaner:TextCleaner, private val textReducer:TextReducer) {
    //   TODO roman numbers?
       fun apply(text: String): List<String> {
        var cleanText = textCleaner.dropHtml(text)
        return  textReducer.reduce(cleanText)
    }
}
//for _, sentence := range sentences {
//    words := strings.Split(sentence, " ")
//    if len(words) <= 40 {
//        speechText = append(speechText, replaceRomanWithArabic([]string{sentence})...)
//        // fmt.Println("here " + speechText)
//        continue
//    }
//    parts := strings.Split(sentence, ",")
//    speechText = append(speechText, replaceRomanWithArabic(parts)...)
//}
