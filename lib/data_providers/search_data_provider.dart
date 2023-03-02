import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/search_item.dart';
import 'package:read_only/domain/service/search_service.dart';
import 'package:read_only/pb/searcher/service.pbgrpc.dart';

class SearchDataProviderDefault implements SearchServiceDataProvider {
  SearchDataProviderDefault()
      : _searchGRPCClient = SearcherGRPCClient(GrpcClient().channel("search"));
  final SearcherGRPCClient _searchGRPCClient;

  Future<List<SearchItem>> search(
      String searchQuery, int limit, int offset) async {
    final request = SearchRequest()
      ..searchQuery = searchQuery
      ..limit = limit
      ..offset = offset;

    try {
      final response = await _searchGRPCClient.search(request);
      return response.response
          .map((message) => SearchItem.fromProto(message))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
