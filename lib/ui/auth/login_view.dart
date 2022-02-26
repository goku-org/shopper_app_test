import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shopper_app/providers/auth_provider.dart';
import 'package:shopper_app/resources/app_colors.dart';
import 'package:shopper_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login to your account',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
                  style:
                      Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w600),
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
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 7,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordTextEditingController,
                  focusNode: passwordFocusNode,
                  style:
                      Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w600),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
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
                          visible: isPasswordValid,
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ))),
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 6) {
                      setState(() {
                        isPasswordValid = true;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password cannot be empty';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    logEvent(eventName: 'goto_forgot_password');
                    Routemaster.of(context).push('/forgot-ppassword');
                  },
                  child: Text(
                    'I forgot my password',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        decoration: TextDecoration.underline, color: AppColors.accentColor),
                  )),
            ),
            const SizedBox(
              height: 55,
            ),
            RichText(
                text: TextSpan(
                    text: 'By logging in, you have read and agreed with our ',
                    children: [
                      WidgetSpan(
                          child: InkWell(
                        onTap: () {
                          logEvent(eventName: 'open_terms_and_conditions');
                          openTermsUrl(url: 'https://etornam.dev');
                        },
                        child: Text('Terms & Conditions',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: AppColors.accentColor,
                                decoration: TextDecoration.underline)),
                      )),
                      WidgetSpan(
                          child: Text(' and also our ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.grey))),
                      WidgetSpan(
                          child: InkWell(
                        onTap: () {
                          logEvent(eventName: 'open_privacy_conditions');
                          openTermsUrl(url: 'https://etornam.dev');
                        },
                        child: Text('Privacy policy.',
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: AppColors.accentColor,
                                decoration: TextDecoration.underline)),
                      ))
                    ],
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey))),
            const SizedBox(
              height: 25,
            ),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(15)),
              onPressed: () async {
                logEvent(
                    eventName: 'login_action',
                    params: {'email': emailTextEditingController.text});

                if (_formKey.currentState!.validate()) {
                  BotToast.showLoading(
                      allowClick: false,
                      clickClose: false,
                      backButtonBehavior: BackButtonBehavior.ignore);
                  bool isSuccess = await context.read<AuthProvider>().loginUser(
                      email: emailTextEditingController.text,
                      password: passwordTextEditingController.text);
                  BotToast.closeAllLoading();
                  if (isSuccess) {
                    Routemaster.of(context).replace('/');
                  } else {
                    alertNotification(
                        context: context, message: context.read<AuthProvider>().message);
                  }
                } else {
                  alertNotification(context: context, message: 'Fields cannot be Empty');
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('CONTINUE',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  openTermsUrl({required String url}) async {
    await canLaunch(url)
        ? await launch(url)
        : alertNotification(message: 'Could not open $url', context: context);
  }
}
