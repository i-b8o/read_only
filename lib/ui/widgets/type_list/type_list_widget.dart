import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/ui/widgets/type_list/type_list_model.dart';

class TypeListWidget extends StatelessWidget {
  const TypeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TypeListViewModel>();
    final types = model.types;

    return Column(
      children: types
          .map((e) => Text(
                e.name,
                style: TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }
}
