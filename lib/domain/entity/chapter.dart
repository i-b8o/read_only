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

  Chapter copyWith({
    int? id,
    String? name,
    int? orderNum,
    String? num,
    int? docID,
    List<Paragraph>? paragraphs,
  }) {
    return Chapter(
      id: id ?? this.id,
      name: name ?? this.name,
      orderNum: orderNum ?? this.orderNum,
      num: num ?? this.num,
      docID: docID ?? this.docID,
      paragraphs: paragraphs ?? this.paragraphs,
    );
  }
}
