import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/favorites_provider.dart';
import '/user_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoritesProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : favoritesProvider.favorites.isEmpty
          ? Center(child: Text('No favorites added.'))
          : ListView.builder(
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final product = favoritesProvider.favorites[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                favoritesProvider.removeFavorite(userProvider.currentUser!.id, product.key as int);
              },
            ),
          );
        },
      ),
    );
  }
}
