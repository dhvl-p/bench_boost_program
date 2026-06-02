// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhotoStore on _PhotoStore, Store {
  late final _$photosAtom = Atom(name: '_PhotoStore.photos', context: context);

  @override
  ObservableList<PhotoModel> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<PhotoModel> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PhotoStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$hasErrorAtom = Atom(
    name: '_PhotoStore.hasError',
    context: context,
  );

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_PhotoStore.errorMessage',
    context: context,
  );

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchPhotosAsyncAction = AsyncAction(
    '_PhotoStore.fetchPhotos',
    context: context,
  );

  @override
  Future<void> fetchPhotos() {
    return _$fetchPhotosAsyncAction.run(() => super.fetchPhotos());
  }

  late final _$refreshPhotosAsyncAction = AsyncAction(
    '_PhotoStore.refreshPhotos',
    context: context,
  );

  @override
  Future<void> refreshPhotos() {
    return _$refreshPhotosAsyncAction.run(() => super.refreshPhotos());
  }

  @override
  String toString() {
    return '''
photos: ${photos},
isLoading: ${isLoading},
hasError: ${hasError},
errorMessage: ${errorMessage}
    ''';
  }
}
