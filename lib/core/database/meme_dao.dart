import 'package:meme_factory/core/database/database_helper.dart';
import 'package:meme_factory/core/database/db_constants.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';
import 'package:sqflite/sqflite.dart';

class MemeDao {
  final DatabaseHelper databaseHelper;

  MemeDao(this.databaseHelper);

  // Insert multiple memes at once
  Future<void> insertAllMemes(List<Meme> memes) async {
    final db = await databaseHelper.database;

    Batch batch = db.batch(); // Use a batch to insert multiple items at once
    for (Meme meme in memes) {
      batch.insert(
        memeTableName,
        meme.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true); // Commit the batch operation
  }

  // Get all memes at once
  Future<List<Meme>> getAllMemes() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(memeTableName);

    return List.generate(maps.length, (i) {
      return Meme.fromJson(maps[i]);
    });
  }

  // Clear all memes
  Future<void> clearMemes() async {
    final db = await databaseHelper.database;
    await db.delete(memeTableName);
  }
}
