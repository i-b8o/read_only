import 'package:read_only/domain/entity/chapter.dart';

class Doc {
  final int id;
  final String name;
  final int? color;
  final List<Chapter>? chapters;

  Doc({required this.id, required this.name, this.chapters, this.color});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'color': color,
    };

    return map;
  }
}
