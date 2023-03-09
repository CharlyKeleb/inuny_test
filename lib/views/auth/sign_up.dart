import 'package:flutter/material.dart';
import 'package:inuny_test/components/animation/fade_animation.dart';
import 'package:inuny_test/components/loading_indicator.dart';
import 'package:inuny_test/components/text_form_builder.dart';
import 'package:inuny_test/utils/validations.dart';
import 'package:inuny_test/view_models/auth/sign_up_view_model.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    SignUpViewModel viewModel = Provider.of<SignUpViewModel>(context);
    double maxHeight = MediaQuery.of(context).size.height;
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
                height: maxHeight < 800
                    ? MediaQuery.of(context).size.height / 12
                    : MediaQuery.of(context).size.height / 6,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logo/logo.png',
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ).fadeInList(
                  0,
                  true,
                  curve: Curves.easeInCirc,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              buildForm(context, viewModel)
            ],
          ),
        ),
      ),
    );
  }

  buildForm(context, SignUpViewModel viewModel) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: viewModel.cPassword.isNotEmpty ? 250.0 : 235.0,
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
                      prefix: Image.asset('assets/icons/pw.png'),
                      textInputAction: TextInputAction.next,
                      validateFunction: Validations.validatePassword,
                      obscureText: true,
                      hasSuffix: true,
                      onSaved: (String val) {
                        viewModel.setPassword(val);
                      },
                      focusNode: viewModel.passFN,
                      nextFocusNode: viewModel.cPassFN,
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
                      hintText: 'Repeat Password',
                      prefix: Image.asset('assets/icons/pw.png'),
                      textInputAction: TextInputAction.done,
                      validateFunction: Validations.validatePassword,
                      submitAction: () => viewModel.register(context),
                      obscureText: true,
                      hasSuffix: true,
                      onSaved: (String val) {
                        viewModel.setConfirmPass(val);
                      },
                      focusNode: viewModel.cPassFN,
                    ),
                  ],
                ),
              ),
            ),
          ).fadeInList(1, true),
          const SizedBox(height: 20.0),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () => viewModel.register(context),
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
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ).fadeInList(2, false),
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
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ).fadeInList(3, false)
        ],
      ),
    );
  }
}
