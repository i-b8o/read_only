import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/doc_paragraps.dart';
import 'package:read_only/pb/reader/service.pbgrpc.dart';
import 'package:sqflite/sqflite.dart';

class EntireDocDataProviderDefault {
  EntireDocDataProviderDefault({
    required this.grpcClient,
    required this.db,
  }) : _docGRPCClient = DocGRPCClient(grpcClient.channel());
  final GrpcClient grpcClient;
  final DocGRPCClient _docGRPCClient;
  final Database db;

  Future<List<DocParagraph>> _getEntireDoc(int id) async {
    try {
      // Request
      Int64 int64ID = Int64(id);
      GetEntireDocRequest req = GetEntireDocRequest(iD: int64ID);
      GetEntireDocResponse resp = await _docGRPCClient.getEntireDoc(req);
      // Mapping
      List<DocParagraph> paragraphs = resp.paragraphs
          .map((e) => DocParagraph(
                docName: e.docName,
                chapterID: e.chapterID.toInt(),
                chapterName: e.chapterName,
                chapterNumber: e.chupterNumber,
                chapterOrderNum: e.chupterOrderNum,
                paragraphID: e.paragraphID.toInt(),
                paragraphOrderNum: e.paragraphOrderNum,
                paragraphclass: e.class_11,
                hasLinks: e.hasLinks,
                isNFT: e.isNFT,
                isTable: e.isTable,
                content: e.content,
              ))
          .toList();
      return paragraphs;
    } catch (e) {
      throw PlatformException(code: "get_entire_doc_error", details: e);
    }
  }

  Future<void> _insertParagraphs(List<DocParagraph> paragraphs) async {
    Batch batch = db.batch();
    for (var paragraph in paragraphs) {
      batch.insert('paragraph', {
        'num': paragraph.chapterNumber,
        'hasLinks': paragraph.hasLinks ? 1 : 0,
        'isTable': paragraph.isTable ? 1 : 0,
        'isNFT': paragraph.isNFT ? 1 : 0,
        'className': paragraph.paragraphclass,
        'content': paragraph.content,
        'chapterID': paragraph.chapterID,
      });
    }
    await batch.commit(noResult: true);
  }

  Future<void> _insertChapters(List<Chapter> chapters, Database db) async {
    Batch batch = db.batch();
    for (var chapter in chapters) {
      batch.insert("ReadOnlyChapter", {
        "id": chapter.iD,
        "name": chapter.name,
        "orderNum": chapter.orderNum,
        "num": chapter.num
      });
    }
    await batch.commit();
  }

  Future<void> loadDoc(int id) async {
    final paragraphs = await _getEntireDoc(id);
    await _insertParagraphs(paragraphs);
  }

  List<Chapter> mapParagraphsToChapters(List<DocParagraph> paragraphs) {
    Map<int, Chapter> chapters = {};

    for (var paragraph in paragraphs) {
      int chapterID = paragraph.chapterID;
      if (!chapters.containsKey(chapterID)) {
        chapters[chapterID] = Chapter(
          iD: chapterID,
          name: "",
          orderNum: 0,
          num: "",
          paragraphs: [],
        );
      }

      chapters[chapterID].paragraphs.add(paragraph);
    }

    return chapters.values.toList();
  }
}
