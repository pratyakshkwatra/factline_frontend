import 'package:dio/dio.dart';
import 'package:factline/api/models/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_client.dart';
import 'exceptions.dart';

class PostAPI {
  final _dio = ApiClient().dio;
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> getAnalysisStatus(int postId) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      final response = await _dio.get(
        '/posts/$postId/status',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      return response.data;
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to get analysis status',
        e.response?.statusCode,
      );
    }
  }

  Future<void> createPost(String title, String body) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) {
        throw APIException('Not authenticated', 401);
      }

      await _dio.post(
        '/posts/',
        data: {'title': title, 'body': body},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to create post',
        e.response?.statusCode,
      );
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) {
        throw APIException('Not authenticated', 401);
      }

      await _dio.delete(
        '/posts/$postId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to delete post',
        e.response?.statusCode,
      );
    }
  }

  Future<void> upvotePost(int postId) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      await _dio.post(
        '/posts/$postId/upvote',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to upvote post',
        e.response?.statusCode,
      );
    }
  }

  Future<void> downvotePost(int postId) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      await _dio.post(
        '/posts/$postId/downvote',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to downvote post',
        e.response?.statusCode,
      );
    }
  }

  Future<void> viewPost(int postId) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      await _dio.post(
        '/posts/$postId/view',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to record view',
        e.response?.statusCode,
      );
    }
  }

  Future<List<Post>> getRecommendations() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      final response = await _dio.get(
        '/posts/recommendations',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      final List data = response.data;

      return data.map((json) => Post.fromJson(json)).toList();
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to load recommendations',
        e.response?.statusCode,
      );
    }
  }

  Future<List<Post>> getBreakingNews() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      if (accessToken == null) throw APIException('Not authenticated', 401);

      final response = await _dio.get(
        '/posts/breaking-news',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      final List data = response.data;

      return data.map((json) => Post.fromJson(json)).toList();
    } on DioException catch (e) {
      throw APIException(
        e.message ?? 'Failed to load breaking news',
        e.response?.statusCode,
      );
    }
  }
}
