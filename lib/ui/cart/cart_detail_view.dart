import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopper_app/config/config.dart';
import 'package:shopper_app/models/cart.dart';
import 'package:shopper_app/resources/app_colors.dart';
import 'package:shopper_app/resources/resources.dart';

class CartDetailView extends StatelessWidget {
  const CartDetailView({Key? key, required this.cartId}) : super(key: key);

  final String cartId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Cart Item',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: Config.itemCollection.doc(cartId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.done && snapshot.data == null ||
                snapshot.data?.exists == false) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      SvgImages.notFound,
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 35),
                    SelectableText(
                      'Your cart is empty!',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            final cart = Cart.fromJson(snapshot.data!.data()!);
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CachedNetworkImage(
                  imageUrl: cart.url ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                        child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                    )),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Name:', style: Theme.of(context).textTheme.bodyText2),
                Text(cart.name ?? 'Not provided',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                Text('Price:', style: Theme.of(context).textTheme.bodyText2),
                Text('\$${cart.price ?? 0}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            );
          }),
    );
  }
}
