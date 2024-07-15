import 'package:flutter/material.dart';
import 'package:jailerecord/features/auth/screens/signin.dart';
import 'package:jailerecord/features/auth/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _badgeController = TextEditingController();
  bool _isPolice = true;
  // final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final _scwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lawyer',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Switch(
                      value: _isPolice,
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          _isPolice = value;
                        });
                        print(_isPolice);
                      }),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text(
                    'Police',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 81, 100, 207),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isPolice ? 'Police REGISTER' : 'Lawyer REGISTER',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      // keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.white.withAlpha(100),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      // keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Colors.white.withAlpha(100),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _isPolice
                        ? Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Police Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withAlpha(100),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              TextFormField(
                                controller: _badgeController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  hintText: 'Enter Badge',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withAlpha(100),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Lawyer Name',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withAlpha(100),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              TextFormField(
                                controller: _contactController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  hintText: 'Enter Contact',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withAlpha(100),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                    ElevatedButton(
                        onPressed: () {
                          _isPolice
                              ? AuthService.signUp(
                                  context: context,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: 'police',
                                  badge: _badgeController.text)
                              : AuthService.signUp(
                                  context: context,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  role: 'lawyer',
                                  contact: _contactController.text);
                        },
                        child: Text('Register')),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
