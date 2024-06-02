import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredEmail = '';
  var _enteredPhone = '';
  var _enteredPassword = '';

  void _submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();

      print(_enteredName);
      print(_enteredEmail);
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
                      'Register',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    ),
                    const SizedBox(height: 6),
                    const Text('Fill the form to register'),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Name'),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return "Name must be at least 3 characters.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredName = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().length < 5 ||
                            !value.trim().contains('@')) {
                          return "Email must be a valid email.";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredEmail = newValue!;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Phone'),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().length < 5) {
                          return "Phone must be a valid phone number.";
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
                          return "Password must be at least 6 characters.";
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
                          'Register',
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
                          print("Login ********************");
                        },
                        child: Text(
                          'Already have an account?',
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
