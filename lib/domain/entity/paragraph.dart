class Paragraph {
  final int paragraphID;
  final int paragraphOrderNum;
  final bool hasLinks;
  final bool isTable;
  final bool isNFT;
  final String paragraphclass;
  final String content;
  final int chapterID;
  final String? docName;
  final String? chapterName;
  final String? chapterNumber;
  final int? chapterOrderNum;

  Paragraph({
    required this.chapterID,
    required this.paragraphID,
    required this.paragraphOrderNum,
    required this.hasLinks,
    required this.isTable,
    required this.isNFT,
    required this.paragraphclass,
    required this.content,
    this.docName,
    this.chapterName,
    this.chapterNumber,
    this.chapterOrderNum,
  });
}
