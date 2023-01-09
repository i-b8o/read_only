import 'package:read_only/data_providers/grpc/doc.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:fixnum/fixnum.dart';

class DocService implements ChapterListViewModelProvider {
  final DocDataProvider subtypeDataProvider;

  const DocService({required this.subtypeDataProvider});

  @override
  Future<GetOneDocResponse> getOne(Int64 id) async {
    return await subtypeDataProvider.getOne(id);
  }

  @override
  Future<List<Doc>> getDocs(Int64 id) async {
    GetDocsResponse resp = await subtypeDataProvider.getDocs(id);
    return resp.docs;
  }
}
