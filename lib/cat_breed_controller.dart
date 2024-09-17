import 'package:get/get.dart';
import 'cat_data.dart';
import 'cat_breed.dart';
import 'dart:async';

class CatBreedController extends GetxController {
  var catBreeds = <CatBreed>[].obs;
  var filteredBreeds = <CatBreed>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  final RxString searchQuery = ''.obs;
  Timer? debounce;

  @override
  void onInit() {
    loadCatBreeds();
    searchQuery.listen((query) {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 300), () {
        filterBreeds(query);
      });
    });
    super.onInit();
  }

  Future<void> loadCatBreeds() async {
    try {
      isLoading.value = true;
      final breeds = await CatData.loadCatBreeds();
      catBreeds.assignAll(breeds);
      filteredBreeds.assignAll(breeds); // Initialize with all breeds
      isLoading.value = false;
    } catch (e) {
      hasError.value = true;
      isLoading.value = false;
    }
  }

  void filterBreeds(String query) {
    if (query.isEmpty) {
      filteredBreeds.assignAll(catBreeds);
    } else {
      filteredBreeds.assignAll(
        catBreeds.where((breed) => breed.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }
}
