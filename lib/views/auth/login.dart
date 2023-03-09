import 'package:flutter/material.dart';
import 'package:inuny_test/components/animation/fade_animation.dart';
import 'package:inuny_test/components/loading_indicator.dart';
import 'package:inuny_test/components/text_form_builder.dart';
import 'package:inuny_test/utils/navigate.dart';
import 'package:inuny_test/utils/validations.dart';
import 'package:inuny_test/view_models/auth/login_view_model.dart';
import 'package:inuny_test/views/auth/sign_up.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);
    final double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: viewModel.scaffoldKey,
      body: LoadingOverlay(
        isLoading: viewModel.loading,
        progressIndicator: loadingIndicator(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo/logo.png',
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ).fadeInList(0, true, curve: Curves.easeInCirc),
              ),
              const SizedBox(
                height: 40.0,
              ),
              buildForm(context, viewModel, maxHeight)
            ],
          ),
        ),
      ),
    );
  }

  buildForm(context, LoginViewModel viewModel, maxHeight) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: viewModel.password.isNotEmpty ? 180.0 : 160.0,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffFAFAFA),
              border: Border.all(
                color: const Color(0xffD2D2D2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormBuilder(
                      enabled: !viewModel.loading,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      hintText: 'Email',
                      prefix: Image.asset('assets/icons/mail.png'),
                      textInputAction: TextInputAction.next,
                      validateFunction: Validations.validateEmail,
                      onSaved: (String val) {
                        viewModel.setEmail(val);
                      },
                      focusNode: viewModel.emailFN,
                      nextFocusNode: viewModel.passFN,
                    ),
                    const SizedBox(
                      height: 1,
                      child: Divider(thickness: 1),
                    ),
                    TextFormBuilder(
                      enabled: !viewModel.loading,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      hintText: 'Password',
                      hasSuffix: true,
                      prefix: Image.asset('assets/icons/pw.png'),
                      textInputAction: TextInputAction.done,
                      validateFunction: Validations.validatePassword,
                      submitAction: () => viewModel.login(context),
                      obscureText: true,
                      onSaved: (String val) {
                        viewModel.setPassword(val);
                      },
                      focusNode: viewModel.passFN,
                    ),
                  ],
                ),
              ),
            ),
          ).fadeInList(1, false),
          const SizedBox(height: 20.0),
          InkWell(
            onTap: () => viewModel.forgotPassword(context),
            child: const Text(
              'Forgot your Password?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Color(0xff8C8C8C),
              ),
            ).fadeInList(2, false),
          ),
          SizedBox(
            height: maxHeight < 800
                ? MediaQuery.of(context).size.height / 12
                : MediaQuery.of(context).size.height / 6.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () => viewModel.login(context),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ).fadeInList(3, false),
          const SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have an account? ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: Color(0xff8C8C8C),
                ),
              ),
              InkWell(
                onTap: () => Navigate.pushPage(
                  context,
                  const SignUp(),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ).fadeInList(4, false)
        ],
      ),
    );
  }
}
