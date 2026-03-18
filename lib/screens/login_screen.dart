import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxxon/main.dart';
import 'package:taxxon/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF00629F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo placeholder/Header
              const Center(
                child: Text(
                  'TAXXON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              // Login Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF00629F),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: 'user@123',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: !authState.isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: '**********',
                          border: const UnderlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              authState.isPasswordVisible 
                                  ? Icons.visibility 
                                  : Icons.visibility_off,
                            ),
                            onPressed: authNotifier.togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (authState.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            authState.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: authState.isLoading 
                            ? null 
                            : () async {
                                await authNotifier.login(
                                  usernameController.text, 
                                  passwordController.text,
                                );
                                if (ref.read(authProvider).isAuthenticated) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const MyHomePage(title: 'Taxxon Home'),
                                    ),
                                  );
                                }
                              },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00629F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: authState.isLoading 
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
