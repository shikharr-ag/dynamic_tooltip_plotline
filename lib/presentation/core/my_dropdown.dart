import 'package:flutter/material.dart';

import 'constants.dart';
import 'style_elements.dart';

class MyDropdown extends StatefulWidget {
  final List<DropdownMenuEntry<String>>? list;

  const MyDropdown({super.key, this.list});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        padding: null,
        iconSize: 20,
        decoration: InputDecoration(
          enabledBorder: myBorder,
          border: myBorder,
          filled: true,
          fillColor: Colors.white,
        ),
        elevation: 0,
        isExpanded: true,
        value: buttons.first.value,
        onChanged: (String? newValue) {
          // setState(() {
          //   selectedValue = newValue!;
          // });
        },
        items: buttons);

    // DropdownMenu<String>(
    //   initialSelection: widget.list.first.value,
    //   width: widget.width,
    //   onSelected: (String? value) {
    //     // This is called when the user selects an item.
    //     // setState(() {
    //     //   dropdownValue = value!;
    //     // });
    //   },
    //   dropdownMenuEntries: widget.list
    //       .map<DropdownMenuEntry<String>>((DropdownMenuEntry<String> value) {
    //     return value;
    //   }).toList(),
    // );
  }
}
