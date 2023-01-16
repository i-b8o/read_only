import 'package:read_only/domain/entity/doc_info.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';
import '../../data_providers/grpc/subtype.dart';
import '../../ui/widgets/subtype_list/subtype_list_model.dart';

class SubtypeService
    implements SubtypesListViewModelProvider, DocListViewModelProvider {
  final SubtypeDataProvider subtypeDataProvider;

  const SubtypeService({required this.subtypeDataProvider});

  @override
  Future<List<ReadOnlySubtype>> getAll(int id) async {
    return await subtypeDataProvider.getAll(id);
  }

  @override
  Future<List<ReadOnlyDocInfo>> getDocs(int id) async {
    return await subtypeDataProvider.getDocs(id);
  }
}
