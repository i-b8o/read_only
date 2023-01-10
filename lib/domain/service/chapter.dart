import 'package:fixnum/fixnum.dart';
import 'package:read_only/data_providers/grpc/chapter.dart';
import 'package:read_only/library/grpc_client/pb/reader/service.pb.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';

class ChapterService implements ChapterViewModelProvider {
  final ChapterDataProvider chapterDataProvider;

  const ChapterService({required this.chapterDataProvider});

  @override
  Future<GetOneChapterResponse> getOne(Int64 id) async {
    return await chapterDataProvider.getOne(id);
  }
}
