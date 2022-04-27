import 'package:flutter_cubit_pagination/features/posts/data/datasources/posts_datasource.dart';
import 'package:flutter_cubit_pagination/features/posts/data/models/post_model.dart';

class PostsRepository {
  final PostsDatasource datasource;
  PostsRepository({
    required this.datasource,
  });

  Future<List<PostModel>> fetchPosts({required int page}) async {
    final response = await datasource.fetchPosts(page: page);
    return response.map((e) => PostModel.fromJson(e)).toList();
  }
}
