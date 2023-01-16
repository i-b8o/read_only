import 'package:read_only/domain/entity/chapter_info.dart';

class ReadOnlyDoc {
  final String name;
  final List<ReadOnlyChapterInfo> chapters;

  ReadOnlyDoc({required this.name, required this.chapters});
}
