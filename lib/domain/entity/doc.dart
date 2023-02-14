import 'package:read_only/domain/entity/chapter.dart';

class Doc {
  final int id;
  final String name;
  final int? color;
  final List<Chapter>? chapters;

  Doc({required this.id, required this.name, this.chapters, this.color});
}
