class DocParagraph {
  final String docName;
  final int chapterID;
  final String chapterName;
  final String chapterNumber;
  final int chapterOrderNum;
  final int paragraphID;
  final int paragraphOrderNum;
  final bool hasLinks;
  final bool isTable;
  final bool isNFT;
  final String paragraphclass;
  final String content;

  DocParagraph({
    required this.docName,
    required this.chapterID,
    required this.chapterName,
    required this.chapterNumber,
    required this.chapterOrderNum,
    required this.paragraphID,
    required this.paragraphOrderNum,
    required this.hasLinks,
    required this.isTable,
    required this.isNFT,
    required this.paragraphclass,
    required this.content,
  });
}
