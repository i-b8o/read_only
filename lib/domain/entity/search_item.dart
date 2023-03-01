import 'package:fixnum/fixnum.dart';
import 'package:read_only/pb/searcher/service.pb.dart';

class SearchItem {
  int docID;
  String docName;
  int chapterID;
  String chapterName;
  String updatedAt;
  int paragraphID;
  String text;
  int count;

  SearchItem({
    required this.docID,
    required this.docName,
    required this.chapterID,
    required this.chapterName,
    required this.updatedAt,
    required this.paragraphID,
    required this.text,
    required this.count,
  });

  SearchItem.fromProto(SearchResponse message)
      : docID = message.docID.toInt(),
        docName = message.docName,
        chapterID = message.chapterID.toInt(),
        chapterName = message.chapterName,
        updatedAt = message.updatedAt,
        paragraphID = message.paragraphID.toInt(),
        text = message.text,
        count = message.count;
}
