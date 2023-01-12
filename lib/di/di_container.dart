import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_only/data_providers/grpc/chapter.dart';
import 'package:read_only/data_providers/grpc/doc.dart';
import 'package:read_only/data_providers/grpc/subtype.dart';
import 'package:read_only/domain/service/chapter.dart';
import 'package:read_only/domain/service/doc.dart';
import 'package:read_only/domain/service/subtype.dart';
import 'package:read_only/domain/service/type.dart';
import 'package:read_only/library/grpc_client/grpc_client.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:read_only/ui/widgets/chapter/chapter_widget.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_widget.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_widget.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_model.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_widget.dart';
import 'package:read_only/ui/widgets/type_list/type_list_widget.dart';

import '../data_providers/grpc/type.dart';
import '../main.dart';
import '../ui/navigation/main_navigation.dart';
import '../ui/widgets/app/app.dart';
import '../ui/widgets/type_list/type_list_model.dart';

AppFactory makeAppFactory() => _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  final _diContainer = _DIContainer();

  _AppFactoryDefault();
  @override
  Widget makeApp() => App(navigation: _diContainer._makeAppNavigation());
}

class _DIContainer {
  ScreenFactory _makeScreenFactory() => ScreenFactoryDefault(this);
  AppNavigation _makeAppNavigation() => MainNavigation(_makeScreenFactory());
  DocService _docService;
  _DIContainer()
      : _docService = DocService(docDataProvider: const DocDataProvider()) {
    GrpcClient();
  }
  // Dispatch all of them?
  // final GrpcClient _grpcClient = GrpcClient();
  // ignore: prefer_const_constructors
  TypeDataProvider _makeTypeDataProvider() => TypeDataProvider();
  TypeService _makeTypeService() =>
      TypeService(typeDataProvider: _makeTypeDataProvider());
  TypeListViewModel _makeTypeListViewModel() =>
      TypeListViewModel(typesProvider: _makeTypeService());

  SubtypeDataProvider _makeSubtypeDataProvider() => const SubtypeDataProvider();
  SubtypeService _makeSubtypeService() =>
      SubtypeService(subtypeDataProvider: _makeSubtypeDataProvider());
  SubtypeListViewModel _makeSubtypeListViewModel(Int64 id) =>
      SubtypeListViewModel(subtypesProvider: _makeSubtypeService(), id: id);

  DocListViewModel _makeDocListViewModel(Int64 id) =>
      DocListViewModel(docsProvider: _makeSubtypeService(), id: id);

  // DocDataProvider _docDataProvider() => const DocDataProvider();
  // DocService _makeDocService() =>
  //     DocService(docDataProvider: _docDataProvider());
  ChapterListViewModel _makeChapterListViewModel(Int64 id) =>
      ChapterListViewModel(docsProvider: _docService, id: id);

  ChapterDataProvider _makeChapterDataProvider() => ChapterDataProvider();
  ChapterService _makeChapterService() =>
      ChapterService(chapterDataProvider: _makeChapterDataProvider());
  ChapterViewModel _makeChapterViewModel(Int64 id) => ChapterViewModel(
        chapterCount: _docService.chapterCount,
        chaptersOrderNums: _docService.chaptersOrderNums,
        pageController: PageController(
            initialPage: _docService.chaptersOrderNums.keys
                .firstWhere((key) => _docService.chaptersOrderNums[key] == id)),
        textEditingController: TextEditingController(),
        chapterProvider: _makeChapterService(),
        id: id,
      );
}

class ScreenFactoryDefault implements ScreenFactory {
  final _DIContainer _diContainer;
  const ScreenFactoryDefault(this._diContainer);

  @override
  Widget makeTypeListScreen() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeTypeListViewModel(),
      // Lazy ?
      lazy: false,
      child: const TypeListWidget(),
    );
  }

  @override
  Widget makeSubtypeListScreen(Int64 id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeSubtypeListViewModel(id),
      lazy: false,
      child: const SubtypeListWidget(),
    );
  }

  @override
  Widget makeDocListScreen(Int64 id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeDocListViewModel(id),
      lazy: false,
      child: const DocListWidget(),
    );
  }

  @override
  Widget makeChapterListScreen(Int64 id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeChapterListViewModel(id),
      lazy: false,
      child: const ChapterListWidget(),
    );
  }

  @override
  Widget makeChapterScreen(Int64 id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeChapterViewModel(id),
      lazy: false,
      child: const ChapterWidget(),
    );
  }

  // @override
  // Widget makeMainScreen() {
  //   // TODO: implement makeMainScreen
  //   throw UnimplementedError();
  // }

  // @override
  // Widget makeTypesScreen() {
  //   // TODO: implement makeTypesScreen
  //   throw UnimplementedError();
  // }
}
