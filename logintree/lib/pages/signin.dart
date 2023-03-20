import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logintree/pages/register.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email harus diisi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                       prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password harus diisi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    prefixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.lock)),
                    suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.remove_red_eye_outlined)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text('Forgot Password?'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      const CircularProgressIndicator();
                      signin();
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text:  TextSpan(
                    text: "Don't have account? ",
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register here',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Sukses'),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void signin() async {
    UserCredential user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password));
  }
}
