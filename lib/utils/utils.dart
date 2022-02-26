import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shopper_app/config/config.dart';

Future logEvent({required String eventName, Map<String, dynamic>? params}) async {
  await Config.analytics.logEvent(
      name: eventName, parameters: params, callOptions: AnalyticsCallOptions(global: true));
}

alertNotification({required String message, required BuildContext context, int duration = 3}) {
  return BotToast.showSimpleNotification(
      duration: Duration(seconds: duration),
      title: message,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: 10,
      align: Alignment.topCenter);
}
