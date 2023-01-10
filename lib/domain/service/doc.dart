import 'package:read_only/data_providers/grpc/doc.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:fixnum/fixnum.dart';

class DocService implements ChapterListViewModelProvider {
  final DocDataProvider docDataProvider;

  const DocService({required this.docDataProvider});

  @override
  Future<GetOneDocResponse> getOne(Int64 id) async {
    return await docDataProvider.getOne(id);
  }
}
