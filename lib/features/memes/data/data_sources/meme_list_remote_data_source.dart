import 'package:meme_factory/core/constants/api_url.dart';
import 'package:meme_factory/core/network/api_client.dart';
import 'package:meme_factory/core/network/return_response.dart';
import 'package:meme_factory/features/memes/data/models/meme.dart';

abstract class MemeListRemoteDataSource {
  Future<List<Meme>> getMemes();
}

class MemeListRemoteDataSourceImpl extends MemeListRemoteDataSource {
  final ApiClient apiClient;

  MemeListRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<Meme>> getMemes() async {
    final response = await apiClient.get(ApiUrl.getMemes);

    return ReturnResponse<List<Meme>>()(
        response,
        (data) => (data['data']['memes'] as List)
            .map((json) => Meme.fromJson(json))
            .toList());
  }
}
