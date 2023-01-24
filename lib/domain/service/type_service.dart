import 'package:read_only/domain/entity/type.dart';
import '../../ui/widgets/type_list/type_list_model.dart';

abstract class TypeDataProvider {
  const TypeDataProvider();
  Future<List<ReadOnlyType>> getAll();
}

class ReadOnlyTypeService implements TypesListViewModelService {
  final TypeDataProvider typeDataProvider;

  const ReadOnlyTypeService({required this.typeDataProvider});

  @override
  Future<List<ReadOnlyType>> getAll() async {
    List<ReadOnlyType> resp = await typeDataProvider.getAll();
    return resp;
  }
}
