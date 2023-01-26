import 'package:html/parser.dart';

String removeAllTagsExceptLinks(String htmlString) {
  Map<int, String> tagsMap = getTags(htmlString);
  tagsMap = clearTags(tagsMap);
  return getStringForSave(tagsMap, parseHtmlString(htmlString));
}

// getTags returns a map whose keys are start position in the string of the tag and values are the tags
Map<int, String> getTags(String htmlString) {
  // splits the html string into a list of letters
  List<String> symbols = htmlString.split('');
  Map<int, String> tags = {};
  List<String> tag = [];
  bool tagOpened = false;
  int tagOpenIndex = 0;

  // Counts only pure text letters, do not count tags letters
  int lettersIndex = 0;
  for (var i = 0; i < symbols.length; i++) {
    String symbol = symbols[i];

    // a html tag opened
    if (symbol == "<") {
      // Get the tag first symbol index
      tagOpenIndex = lettersIndex;
      tagOpened = true;
    }

    // Pure text
    if (!tagOpened) {
      // Count
      lettersIndex++;
    }

    // Collect the tag symbols
    if (tagOpened) {
      tag.add(symbol);
    }

    // Tag closed
    if (symbol == ">") {
      // Add the tag
      tags[tagOpenIndex] = tag.join("");
      tagOpened = false;
      tagOpenIndex = 0;
      tag = [];
    }
  }
  return tags;
}

Map<String, String> getLinks(String content) {
  Map<String, String> result = {};
  final document = parse(content);
  final elements = document.getElementsByTagName("a");
  if (elements.isNotEmpty) {
    elements.forEach((element) {
      result[element.text] = element.outerHtml;
    });
  }
  return result;
}

Map<int, String> addTag(Map<int, String> tags, String tag, int start) {
  if (tags.containsKey(start)) {
    start++;
  }

  tags[start] = tag;
  return tags;
}

// Drops all tags except <a ...> and </a> from a tags map
Map<int, String> clearTags(Map<int, String> tags) {
  Map<int, String> newMap = {};
  tags.forEach((key, value) {
    if ((value.contains('<a')) || (value.contains('</a'))) {
      newMap[key] = value;
    }
  });
  return newMap;
}

// getStringForSave inserts tags into a string
String getStringForSave(Map<int, String> tags, String pureContent) {
  // Sort the tags list based on the index value
  List<int> sortedKeys = tags.keys.toList()..sort();

  if (sortedKeys.isEmpty) {
    return pureContent;
  }

  // splits the pure string into a list of letters
  List<String> symbols = pureContent.split('');
  List<String> result = [];
  for (var i = 0; i < symbols.length; i++) {
    // A tag location
    if ((i == sortedKeys[0]) && (tags[i] != null)) {
      // Add the tag and the symbol to the result list
      result.add(tags[i]!);

      result.add(symbols[i]);
      // Drop the tag from the tags map
      tags.removeWhere((key, value) => key == i);
      // Drop the key from the keys list
      sortedKeys.removeAt(0);

      if (sortedKeys.isEmpty) {
        // Add the rest of the pure content to the result list
        result.add(pureContent.substring(i + 1));
        break;
      }
    } else {
      result.add(symbols[i]);
    }
  }
  // a tag whose position at the end of the content
  if (sortedKeys.length == 1) {
    result.add(tags[sortedKeys[0]] ?? "");
  }
  return result.join('');
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  if (document.body == null) {
    return "";
  }
  if (parse(document.body!.text).documentElement == null) {
    return "";
  }
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

// List<EditedParagraphLink> getEditedParagraphLinks(String content) {
//   List<EditedParagraphLink> result = [];
//   List<String> _colors = [];
//   List<String> _text = [];
//   var re = RegExp(r'(?<=-color:#).*?(?=;">)');
//   var matches = re.allMatches(content);
//   for (final RegExpMatch m in matches) {
//     _colors.add(content.substring(m.start, m.end));
//   }
//   re = RegExp(r'(?<=;">).*?(?=</)');
//   matches = re.allMatches(content);
//   for (final RegExpMatch m in matches) {
//     _text.add(parseHtmlString(content.substring(m.start, m.end)));
//   }

//   for (var i = 0; i < _colors.length; i++) {
//     if (_text.length > i) {
//       result.add(EditedParagraphLink(
//           color: HexColor.fromHex(_colors[i]), text: _text[i]));
//     }
//   }

//   return result;
// }

List<String> getTextList(String content) {
  List<String> result = [];
  var re = RegExp(r'(?<=;">).*?(?=</)');
  var matches = re.allMatches(content);
  for (final RegExpMatch m in matches) {
    result.add(content.substring(m.start, m.end));
  }

  return result;
}
