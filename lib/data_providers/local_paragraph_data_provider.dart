import 'package:read_only/domain/entity/paragraph.dart';
import 'package:read_only/domain/service/chapter_service.dart';

class LocalParagraphDataProviderDefault
    implements ParagraphServiceLocalChapterDataProvider {
  LocalParagraphDataProviderDefault();

  @override
  Future<List<Paragraph>?> getParagraphs(int id) {
    throw UnimplementedError();
  }
}
