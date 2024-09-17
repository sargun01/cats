import 'package:flutter/material.dart';
import 'cat_breed.dart';

class CatBreedDetailPage extends StatelessWidget {
  final CatBreed catBreed;

  CatBreedDetailPage({required this.catBreed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catBreed.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                catBreed.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 40),
            Text(
              catBreed.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
