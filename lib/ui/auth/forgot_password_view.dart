import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shopper_app/providers/auth_provider.dart';
import 'package:shopper_app/resources/app_colors.dart';
import 'package:shopper_app/utils/utils.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final RegExp emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final TextEditingController emailTextEditingController = TextEditingController();

  bool isEmailValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Routemaster.of(context).push('/login'),
        ),
        title: Text(
          'Reset your password',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Start your journey today with Shopper',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 45,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email address',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: emailTextEditingController,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w600),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                    contentPadding: const EdgeInsets.all(15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                    enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                    disabledBorder: Theme.of(context).inputDecorationTheme.disabledBorder,
                    errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
                    focusedErrorBorder: Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    filled: true,
                    labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                    errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                    suffixIcon: Visibility(
                        visible: isEmailValid,
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ))),
                onChanged: (value) {
                  if (emailValid.hasMatch(value)) {
                    setState(() {
                      isEmailValid = true;
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!emailValid.hasMatch(value)) {
                    return 'Email is invalid';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
            onPressed: () async {
              logEvent(eventName: 'open_password_reset');

              if (emailTextEditingController.text.isNotEmpty) {
                BotToast.showLoading(
                    allowClick: false,
                    clickClose: false,
                    backButtonBehavior: BackButtonBehavior.ignore);
                bool isSuccess = await context
                    .read<AuthProvider>()
                    .sendPasswordResetLink(email: emailTextEditingController.text);
                BotToast.closeAllLoading();
                if (isSuccess) {
                  alertNotification(
                      context: context,
                      message: 'Please check your email for the password reset link!');
                  Future.delayed(const Duration(seconds: 2), () {
                    Routemaster.of(context).replace('/loginView');
                  });
                } else {
                  alertNotification(
                      context: context, message: context.read<AuthProvider>().message);
                }
              } else {
                alertNotification(context: context, message: 'Fields cannot be Empty');
              }
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 68,
              child: Center(
                child: Text('Send reset link',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white)),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  logEvent(eventName: 'open_login_view');
                  Routemaster.of(context).push('/login');
                },
                child: Text(
                  'Want to Login? Do it here',
                  textAlign: TextAlign.right,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(decoration: TextDecoration.underline),
                )),
          ),
        ],
      ),
    );
  }
}
