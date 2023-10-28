import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  const TextFieldWidget({super.key, required this.hint, required this.obscure, required this.controller});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        obscureText: widget.obscure,
        decoration: InputDecoration(
          hintText: widget.hint, // Set your hint text here
          hintStyle: TextStyle(color: Color.fromRGBO(83, 83, 83, 1)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          filled: true,
          fillColor: Colors.black,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(20),
        ],
      ),
    );
  }
}
