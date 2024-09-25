import 'package:get_it/get_it.dart';
import 'package:meme_factory/core/blocs/theme_cubit.dart';
import 'package:meme_factory/core/network/api_client.dart';
import 'package:meme_factory/features/meme_detail/blocs/signature_cubit.dart';
import 'package:meme_factory/features/memes/blocs/meme_list_cubit.dart';
import 'package:meme_factory/features/memes/blocs/meme_search_cubit.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_remote_data_source.dart';
import 'package:meme_factory/features/memes/data/repositories/meme_list_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //* Core
  getIt.registerLazySingleton(() => ApiClient());
  getIt.registerFactory(() => ThemeCubit());
  //? database

  //* data providers
  getIt.registerLazySingleton<MemeListRemoteDataSource>(
      () => MemeListRemoteDataSourceImpl(getIt()));

  //* Repositories
  getIt.registerLazySingleton<MemeListRepository>(
      () => MemeListRepositoryImpl(getIt()));

  //* Blocs
  getIt
    ..registerFactory(() => MemeListCubit(getIt()))
    ..registerFactory(() => MemeSearchCubit())
    ..registerFactory(() => SignatureCubit());
}
