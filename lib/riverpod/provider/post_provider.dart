import 'package:bench_boost_program/riverpod/model/post_model.dart';
import 'package:bench_boost_program/riverpod/services/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Service provider
final postServiceProvider = Provider<PostService>((ref) {
  return PostService();
});

// StateNotifier to manage post list state with loading
class PostNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  final PostService _postService;

  PostNotifier(this._postService) : super(const AsyncValue.loading()) {
    getPosts();
  }

  Future<void> getPosts() async {
    state = const AsyncValue.loading();
    try {
      final posts = await _postService.getPosts();
      state = AsyncValue.data(posts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// StateNotifierProvider for the post list
final postProvider =
    StateNotifierProvider<PostNotifier, AsyncValue<List<PostModel>>>((ref) {
  final postService = ref.watch(postServiceProvider);
  return PostNotifier(postService);
});
