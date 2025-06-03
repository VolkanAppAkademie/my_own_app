import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_own_app/features/feature_2/repos/firebase_auth_repository.dart';
import 'package:provider/provider.dart';
import 'package:my_own_app/budget_provider.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final authRepository =
          Provider.of<FirebaseAuthRepository>(context, listen: false);

      final errorMessage =
          await authRepository.registerWithEmailPassword(email, password);

      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeArea(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unerwarteter Fehler: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Account erstellen',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Keine gültige Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  obscureText: _isObscure,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Mindestens 8 Zeichen eingeben';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Passwort',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _isObscure = !_isObscure);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  obscureText: _isObscure,
                  controller: passwordController2,
                  validator: (value) {
                    if (value == null || value != passwordController.text) {
                      return 'Passwörter nicht identisch!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Passwort wiederholen',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() => _isObscure = !_isObscure);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24),
                FilledButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Account erstellen'),
                ),
                SizedBox(height: 20),
                Text(
                  'Hast du bereits einen Account?',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Zum Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
