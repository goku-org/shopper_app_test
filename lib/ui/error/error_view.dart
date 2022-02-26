import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopper_app/resources/app_colors.dart';
import 'package:shopper_app/resources/resources.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              SvgImages.notFound,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 35),
            SelectableText(
              message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 25,
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('OK',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white))),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
