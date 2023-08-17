import 'package:akshitboc/features/cart/ui/cart.dart';
import 'package:akshitboc/features/home/bloc/home_bloc.dart';
import 'package:akshitboc/features/home/ui/product_tile_widget.dart';
import 'package:akshitboc/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeCartedProductActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Item Added to Cart'),
          ));
        } else if (state is HomeWishlistedProductActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Item Wishlisted'),
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Grocers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text('Error')));

          default:
            return SizedBox();
        }
      },
    );
  }
}
