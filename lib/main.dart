import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cat_breed_controller.dart';
import 'cat_breed_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cat Breeds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatBreedList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CatBreedList extends StatelessWidget {
  final CatBreedController controller = Get.put(CatBreedController());

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    } else {
      return words.take(wordLimit).join(' ') + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Breeds'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) => controller.onSearch(value),
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.hasError.value) {
          return Center(child: Text('Error loading cat breeds.'));
        } else if (controller.filteredBreeds.isEmpty) {
          return Center(child: Text('No cat breeds found.'));
        }

        return ListView.builder(
          itemCount: controller.filteredBreeds.length,
          itemBuilder: (context, index) {
            final breed = controller.filteredBreeds[index];
            return ListTile(
              leading: SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: breed.imageUrl,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.error),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(breed.name),
              subtitle: Text(truncateDescription(breed.description, 20)),
              onTap: () {
                Get.to(() => CatBreedDetailPage(catBreed: breed));
              },
            );
          },
        );
      }),
    );
  }
}
