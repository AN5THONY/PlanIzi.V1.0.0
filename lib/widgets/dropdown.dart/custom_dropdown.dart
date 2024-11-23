import 'package:flutter/material.dart';


class CustomDropdown extends StatelessWidget {
  final String hintText; 
  final List<dynamic> items;
  final String selectedItem;
  final void Function(String?)? onChanged; 
  

  const CustomDropdown({
  required this.hintText,
  required this.items,
  this.selectedItem = '',
  this.onChanged,
  super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: DropdownButtonFormField(
      value: selectedItem,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10)
        )
      ),
      items: items.map<DropdownMenuItem<dynamic>>((dynamic item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
        })
        .toList(), 
      onChanged:(value) {}
      ),
    );
  }
}