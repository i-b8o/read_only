import 'package:html/parser.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/constants/constants.dart';

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

List<List<int>> findSubtextIndexes(String text, String subtext) {
  final List<List<int>> indexes = [];
  final RegExp pattern = RegExp(subtext, caseSensitive: false);
  int start = 0;
  while (start < text.length) {
    final Match? match = pattern.firstMatch(text.substring(start));
    if (match == null) {
      break;
    }
    final int matchStart = match.start + start;
    final int matchEnd = match.end + start;
    indexes.add([matchStart, matchEnd]);
    start = matchEnd;
  }
  return indexes;
}

String highlightSubtext(String text, String subtext) {
  List<List<int>> indexes = findSubtextIndexes(text, subtext);

  while (indexes.isEmpty && subtext.isNotEmpty) {
    if (subtext.length < 3) {
      break;
    }
    subtext = subtext.substring(0, subtext.length - 1);
    indexes = findSubtextIndexes(text, subtext);
  }

  String highlightedText = text;
  for (final index in indexes) {
    final startIndex = index.first;
    final endIndex = index.last + 1;
    final before = highlightedText.substring(0, startIndex);
    final after = highlightedText.substring(endIndex);
    final highlightedSubtext =
        '<span style="background-color:${Constants.searchWidgetSelectColor};">${highlightedText.substring(startIndex, endIndex)}</span>';
    highlightedText = '$before$highlightedSubtext$after';
  }
  L.info(highlightedText);
  return highlightedText;
}

List<String> getTextList(String content) {
  List<String> result = [];
  var re = RegExp(r'(?<=;">).*?(?=</)');
  var matches = re.allMatches(content);
  for (final RegExpMatch m in matches) {
    result.add(content.substring(m.start, m.end));
  }

  return result;
}
