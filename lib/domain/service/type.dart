import 'package:read_only/data_providers/grpc/type.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';

import '../../ui/widgets/type_list/type_list_model.dart';

class TypeService implements TypesListViewModelProvider {
  final TypeDataProvider typeDataProvider;

  const TypeService({required this.typeDataProvider});

  @override
  Future<List<TypeResponse>> getAll() async {
    GetAllTypesResponse resp = await typeDataProvider.getAll();
    return resp.types;
  }
}
