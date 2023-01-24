import 'package:read_only/domain/entity/chapter.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

abstract class ChapterDataProvider {
  const ChapterDataProvider();
  Future<ReadOnlyChapter> getOne(int id);
}

class ChapterService implements ChapterViewModelService {
  final ChapterDataProvider chapterDataProvider;

  const ChapterService({required this.chapterDataProvider});

  @override
  Future<ReadOnlyChapter> getOne(int id) async {
    return await chapterDataProvider.getOne(id);
  }
}
