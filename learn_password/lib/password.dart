import 'package:flutter/material.dart';

class TextFieldExample extends StatefulWidget {
  @override
  _TextFieldExampleState createState() => _TextFieldExampleState();
}

class _TextFieldExampleState extends State<TextFieldExample> {
  @override
  Widget build(BuildContext context) {
    return TextField();
  }

  bool _showPassword = false;

  Widget builPassword() {
    return TextField(
      obscureText: !this._showPassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.security),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.remove_red_eye,
            color: this._showPassword ? Colors.blue : Colors.white,
          ),
          onPressed: () {
            setState(
              () => this._showPassword = !this._showPassword,
            );
          },
        ),
      ),
    );
  }
}
