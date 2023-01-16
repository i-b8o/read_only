import 'package:read_only/domain/entity/paragraph.dart';

class ReadOnlyChapter {
  final int id;
  final String name;
  final int orderNum;
  final String num;
  final List<ReadOnlyParagraph> paragraphs;

  ReadOnlyChapter(
      {required this.id,
      required this.name,
      required this.orderNum,
      required this.paragraphs,
      required this.num});
}
