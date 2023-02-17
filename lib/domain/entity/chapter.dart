import 'package:read_only/domain/entity/paragraph.dart';

class Chapter {
  final int id;
  final String name;
  final int orderNum;
  final String num;
  final int docID;
  final List<Paragraph>? paragraphs;

  Chapter({
    required this.id,
    required this.name,
    required this.orderNum,
    required this.num,
    required this.docID,
    this.paragraphs,
  });
}
