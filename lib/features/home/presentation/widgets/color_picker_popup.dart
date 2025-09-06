import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_colors.dart';

class ColorPickerField extends StatefulWidget {
  final String initialColorKey;
  final ValueChanged<String> onChanged;

  const ColorPickerField({
    super.key,
    required this.initialColorKey,
    required this.onChanged,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late String selectedColorKey;

  final Map<String, Color> colors = {
    "red": AppColors.red,
    "pink": AppColors.pink,
    "blue": AppColors.blue,
    "orange": AppColors.orange,
  };

  @override
  void initState() {
    super.initState();
    selectedColorKey = widget.initialColorKey;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Priority color", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        PopupMenuButton<String>(
          initialValue: selectedColorKey,
          onSelected: (String key) {
            setState(() {
              selectedColorKey = key;
            });
            widget.onChanged(key);
          },
          itemBuilder: (BuildContext context) {
            return colors.keys.map((String key) {
              return PopupMenuItem<String>(
                value: key,
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colors[key],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(key),
                  ],
                ),
              );
            }).toList();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.gray100,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 20,
                  color:  colors[selectedColorKey] ,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.blue,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
