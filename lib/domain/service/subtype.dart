import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';
import '../../data_providers/grpc/subtype.dart';
import '../../ui/widgets/subtype_list/subtype_list_model.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeService
    implements SubtypesListViewModelProvider, DocListViewModelProvider {
  final SubtypeDataProvider subtypeDataProvider;

  const SubtypeService({required this.subtypeDataProvider});

  @override
  Future<List<SubtypeResponse>> getAll(Int64 id) async {
    GetAllSubtypesResponse resp = await subtypeDataProvider.getAll(id);
    return resp.subtypes;
  }

  @override
  Future<List<Doc>> getDocs(Int64 id) async {
    GetDocsResponse resp = await subtypeDataProvider.getDocs(id);
    return resp.docs;
  }
}
