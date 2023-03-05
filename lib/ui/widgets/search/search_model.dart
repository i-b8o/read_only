import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/search_item.dart';
import 'package:read_only/library/text/text.dart';

abstract class SearchViewModelSearchService {
  Future<List<SearchItem>?> search(String searchQuery);
}

class SearchViewModel extends ChangeNotifier {
  final SearchViewModelSearchService searchService;
  List<SearchItem>? _searchResults;
  List<SearchItem>? get searchResults => _searchResults;
  String _searchQuery = "";

  SearchViewModel({required this.searchService});

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
}
