import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/authentication/screens/signup_page.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.transactionController});
  final TransactionController transactionController;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  bool _showErrorMessage = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    print('Das hier wird aufgerufen, wenn dieses Widget aufgeräumt wird');
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Passwort',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (_showErrorMessage)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Anmeldedaten sind nicht korrekt',
                    style: TextTheme.of(context)
                        .bodyMedium
                        ?.copyWith(color: Colors.red),
                  ),
                ),
              FilledButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  print('Email ist: $email und Passwort ist: $password');
                  if (email == 'autobahn@web.de' && password == 'Tunnelfisch') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeArea(
                            transactionController:
                                widget.transactionController),
                      ),
                    );
                  } else {
                    setState(() {
                      _showErrorMessage = true;
                    });
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignupPage(
                          transactionController: widget.transactionController),
                    ),
                  );
                },
                child: Text(
                  'Noch kein Account?',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
