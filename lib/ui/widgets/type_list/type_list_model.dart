import 'package:flutter/material.dart';
import 'package:read_only/data_providers/grpc/pb/reader/service.pbgrpc.dart';

abstract class TypesListViewModelProvider {
  Future<List<TypeResponse>> getAll();
}

class TypeListViewModel extends ChangeNotifier {
  final TypesListViewModelProvider typesProvider;
  var _types = <TypeResponse>[];
  List<TypeResponse> get types => List.unmodifiable(_types);

  TypeListViewModel({
    required this.typesProvider,
  }) {
    asyncInit();
  }
  Future<void> asyncInit() async {
    await getAll();
    notifyListeners();
  }

  Future<void> getAll() async {
    _types = await typesProvider.getAll();
  }
}
