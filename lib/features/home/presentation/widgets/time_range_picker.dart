import 'package:flutter/material.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/app_textstyles.dart';
import 'package:todo/core/widgets/w_text.dart';

class TimeRangePicker extends StatefulWidget {
  final void Function(String start, String end) onChanged;

  const TimeRangePicker({super.key, required this.onChanged});

  @override
  State<TimeRangePicker> createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  String? startTime;
  String? endTime;

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(
      2,
      '0',
    ); // 0 qo‘yiladi agar 1 raqamli bo‘lsa
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> _pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        startTime = _formatTime(picked); // ✅ faqat HH:mm
      });
      if (startTime != null && endTime != null) {
        widget.onChanged(startTime!, endTime!);
      }
    }
  }

  Future<void> _pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        endTime = _formatTime(picked);
      });
      if (startTime != null && endTime != null) {
        widget.onChanged(startTime!, endTime!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Event time",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _pickStartTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: WText(
                    startTime ?? "Start time",
                    style: AppStyles.regularWithSize(14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _pickEndTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: WText(
                    endTime ?? "End time",
                    style: AppStyles.regularWithSize(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
