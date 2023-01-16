class ReadOnlyParagraph {
  final int id;
  final int num;
  final bool hasLinks;
  final bool isTable;
  final bool isNFT;
  final String className;
  final String content;
  final int chapterID;

  ReadOnlyParagraph(
      {required this.id,
      required this.num,
      required this.hasLinks,
      required this.isTable,
      required this.isNFT,
      required this.className,
      required this.content,
      required this.chapterID});
}
