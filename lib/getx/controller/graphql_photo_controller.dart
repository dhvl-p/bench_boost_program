import 'package:get/get.dart';
import 'package:bench_boost_program/getx/model/photo_model.dart';
import 'package:bench_boost_program/getx/services/graphql_photo_service.dart';

class GraphQLPhotoController extends GetxController {
  final GraphQLPhotoService _photoService = GraphQLPhotoService();

  final RxList<PhotoModel> photos = <PhotoModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhotos();
  }

  /// Fetches photos using the GraphQL service.
  Future<void> fetchPhotos() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await _photoService.fetchPhotos(limit: 20);
      photos.assignAll(result);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  /// Refreshes the photo list.
  Future<void> refreshPhotos() async {
    await fetchPhotos();
  }
}
