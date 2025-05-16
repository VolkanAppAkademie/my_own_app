import 'package:flutter/material.dart';
import 'package:my_own_app/features/add_transaction/screens/home_area.dart';
import 'package:my_own_app/features/authentication/screens/signup_page.dart';
import 'package:my_own_app/features/feature_2/repos/auth_repository.dart';
import 'package:my_own_app/shared/repos/transaction_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.transactionController,
    required this.authRepository,
  });

  final TransactionController transactionController;
  final AuthRepository authRepository;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  bool _showErrorMessage = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorText;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte E-Mail oder Passwort ausfüllen")),
      );
      return;
    }

    // Nutzer einloggen
    errorText = await widget.authRepository.signInWithEmailPassword(
      emailController.text,
      passwordController.text,
    );

    setState(() {
      _showErrorMessage = errorText != null;
    });
  }

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bitte E-Mail oder Passwort ausfüllen")),
      );
      return;
    }

    // Nutzer registrieren
    errorText = await widget.authRepository.registerWithEmailPassword(
      emailController.text,
      passwordController.text,
    );
    setState(() {});
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
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              if (_showErrorMessage)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Anmeldedaten sind nicht korrekt',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.red),
                  ),
                ),
              FilledButton(
                onPressed: () async {
                  await login();
                  if (errorText == null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeArea(
                          transactionController: widget.transactionController,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignupPage(
                        transactionController: widget.transactionController,
                      ),
                    ),
                  );
                },
                child: const Text(
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
