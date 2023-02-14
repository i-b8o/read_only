import 'package:read_only/domain/entity/type.dart';
import '../../ui/widgets/type_list/type_list_model.dart';

abstract class TypeDataProvider {
  const TypeDataProvider();
  Future<List<Type>> getAll();
}

class ReadOnlyTypeService implements TypesListViewModelService {
  final TypeDataProvider typeDataProvider;

  const ReadOnlyTypeService({required this.typeDataProvider});

  @override
  Future<List<Type>> getAll() async {
    List<Type> resp = await typeDataProvider.getAll();
    return resp;
  }
}
