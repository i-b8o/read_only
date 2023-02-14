import 'package:read_only/domain/entity/doc.dart';
import 'package:read_only/domain/entity/sub_type.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';

import '../../ui/widgets/subtype_list/subtype_list_model.dart';

abstract class SubtypeDataProvider {
  const SubtypeDataProvider();
  Future<List<Subtype>> getAll(int id);
  Future<List<Doc>> getDocs(int id);
}

class SubtypeService
    implements SubtypesListViewModelService, DocListViewModelService {
  final SubtypeDataProvider subtypeDataProvider;

  const SubtypeService({required this.subtypeDataProvider});

  @override
  Future<List<Subtype>> getAll(int id) async {
    return await subtypeDataProvider.getAll(id);
  }

  @override
  Future<List<Doc>> getDocs(int id) async {
    return await subtypeDataProvider.getDocs(id);
  }
}
