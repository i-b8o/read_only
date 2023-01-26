import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:read_only/data_providers/chapter_data_provider.dart';
import 'package:read_only/data_providers/tts_settings_data_provider.dart';
import 'package:read_only/data_providers/type_data_provider.dart';
import 'package:read_only/data_providers/subtype_data_provider.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:read_only/domain/service/subtype_service.dart';
import 'package:read_only/domain/service/tts_service.dart';
import 'package:read_only/domain/service/type_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:tts_client/tts_client.dart';

import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:read_only/ui/widgets/chapter/chapter_widget.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_widget.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_widget.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_model.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_widget.dart';
import 'package:read_only/ui/widgets/type_list/type_list_widget.dart';
import 'package:read_only/.configuration/configuration.dart';
import 'package:read_only/data_providers/doc_data_provider.dart';
import 'package:read_only/main.dart';
import 'package:read_only/ui/navigation/main_navigation.dart';
import 'package:read_only/ui/widgets/app/app.dart';
import 'package:read_only/ui/widgets/type_list/type_list_model.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

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

  late final GrpcClientDefault _grpcClient;
  late final TtsClientDefault _ttsClient;

  late final TtsSettingsDataProviderDefault _ttsSettingsDataProvider;

  late final DocService _docService;
  late final TtsService _ttsService;

  _DIContainer() {
    asyncInit();
    _grpcClient =
        GrpcClientDefault(host: Configuration.host, port: Configuration.port);
    _docService = DocService(
        docDataProvider: DocDataProviderDefault1(grpcClient: _grpcClient));

    _ttsClient = TtsClientDefault(plugin: FlutterTts());
    _ttsService = TtsService(_ttsClient);
  }

  void asyncInit() async {
    final sp = DefaultSharedPreferencesStorage();
    await sp.getInstance();
    _ttsSettingsDataProvider = TtsSettingsDataProviderDefault(sp);
  }

  TypeDataProvider _makeTypeDataProvider() =>
      TypeDataProviderDefault(grpcClient: _grpcClient);
  ReadOnlyTypeService _makeTypeService() =>
      ReadOnlyTypeService(typeDataProvider: _makeTypeDataProvider());
  TypeListViewModel _makeTypeListViewModel() =>
      TypeListViewModel(typesProvider: _makeTypeService());

  SubtypeDataProvider _makeSubtypeDataProvider() =>
      SubtypeDataProviderDefault(grpcClient: _grpcClient);
  SubtypeService _makeSubtypeService() =>
      SubtypeService(subtypeDataProvider: _makeSubtypeDataProvider());
  SubtypeListViewModel _makeSubtypeListViewModel(int id) =>
      SubtypeListViewModel(subtypesService: _makeSubtypeService(), id: id);

  DocListViewModel _makeDocListViewModel(int id) =>
      DocListViewModel(docsService: _makeSubtypeService(), id: id);

  ChapterListViewModel _makeChapterListViewModel(int id) =>
      ChapterListViewModel(docsProvider: _docService, id: id);

  ChapterDataProvider _makeChapterDataProvider() =>
      ChapterDataProviderDefault(grpcClient: _grpcClient);

  ChapterService _makeChapterService() => ChapterService(
        chapterDataProvider: _makeChapterDataProvider(),
        ttsSettingsDataProvider: _ttsSettingsDataProvider,
      );
  ChapterViewModel _makeChapterViewModel(String url) {
    final int id;
    final int paragraphID;
    if (url.contains("#")) {
      id = int.tryParse(url.split("#")[0]) ?? 0;
      paragraphID = int.tryParse(url.split("#")[1]) ?? 0;
    } else {
      id = int.tryParse(url) ?? 0;
      paragraphID = 0;
    }
    final int initPage = _docService.chaptersOrderNums.keys
        .firstWhere((key) => _docService.chaptersOrderNums[key] == id);
    return ChapterViewModel(
        chapterCount: _docService.chapterCount,
        chaptersOrderNums: _docService.chaptersOrderNums,
        pageController: PageController(initialPage: initPage),
        textEditingController: TextEditingController(text: '$initPage'),
        chapterProvider: _makeChapterService(),
        ttsService: _ttsService,
        id: id,
        paragraphID: paragraphID);
  }
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
  Widget makeSubtypeListScreen(int id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeSubtypeListViewModel(id),
      lazy: false,
      child: const SubtypeListWidget(),
    );
  }

  @override
  Widget makeDocListScreen(int id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeDocListViewModel(id),
      lazy: false,
      child: const DocListWidget(),
    );
  }

  @override
  Widget makeChapterListScreen(int id) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeChapterListViewModel(id),
      lazy: false,
      child: const ChapterListWidget(),
    );
  }

  @override
  Widget makeChapterScreen(String url) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeChapterViewModel(url),
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
