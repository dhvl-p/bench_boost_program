import 'package:get/get.dart';
import 'package:bench_boost_program/getx/model/photo_model.dart';
import 'package:bench_boost_program/getx/services/photo_service.dart';

class PhotoController extends GetxController {
  final PhotoService _photoService = PhotoService();

  final RxList<PhotoModel> photos = <PhotoModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhotos();
  }

  /// Fetches all photos from the API.
  Future<void> fetchPhotos() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await _photoService.fetchPhotos();
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
