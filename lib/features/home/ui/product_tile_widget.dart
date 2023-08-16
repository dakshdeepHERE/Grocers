import 'package:akshitboc/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({super.key, required this.productDataModel});
  final ProductDataModel productDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(22)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(productDataModel.imageURL))),
          ),
          const SizedBox(height: 20),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(productDataModel.category),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${productDataModel.price}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        // homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                      ))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
