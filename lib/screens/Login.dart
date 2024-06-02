import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredPhone = '';
  var _enteredPassword = '';

  void _submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      print(_enteredPhone);
      print(_enteredPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                    const SizedBox(height: 6),
                    const Text('Fill the form to login'),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Phone'),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return "Please enter a valid phone number.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredPhone = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Password'),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return "Please enter a valid password.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredPassword = newValue!;
                      },
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                                fontSize: 20,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          print("Register ********************");
                        },
                        child: Text(
                          'Register',
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
