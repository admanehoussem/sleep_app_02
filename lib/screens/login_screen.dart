import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignUpTap;
  final VoidCallback onLoginSuccess;
  const LoginScreen(
      {super.key, required this.onSignUpTap, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.nightlight_round,
                  size: 64, color: Colors.indigo),
              const SizedBox(height: 24),
              Text('Welcome Back',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Sign in to continue',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey[600])),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email', prefixIcon: Icon(Icons.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password', prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign In'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: widget.onSignUpTap,
                child: const Text("Don't have an account? Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() => _isLoading = true);
    // TODO: Implement login logic
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    widget.onLoginSuccess();
  }
}
