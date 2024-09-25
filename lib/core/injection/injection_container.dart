import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meme_factory/core/blocs/theme_cubit.dart';
import 'package:meme_factory/core/database/database_helper.dart';
import 'package:meme_factory/core/database/meme_dao.dart';
import 'package:meme_factory/core/network/api_client.dart';
import 'package:meme_factory/core/utils/network_info.dart';
import 'package:meme_factory/features/meme_detail/blocs/edit_image_cubit.dart';
import 'package:meme_factory/features/meme_detail/blocs/signature_cubit.dart';
import 'package:meme_factory/features/memes/blocs/meme_list_cubit.dart';
import 'package:meme_factory/features/memes/blocs/meme_search_cubit.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_local_data_source.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_remote_data_source.dart';
import 'package:meme_factory/features/memes/data/repositories/meme_list_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //* Core
  getIt
    ..registerLazySingleton(() => ApiClient())
    ..registerLazySingleton(() => InternetConnectionChecker())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerFactory(() => ThemeCubit());

  //? database
  getIt
    ..registerLazySingleton(() => DatabaseHelper())
    ..registerLazySingleton(() => MemeDao(getIt()));

  //* data sources
  getIt
    ..registerLazySingleton<MemeListRemoteDataSource>(
        () => MemeListRemoteDataSourceImpl(getIt()))
    ..registerLazySingleton<MemeListLocalDataSource>(
        () => MemeListLocalDataSourceImpl(getIt()));

  //* Repositories
  getIt.registerLazySingleton<MemeListRepository>(
      () => MemeListRepositoryImpl(getIt(), getIt(), getIt()));

  //* Blocs
  getIt
    ..registerFactory(() => MemeListCubit(getIt()))
    ..registerFactory(() => MemeSearchCubit())
    ..registerFactory(() => SignatureCubit())
    ..registerFactory(() => EditImageCubit());
}
