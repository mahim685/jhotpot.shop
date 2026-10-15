import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    
    var user = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('লগইন সফল হয়েছে!')),
      );
      // এখানে ইউজারের রোল অনুযায়ী নির্দিষ্ট ড্যাশবোর্ডে রিডাইরেক্ট হবে
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('লগইন ব্যর্থ হয়েছে। ইমেইল বা পাসওয়ার্ড পরীক্ষা করুন।')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jhotpot Shop - লগইন'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'ইমেইল',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'পাসওয়ার্ড',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('লগইন করুন', style: TextStyle(fontSize: 18)),
                  ),
          ],
        ),
      ),
    );
  }
}