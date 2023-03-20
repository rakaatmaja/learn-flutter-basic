import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Buttonku extends StatefulWidget {
  bool isPressedd;
  bool isDarkmode;
  // ignore: prefer_typing_uninitialized_variables

   Buttonku({Key? key, required this.isPressedd, required this.isDarkmode}) : super(key: key);

  @override
  State<Buttonku> createState() => _ButtonkuState();
}

class _ButtonkuState extends State<Buttonku> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: ((PointerUpEvent event) => setState(() {
        widget.isPressedd = true;
      })),
      onPointerDown: ((PointerDownEvent event) => setState(() {
        widget.isPressedd = false;
      })),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        height: 160,
        width: 160,
        // ignore: sort_child_properties_last
        child:  Icon(
          Icons.android,
          size: 60,
          color: widget.isPressedd ? Colors.green : Colors.black,
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
            boxShadow: widget.isPressedd ?  [
              BoxShadow(
                blurRadius: 15,
                color:  Colors.grey.shade500,
                offset: const Offset(6, 6),
                spreadRadius: 1,
              ),
              const BoxShadow(
                blurRadius: 15,
                color: Colors.white,
                offset: Offset(-6, -6),
                spreadRadius: 1,
              ),
            ] : null),
      ),
    );
  }
}
