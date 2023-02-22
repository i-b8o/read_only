import 'package:flutter/material.dart';
import 'package:my_logger/my_logger.dart';
import 'package:provider/provider.dart';
import 'package:read_only/.configuration/configuration.dart';
import 'package:read_only/data_providers/remote_chapter_data_provider.dart';
import 'package:read_only/data_providers/local_chapter_data_provider.dart';
import 'package:read_only/data_providers/local_doc_data_provider.dart';
import 'package:read_only/data_providers/local_note_data_provider.dart';
import 'package:read_only/data_providers/local_paragraph_data_provider.dart';
import 'package:read_only/data_providers/remote_paragraph_data_provider.dart';
import 'package:read_only/data_providers/tts_data_provider.dart';
import 'package:read_only/data_providers/tts_settings_data_provider.dart';
import 'package:read_only/data_providers/remote_type_data_provider.dart';
import 'package:read_only/data_providers/remote_subtype_data_provider.dart';
import 'package:read_only/domain/entity/link.dart';
import 'package:read_only/domain/service/chapter_service.dart';
import 'package:read_only/domain/service/doc_service.dart';
import 'package:read_only/domain/service/notes_service.dart';
import 'package:read_only/domain/service/subtype_service.dart';
import 'package:read_only/domain/service/tts_service.dart';
import 'package:read_only/domain/service/type_service.dart';
import 'package:grpc_client/grpc_client.dart';
import 'package:flutter/services.dart';
import 'package:read_only/sql/init.dart';
import 'package:read_only/ui/widgets/chapter/chapter_model.dart';
import 'package:read_only/ui/widgets/chapter/chapter_widget.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_model.dart';
import 'package:read_only/ui/widgets/chapter_list/chapter_list_widget.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_model.dart';
import 'package:read_only/ui/widgets/doc_list/doc_list_widget.dart';
import 'package:read_only/ui/widgets/notes/notes_model.dart';
import 'package:read_only/ui/widgets/notes/notes_widget.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_model.dart';
import 'package:read_only/ui/widgets/subtype_list/subtype_list_widget.dart';
import 'package:read_only/ui/widgets/type_list/type_list_widget.dart';
import 'package:read_only/data_providers/remote_doc_data_provider.dart';
import 'package:read_only/main.dart';
import 'package:read_only/ui/navigation/main_navigation.dart';
import 'package:read_only/ui/widgets/app/app.dart';
import 'package:read_only/ui/widgets/type_list/type_list_model.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';
import 'package:sqflite_client/sqflite_client.dart';

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

  // channels for communicating with platform
  static const _ttsMethodChannel = MethodChannel("com.b8o.read_only/tts");
  static const _ttsPositionChannel = EventChannel("com.b8o.read_only/tts_pos");

  // data providers
  final _ttsDataProvider =
      TtsDataProviderDefault(_ttsMethodChannel, _ttsPositionChannel);

  TypeDataProvider _makeTypeDataProvider() => TypeDataProviderDefault();

  SubtypeDataProvider _makeSubtypeDataProvider() =>
      SubtypeDataProviderDefault();

  ChapterDataProvider _makeChapterDataProvider() =>
      ChapterDataProviderDefault();
  ParagraphDataProvider _makeParagraphDataProvider() =>
      ParagraphDataProviderDefault();

  LocalDocDataProviderDefault _makeLocalDocDataProviderDefault() =>
      LocalDocDataProviderDefault();

  LocalChapterDataProviderDefault _makeLocalChapterDataProviderDefault() =>
      LocalChapterDataProviderDefault();

  LocalParagraphDataProviderDefault _makeLocalParagraphDataProviderDefault() =>
      LocalParagraphDataProviderDefault();

  LocalNotesDataProviderDefault _notesDataProvider() =>
      LocalNotesDataProviderDefault();

  final TtsSettingsDataProviderDefault _ttsSettingsDataProvider =
      const TtsSettingsDataProviderDefault();

  _DIContainer() {
    asyncInit();
    L.initialize();

    _docService = DocService(
        docDataProvider: DocDataProviderDefault(),
        localDocDataProvider: _makeLocalDocDataProviderDefault(),
        localChapterDataProvider: _makeLocalChapterDataProviderDefault());

    _ttsService = TtsService(_ttsDataProvider);
  }

  void asyncInit() async {
    GrpcClient().init(host: Configuration.host, port: Configuration.port);
    List<Future> futures = [
      SqfliteClient().init(InitSQL.dbName, initSQL: InitSQL.queries),
      SharedPreferencesClient.init(),
    ];
    await Future.wait(futures);
  }

  // Services
  late final DocService _docService;
  late final TtsService _ttsService;

  ReadOnlyTypeService _makeTypeService() =>
      ReadOnlyTypeService(typeDataProvider: _makeTypeDataProvider());

  SubtypeService _makeSubtypeService() =>
      SubtypeService(subtypeDataProvider: _makeSubtypeDataProvider());

  ChapterService _makeChapterService() => ChapterService(
      chapterDataProvider: _makeChapterDataProvider(),
      paragraphDataProvider: _makeParagraphDataProvider(),
      ttsSettingsDataProvider: _ttsSettingsDataProvider,
      localChapterDataProvider: _makeLocalChapterDataProviderDefault(),
      localParagraphDataProvider: _makeLocalParagraphDataProviderDefault());

  NotesService _makeNotesService() => NotesService(_notesDataProvider());

  // ViewModels
  TypeListViewModel _makeTypeListViewModel() =>
      TypeListViewModel(typesProvider: _makeTypeService());

  SubtypeListViewModel _makeSubtypeListViewModel(int id) =>
      SubtypeListViewModel(subtypesService: _makeSubtypeService(), id: id);

  DocListViewModel _makeDocListViewModel(int id) =>
      DocListViewModel(docsService: _makeSubtypeService(), id: id);

  ChapterListViewModel _makeChapterListViewModel(int id) =>
      ChapterListViewModel(docsProvider: _docService, id: id);

  NotesViewModel _makeNotesViewModel() => NotesViewModel(_makeNotesService());

  ChapterViewModel _makeChapterViewModel(Link link) {
    final _initialPage = _docService.initPage(link.chapterID) ?? 0;
    return ChapterViewModel(
      link,
      // chapterCount: _docService.totalChapters,
      // chaptersOrderNums: _docService.orderNumToChapterIdMap,
      // paragraphID: paragraphID
      // id: chapterID,
      docService: _docService,
      pageController: PageController(initialPage: _initialPage),
      textEditingController:
          TextEditingController(text: _initialPage.toString()),
      chapterService: _makeChapterService(),
      ttsService: _ttsService,
    );
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
  Widget makeChapterScreen(Link link) {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeChapterViewModel(link),
      lazy: false,
      child: const ChapterWidget(),
    );
  }

  @override
  Widget makeNotesScreen() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer._makeNotesViewModel(),
      lazy: false,
      child: const NotesWidget(),
    );
  }
}
