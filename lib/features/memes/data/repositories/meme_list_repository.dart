import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:meme_factory/core/error/exceptions.dart';
import 'package:meme_factory/core/error/failures.dart';
import 'package:meme_factory/core/network/return_failure.dart';
import 'package:meme_factory/core/utils/network_info.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_local_data_source.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_remote_data_source.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

abstract class MemeListRepository {
  Future<Either<Failure, List<Meme>>> getMemes();
}

class MemeListRepositoryImpl extends MemeListRepository {
  final MemeListRemoteDataSource remoteDataSource;
  final MemeListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MemeListRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Meme>>> getMemes() async {
    if (await networkInfo.isConnected) {
      try {
        final memes = await remoteDataSource.getMemes();
        localDataSource.insertMemes(memes);
        return Right(memes);
      } catch (e) {
        return ReturnFailure<List<Meme>>()(e as Exception);
      }
    } else {
      try {
        final memes = await localDataSource.getMemes();
        log('memes from cache: $memes');
        return Right(memes);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
