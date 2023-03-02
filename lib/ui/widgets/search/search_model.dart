import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/search_item.dart';

abstract class SearchViewModelSearchService {
  Future<List<SearchItem>?> search(String searchQuery);
}

class SearchViewModel extends ChangeNotifier {
  final SearchViewModelSearchService _searchService;
  List<SearchItem>? _searchResults;
  List<SearchItem>? get searchResults => _searchResults;

  SearchViewModel(this._searchService);

  Future<void> search(String searchQuery) async {
    try {
      final results = await _searchService.search(searchQuery);
      _searchResults = results;
      notifyListeners();
    } catch (e) {
      L.error('Error occurred while searching', e);
    }
  }
}
