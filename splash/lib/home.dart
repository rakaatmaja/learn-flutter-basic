import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Splash'),
      ),
      body: Container(
        child: Center(child: Text('this text')),
      ),
    );
  }
}
