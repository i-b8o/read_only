import 'package:read_only/domain/entity/chapter_info.dart';

class ReadOnlyDoc {
  final String name;
  final int? color;
  final List<ReadOnlyChapterInfo> chapters;

  ReadOnlyDoc(this.color, {required this.name, required this.chapters});
}
