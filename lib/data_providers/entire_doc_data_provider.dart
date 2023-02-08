import 'package:fixnum/fixnum.dart';
import 'package:flutter/services.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:read_only/domain/entity/chapter_info.dart';
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

  Future<void> saveDoc(int id) async {
    final paragraphs = await _getEntireDoc(id);
    await _insertParagraphs(paragraphs);
    final chapters = _mapParagraphsToChapters(paragraphs);
    await _insertChapters(chapters, db);
  }

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

  Future<void> _insertChapters(
      List<ReadOnlyChapterInfo> chapters, Database db) async {
    Batch batch = db.batch();
    for (var chapter in chapters) {
      batch.insert("ReadOnlyChapter", {
        "id": chapter.id,
        "name": chapter.name,
        "orderNum": chapter.orderNum,
        "num": chapter.num
      });
    }
    await batch.commit();
  }

  List<ReadOnlyChapterInfo> _mapParagraphsToChapters(
      List<DocParagraph> paragraphs) {
    Map<int, ReadOnlyChapterInfo> chapterMap = {};

    for (var paragraph in paragraphs) {
      if (chapterMap.containsKey(paragraph.chapterID)) {
        continue;
      }
      chapterMap[paragraph.chapterID] = ReadOnlyChapterInfo(
        id: paragraph.chapterID,
        name: paragraph.chapterName,
        orderNum: paragraph.chapterOrderNum,
        num: paragraph.chapterNumber,
      );
    }

    return chapterMap.values.toList();
  }

  Future<void> _deleteDoc(int id) async {
    // Begin a transaction
    await db.transaction((txn) async {
      // Delete the ReadOnlyDoc with id
      await txn.delete('ReadOnlyDoc', where: 'id = ?', whereArgs: [id]);

      final chapters = await txn.query('ReadOnlyChapter',
          columns: ['id'], where: 'doc_id = ?', whereArgs: [id]) as List<int>;

      // Delete all ReadOnlyChapter with doc_id equal to the id
      await txn.delete('ReadOnlyChapter', where: 'doc_id = ?', whereArgs: [id]);

      // Delete all ReadOnlyParagraph for every deleted chapter id
      final List<int> chapterIds = await _getChapterIDsForDoc(id);

      await txn.delete('ReadOnlyParagraph',
          where: 'chapter_id in (${chapterIds.join(', ')})');
    });
  }

  Future<List<int>> _getChapterIDsForDoc(int docID) async {
    List<Map<String, dynamic>> result = await db.query("chapter",
        columns: ["id"], where: "docID = ?", whereArgs: [docID]);

    return result.map((row) => row["id"]).toList() as List<int>;
  }
}
