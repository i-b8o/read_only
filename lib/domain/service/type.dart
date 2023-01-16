import 'package:read_only/data_providers/grpc/type.dart';
import 'package:read_only/domain/entity/type.dart';

import '../../ui/widgets/type_list/type_list_model.dart';

class ReadOnlyTypeService implements TypesListViewModelService {
  final TypeDataProvider typeDataProvider;

  const ReadOnlyTypeService({required this.typeDataProvider});

  @override
  Future<List<ReadOnlyType>> getAll() async {
    List<ReadOnlyType> resp = await typeDataProvider.getAll();
    return resp;
  }
}
