import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CheckMenuItem {
  String label;
  bool isSelected;
  CheckMenuItem({
    required this.label,
    this.isSelected = false,
  });
}

class CheckMenu extends StatefulWidget {
  final Color textColor, backgroundColor;
  final Function(List<String>) onSelectionChanged;
  final List<String> initialSelections;

  const CheckMenu({
    super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.onSelectionChanged,
    required this.initialSelections,
  });

  @override
  _CheckMenuState createState() => _CheckMenuState();
}

class _CheckMenuState extends State<CheckMenu> {
  late List<CheckMenuItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      CheckMenuItem(label: 'Hypertension'),
      CheckMenuItem(label: 'Hypotension'),
      CheckMenuItem(label: 'Diabetes'),
      CheckMenuItem(label: 'Heart Diseases'),
    ];
    for (var item in _items) {
      if (widget.initialSelections.contains(item.label)) {
        item.isSelected = true;
      }
    }
  }

  void _updateSelection() {
    final selectedItems = _items
        .where((item) => item.isSelected)
        .map((item) => item.label)
        .toList();
    widget.onSelectionChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diseases',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              color: kTextColor,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          // Added SizedBox to properly constrain the Container
          width: 380,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var item in _items)
                  Row(
                    children: [
                      Checkbox(
                        value: item.isSelected,
                        onChanged: (value) {
                          setState(() {
                            item.isSelected = value ?? false;
                            _updateSelection();
                          });
                        },
                      ),
                      Text(item.label),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
