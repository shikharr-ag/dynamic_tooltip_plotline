import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dynamic_tooltip_plotline/application/tooltip/data_provider.dart';
import 'package:dynamic_tooltip_plotline/infrastructure/tooltip/logo_api_repository.dart';

import 'style_elements.dart';

class MyDropdown extends StatefulWidget {
  final List<String>? items;
  final bool updateTargetElementState;
  final bool updateBackgroundStyleState;
  final bool updateBackgroundStyleSourceState;
  final void Function(String x)? updateLogoUrl;
  final void Function(String x)? updateSource;
  const MyDropdown({
    Key? key,
    this.items,
    this.updateTargetElementState = false,
    this.updateBackgroundStyleState = false,
    this.updateBackgroundStyleSourceState = false,
    this.updateLogoUrl,
    this.updateSource,
  }) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String _selectedVal = '';
  late final List<PopupMenuItem<String>> _items;

  void updateState(DataProvider prov) {
    if (widget.updateBackgroundStyleState) {
      prov.setBackgroundStyleDomainSet(_selectedVal);
    } else if (widget.updateTargetElementState) {
      prov.setTargetElementState(_selectedVal);
    } else if (widget.updateBackgroundStyleSourceState) {
      prov.setBackgroundStyleSourceState(_selectedVal);
    }
  }

  String getAppropriateVal() {
    return _selectedVal.isEmpty
        ? (widget.updateBackgroundStyleState
            ? 'Choose a company'
            : widget.updateTargetElementState
                ? 'Choose a target element'
                : widget.updateBackgroundStyleSourceState
                    ? 'Choose image src'
                    : '')
        : _selectedVal;
  }

  void initialisePopMenuItems() {
    DataProvider prov = Provider.of<DataProvider>(context, listen: false);
    _items = List.generate(
      widget.items == null ? 5 : widget.items!.length,
      (index) => PopupMenuItem(
        child: Text(widget.items == null
            ? 'Button ${index + 1}'
            : widget.items![index]),
        onTap: () {
          log('Tapped index :$index');
          _selectedVal = widget.items == null
              ? 'Button ${index + 1}'
              : widget.items![index];
          updateState(prov);

          ///Generates Logo Url from Repo
          ///_selectedVal here is the company name
          if (widget.updateBackgroundStyleState) {
            if (widget.updateLogoUrl != null) {
              widget.updateLogoUrl!(LogoAPIRepository().getUri(_selectedVal));
            }
          }
          if (widget.updateBackgroundStyleSourceState) {
            if (widget.updateSource != null) {
              widget.updateSource!(_selectedVal);
            }
          }
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          Consumer<DataProvider>(builder: (context, prov, _) {
            _selectedVal = widget.updateBackgroundStyleState
                ? prov.backgroundStyleDomainState
                : (widget.updateTargetElementState
                    ? prov.targetElementState
                    : widget.updateBackgroundStyleSourceState
                        ? prov.backgroundStyleSourceState
                        : '');
            return Text(
              getAppropriateVal(),
              style: _selectedVal.isEmpty ? bodySmall : bodyMedium,
            );
          }),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: PopupMenuButton(
                  icon: Image.asset('assets/vectors/Vector.png'),
                  itemBuilder: (context) => _items),
            ),
          )
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
