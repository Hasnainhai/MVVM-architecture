import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/components/rounded_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/routes/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp View'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'email',
                  label: Text('email'),
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onFieldSubmitted: (value) {
                  Utils.focusNode(context, _emailFocusNode, _passwordFocusNode);
                },
              ),
              const SizedBox(height: 20.0),
              ValueListenableBuilder(
                  valueListenable: _obscurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      focusNode: _passwordFocusNode,
                      obscureText: _obscurePassword.value,
                      obscuringCharacter: '*',
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'password',
                        label: const Text('password'),
                        prefixIcon: const Icon(Icons.lock),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obscurePassword.value = !_obscurePassword.value;
                          },
                          child: Icon(
                            _obscurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: height * .1),
              RoundedButton(
                title: 'SignUp',
                loading: authViewModel.signupLoading,
                onpress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'please enter your email', context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'please enter your password', context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        'plase enter more than six digits', context);
                  } else {
                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    authViewModel.signUpApi(data, context);
                    print('SuccessFully Register');
                  }
                },
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text("Already have Account Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
