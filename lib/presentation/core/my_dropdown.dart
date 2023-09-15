import 'dart:developer';

import 'package:flutter/material.dart';
import 'style_elements.dart';

class MyDropdown extends StatefulWidget {
  final List<DropdownMenuEntry<String>>? list;

  const MyDropdown({super.key, this.list});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String _selectedVal = '';
  late final List<PopupMenuItem<String>> _items;

  void initialisePopMenuItems() {
    _items = List.generate(
      5,
      (index) => PopupMenuItem(
        child: Text('Button ${index + 1}'),
        onTap: () {
          log('Tapped index :$index');
          setState(() {
            _selectedVal = 'Button ${index + 1}';
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initialisePopMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(myBorder.borderSide),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            _selectedVal,
            style: bodyMedium,
          ),
          Spacer(),
          PopupMenuButton(
              icon: Image.asset('assets/vectors/Vector.png'),
              itemBuilder: (context) => _items)
        ],
      ),
    );

    // DropdownButtonFormField(
    //     validator: (x) {
    //       if (x == null || x.isEmpty) {
    //         return 'Choose a target element';
    //       } else
    //         return null;
    //     },
    //     padding: EdgeInsets.zero,
    //     iconSize: 12,
    //     decoration: InputDecoration(
    //       enabledBorder: myBorder,
    //       border: myBorder,
    //       filled: true,
    //       fillColor: Colors.white,
    //     ),
    //     style: bodyMedium.copyWith(fontSize: 8),
    //     elevation: 0,
    //     isExpanded: true,
    //     value: buttons.first.value,
    //     onChanged: (String? newValue) {
    //       // setState(() {
    //       //   selectedValue = newValue!;
    //       // });
    //     },
    //     selectedItemBuilder: (context) => [
    //           Text(
    //             'Value',
    //             style: bodyMedium.copyWith(fontSize: 30),
    //           ),
    //         ],
    //     items: buttons);

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
