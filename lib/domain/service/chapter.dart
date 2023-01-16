import 'package:read_only/data_providers/grpc/chapter.dart';
import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

class ChapterService implements ChapterViewModelProvider {
  final ChapterDataProvider chapterDataProvider;

  const ChapterService({required this.chapterDataProvider});

  @override
  Future<ReadOnlyChapter> getOne(int id) async {
    return await chapterDataProvider.getOne(id);
  }
}
