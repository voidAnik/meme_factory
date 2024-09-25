import 'package:dartz/dartz.dart';
import 'package:meme_factory/core/error/failures.dart';
import 'package:meme_factory/core/network/return_failure.dart';
import 'package:meme_factory/features/memes/data/data_sources/meme_list_remote_data_source.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

abstract class MemeListRepository {
  Future<Either<Failure, List<Meme>>> getMemes();
}

class MemeListRepositoryImpl extends MemeListRepository {
  final MemeListRemoteDataSource remoteDataSource;

  MemeListRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Meme>>> getMemes() async {
    try {
      final memes = await remoteDataSource.getMemes();
      return Right(memes);
    } catch (e) {
      return ReturnFailure<List<Meme>>()(e as Exception);
    }
  }
}
