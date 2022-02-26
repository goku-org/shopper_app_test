import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shopper_app/config/config.dart';
import 'package:shopper_app/models/cart.dart';
import 'package:shopper_app/providers/auth_provider.dart';
import 'package:shopper_app/resources/app_colors.dart';
import 'package:shopper_app/resources/resources.dart';
import 'package:shopper_app/utils/utils.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cartTotal = 0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Shopper Cart',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          TextButton.icon(
              onPressed: () async {
                logEvent(
                    eventName: 'logout', params: {'email': Config.firebaseAuth.currentUser?.email});
                BotToast.showLoading(
                    allowClick: false,
                    clickClose: false,
                    backButtonBehavior: BackButtonBehavior.ignore);
                bool isSuccess = await context.read<AuthProvider>().logUserOut();
                BotToast.closeAllLoading();
                if (isSuccess) {
                  Routemaster.of(context).replace('/login');
                } else {
                  alertNotification(
                      context: context, message: context.read<AuthProvider>().message);
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              )),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: Config.itemCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
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

              return AnimationLimiter(
                child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: ((context, index) {
                      final cart = Cart.fromJson(snapshot.data!.docs[index].data());

                      cartTotal = snapshot.data!.docs.fold(
                          0, (previousValue, element) => element.data()['price'] + previousValue);

                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: cart.url ?? '',
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    fadeInCurve: Curves.easeInOut,
                                    placeholder: (context, url) => const SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Center(child: CircularProgressIndicator())),
                                    errorWidget: (context, url, error) => Container(
                                      height: 70,
                                      width: 70,
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '\$${cart.price ?? 0}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        logEvent(
                                            eventName: 'view_cart_item',
                                            params: {'item': snapshot.data!.docs[index].data()});
                                        Routemaster.of(context).push(
                                            '/cart-detail?id=${snapshot.data!.docs[index].id}');
                                      },
                                      icon: Icon(
                                        Platform.isIOS
                                            ? Icons.arrow_forward_ios
                                            : Icons.arrow_forward,
                                        color: Colors.grey,
                                      ))
                                ],
                              ))));
                    }),
                    separatorBuilder: (__, _) => const Divider(),
                    itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart_checkout),
        label: Text('\$$cartTotal'),
      ),
    );
  }
}
