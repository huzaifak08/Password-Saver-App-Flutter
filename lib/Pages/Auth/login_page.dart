import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Helper/helper_function.dart';
import 'package:password_saver/Pages/home_page.dart';
import 'package:password_saver/Services/auth_service.dart';

import '../../Widgets/widgets.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String email = '';
  String password = '';
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    getUserNameFromSF();
    super.initState();
  }

  getUserNameFromSF() {
    HelperFunction.getUserNameSF().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Secretia',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text("Login to see what you've saved!",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                Image.asset('assets/login.png'),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      debugPrint(email);
                    });
                  },
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : 'Enter a valid Email';
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      debugPrint(password);
                    });
                  },
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password must be atleast 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      login();
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    children: [
                      TextSpan(
                        text: 'Create account',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            nextScreen(context, const RegisterPage());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.loginWithEmailAndPassword(email, password).then((value) {
        if (value == true) {
          setState(() {
            _isLoading = false;
          });
          nextScreenReplace(context, const HomePage());
          toastMessage('Welcome $userName');
        } else {
          setState(() {
            _isLoading = false;
          });
          toastMessage(value);
        }
      });
    }
  }
}
