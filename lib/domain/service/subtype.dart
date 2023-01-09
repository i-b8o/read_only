import 'package:read_only/data_providers/grpc/pb/reader/service.pb.dart';
import '../../data_providers/grpc/subtypes.dart';
import '../../ui/widgets/subtype_list/subtype_list_model.dart';
import 'package:fixnum/fixnum.dart';

class SubtypeService implements SubtypesListViewModelProvider {
  final SubtypeDataProvider subtypeDataProvider;

  const SubtypeService({required this.subtypeDataProvider});

  @override
  Future<List<SubtypeResponse>> getAll(Int64 id) async {
    GetAllSubtypesResponse resp = await subtypeDataProvider.getAll(id);
    return resp.subtypes;
  }
}
