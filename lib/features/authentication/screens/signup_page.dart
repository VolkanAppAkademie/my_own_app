import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/authentication/screens/login_page.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.transactionController});
  final TransactionController transactionController;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

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
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null ||
                        !value.contains('@') ||
                        !value.contains('.com')) {
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
                        setState(() {
                          _isObscure = !_isObscure;
                        });
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
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeArea(
                            transactionController: widget.transactionController,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Account erstellen'),
                ),
                SizedBox(height: 20),
                Text(
                  'Hast du bereits einen Account?',
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
