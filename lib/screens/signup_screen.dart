import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onLoginTap;
  final VoidCallback onSignUpSuccess;
  const SignUpScreen(
      {super.key, required this.onLoginTap, required this.onSignUpSuccess});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
              Text('Create Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Sign up to get started',
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
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline)),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: widget.onLoginTap,
                child: const Text('Already have an account? Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() => _isLoading = true);
    // TODO: Implement sign-up logic
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    widget.onSignUpSuccess();
  }
}
