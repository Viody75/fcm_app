import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget(
      {super.key,
      required this.item,
      required this.items,
      required this.onChanged});

  final String item;
  final List<String> items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isDense: true,
          value: item,
          elevation: 1,
          borderRadius: BorderRadius.circular(24),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.expand_more),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
