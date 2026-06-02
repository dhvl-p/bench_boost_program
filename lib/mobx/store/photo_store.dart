import 'package:mobx/mobx.dart';
import 'package:bench_boost_program/getx/model/photo_model.dart';
import 'package:bench_boost_program/getx/services/photo_service.dart';

part 'photo_store.g.dart';

// ignore: library_private_types_in_public_api
class PhotoStore = _PhotoStore with _$PhotoStore;

abstract class _PhotoStore with Store {
  final PhotoService _photoService = PhotoService();

  @observable
  ObservableList<PhotoModel> photos = ObservableList<PhotoModel>();

  @observable
  bool isLoading = false;

  @observable
  bool hasError = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> fetchPhotos() async {
    try {
      isLoading = true;
      hasError = false;
      errorMessage = '';

      final result = await _photoService.fetchPhotos();
      photos.clear();
      photos.addAll(result);
    } catch (e) {
      hasError = true;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> refreshPhotos() async {
    await fetchPhotos();
  }
}
