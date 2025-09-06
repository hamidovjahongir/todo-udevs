// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:todo/core/utils/app_colors.dart';
// import 'package:todo/core/utils/app_textstyles.dart';
// import 'package:todo/core/widgets/w_text.dart';

// class CustomCalendar extends StatefulWidget {
//   const CustomCalendar({super.key});

//   @override
//   State<CustomCalendar> createState() => _CustomCalendarState();
// }

// class _CustomCalendarState extends State<CustomCalendar> {
//   DateTime selectedDate = DateTime.now();
//   DateTime currentMonth = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);

//     final lastDayOfMonth = DateTime(
//       currentMonth.year,
//       currentMonth.month + 1,
//       0,
//     );

//     int startWeekday = firstDayOfMonth.weekday % 7;
//     int totalDays = lastDayOfMonth.day;
//     List<Widget> dayWidgets = [];

//     for (int i = 0; i < startWeekday; i++) {
//       dayWidgets.add(const SizedBox.shrink());
//     }

//     for (int i = 1; i <= totalDays; i++) {
//       DateTime day = DateTime(currentMonth.year, currentMonth.month, i);

//       bool isSelected =
//           day.day == selectedDate.day &&
//           day.month == selectedDate.month &&
//           day.year == selectedDate.year;

//       dayWidgets.add(
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedDate = day;
//             });
//           },
//           child: Container(
//             margin: const EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected ? Colors.blue : Colors.transparent,
//             ),
//             child: Center(
//               child: Text(
//                 i.toString(),
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   DateFormat('EEEE').format(selectedDate),
//                   style: AppStyles.semiBoldWithSize(14),
//                 ),
//                 Text(
//                   DateFormat('d MMMM yyyy').format(selectedDate),
//                   style: AppStyles.regularWithSize(10),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   DateFormat('MMMM').format(currentMonth),
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.chevron_left),
//                       onPressed: () {
//                         setState(() {
//                           currentMonth = DateTime(
//                             currentMonth.year,
//                             currentMonth.month - 1,
//                             1,
//                           );
//                         });
//                       },
//                     ),

//                     IconButton(
//                       icon: const Icon(Icons.chevron_right),
//                       onPressed: () {
//                         setState(() {
//                           currentMonth = DateTime(
//                             currentMonth.year,
//                             currentMonth.month + 1,
//                             1,
//                           );
//                         });
//                       },
//                     ),
//                   ],
//                 ),
              
//               ],
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 WText(
//                   "Sun",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Mon",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Tue",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Wed",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Thu",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Fri",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//                 WText(
//                   "Sat",
//                   style: AppStyles.regular.copyWith(
//                     color: AppColors.grayNeutral,
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: GridView.count(crossAxisCount: 7, children: dayWidgets),
//             ),

//           ],
//         ),
//       ),
//     );
//   }
// }
