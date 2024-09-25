import 'dart:developer';

import 'package:meme_factory/core/database/meme_dao.dart';
import 'package:meme_factory/core/error/exceptions.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

abstract class MemeListLocalDataSource {
  Future<List<Meme>> getMemes();
  Future<void> insertMemes(List<Meme> memes);
}

class MemeListLocalDataSourceImpl extends MemeListLocalDataSource {
  final MemeDao _memeDao;

  MemeListLocalDataSourceImpl(this._memeDao);

  @override
  Future<List<Meme>> getMemes() async {
    try {
      final memes = await _memeDao.getAllMemes();
      return memes;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> insertMemes(List<Meme> memes) async {
    try {
      await _memeDao.insertAllMemes(memes);
    } catch (e) {
      log('local data insert error: $e');
      throw CacheException();
    }
  }
}
