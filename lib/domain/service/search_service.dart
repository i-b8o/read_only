import 'package:my_logger/my_logger.dart';
import 'package:read_only/domain/entity/search_item.dart';
import 'package:read_only/ui/widgets/search/search_model.dart';

abstract class SearchServiceDataProvider {
  const SearchServiceDataProvider();
  Future<List<SearchItem>> search(String searchQuery, int limit, int offset);
}

class SearchService implements SearchViewModelSearchService {
  final SearchServiceDataProvider dataProvider;

  SearchService({required this.dataProvider});

  @override
  Future<List<SearchItem>?> search(String searchQuery) async {
    const limit = 10, offset = 10;
    try {
      return await dataProvider.search(searchQuery, limit, offset);
    } catch (e) {
      L.error('Error occurred while searching: $e');
    }
    return null;
  }
}
