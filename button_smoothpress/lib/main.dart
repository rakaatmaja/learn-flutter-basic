import 'package:flutter/material.dart';

import 'button.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPressed = false;
  bool isDarkmode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPressed = isPressed;
            });
          },
          child: Listener(
            onPointerUp: ((PointerUpEvent event) => setState(() {
                  isPressed = true;
                })),
            onPointerDown: ((PointerDownEvent event) => setState(() {
                  isPressed = false;
                })),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              height: 160,
              width: 160,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.android,
                size: 60,
                color: isPressed ? Colors.green : Colors.black,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isPressed
                      ? [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.grey.shade500,
                            offset: const Offset(6, 6),
                            spreadRadius: 1,
                          ),
                          const BoxShadow(
                            blurRadius: 15,
                            color: Colors.white,
                            offset: Offset(-6, -6),
                            spreadRadius: 1,
                          ),
                        ]
                      : null),
            ),
          ),
       
        ),
      ),
    );
  }
}
