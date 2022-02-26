import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shopper_app/config/config.dart';
import 'package:shopper_app/ui/auth/forgot_password_view.dart';
import 'package:shopper_app/ui/auth/login_view.dart';
import 'package:shopper_app/ui/cart/cart_detail_view.dart';
import 'package:shopper_app/ui/cart/cart_view.dart';
import 'package:shopper_app/ui/error/error_view.dart';

final routes = RouteMap(
  onUnknownRoute: (route) => const Redirect('/error'),
  routes: {
    '/login': (context) => const MaterialPage(child: LoginView()),
    '/forgot-ppassword': (context) => const MaterialPage(child: ForgotPasswordView()),
    '/error': (context) => MaterialPage(
            child: ErrorView(
          message: '${context.toRouteInformation().location} not found',
        )),
    '/cart-detail': (context) {
      final id = context.queryParameters['id']!;
      return MaterialPage(child: CartDetailView(cartId: id));
    },
    '/': (route) {
      final isAuth = Config.firebaseAuth.currentUser != null;
      if (isAuth) return const MaterialPage(child: CartView());
      return const Redirect('/login');
    }
  },
);
