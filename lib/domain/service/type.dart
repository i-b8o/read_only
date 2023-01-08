import 'package:read_only/data_providers/grpc/pb/reader/service.pb.dart';
import 'package:read_only/data_providers/grpc/types.dart';

import '../../ui/widgets/type_list/type_list_model.dart';

class TypeService implements TypesListViewModelProvider {
  final TypeDataProvider typeDataProvider;

  const TypeService({required this.typeDataProvider});

  Future<List<TypeResponse>> getAll() async {
    return await typeDataProvider.getAll();
  }
}