import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/search_item.dart';

abstract class SearchServiceLocalDocDataProvider {
  const SearchServiceLocalDocDataProvider();
  Future<List<SearchItem>> search(String searchQuery, int limit, int offset);
}

class SearchService {
  final SearchServiceLocalDocDataProvider _dataProvider;

  SearchService(this._dataProvider);

  Future<List<SearchItem>?> search(String searchQuery) async {
    const limit = 10, offset = 10;
    try {
      return await _dataProvider.search(searchQuery, limit, offset);
    } catch (e) {
      L.error('Error occurred while searching: $e');
    }
    return null;
  }
}
