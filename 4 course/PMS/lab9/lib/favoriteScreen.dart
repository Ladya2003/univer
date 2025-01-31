import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/service/favoriteService.dart';
import '/service/productService.dart';
import '/service/userService.dart';

import 'bloc/FavoritesBloc.dart';
import 'bloc/UserBloc.dart';
import 'event/FavoritesEvent.dart';
import 'event/FavoritesState.dart';
import 'models/favoriteItem.dart';
import 'models/product.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: BlocProvider(
        create: (context) => FavoritesBloc(
          FavoriteService(),
          context.read<UserBloc>(), // Получаем UserBloc из контекста
        )..add(LoadFavorites()),
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              if (state.favorites.isEmpty) {
                return Center(child: Text('No favorites added.'));
              }
              return ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final product = state.favorites[index];

                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<FavoritesBloc>().add(RemoveFromFavorites(product.key as int));
                      },
                    ),
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

