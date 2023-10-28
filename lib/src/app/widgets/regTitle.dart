import 'package:flutter/material.dart';

class RegTitle extends StatefulWidget {
  final String title;
  const RegTitle({
    super.key,
    required this.title,
  });

  @override
  State<RegTitle> createState() => _RegTitleState();
}

class _RegTitleState extends State<RegTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ),
    );
  }
}
