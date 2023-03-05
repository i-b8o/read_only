import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/domain/entity/search_item.dart';
import 'package:read_only/library/text/text.dart';

import 'package:read_only/ui/navigation/main_navigation_route_names.dart';

abstract class SearchViewModelSearchService {
  Future<List<SearchItem>?> search(String searchQuery);
}

abstract class SearchViewModelDocService {
  Future<void> tryOne(int id);
}

class SearchViewModel extends ChangeNotifier {
  final SearchViewModelSearchService searchService;
  final SearchViewModelDocService docService;
  List<SearchItem>? _searchResults;
  List<SearchItem>? get searchResults => _searchResults;
  String _searchQuery = "";

  SearchViewModel({required this.searchService, required this.docService});

  Future<void> search(String searchQuery) async {
    _searchQuery = searchQuery;
    try {
      final results = await searchService.search(searchQuery);

      if (results == null) {
        return;
      }

      // Highlight the search query in the text field of each search result
      for (final result in results) {
        result.text = highlightSubtext(result.text, searchQuery);
      }

      _searchResults = results;
      notifyListeners();
    } catch (e) {
      L.error('Error occurred while searching', e);
    }
  }

  Future<void> onTap(BuildContext context, int docID, int cID, int? pID) async {
    await docService.tryOne(docID);
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.chapterScreen,
      arguments: Link(chapterID: cID, paragraphID: pID ?? 0),
    );
  }
}
