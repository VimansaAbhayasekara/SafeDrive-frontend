// import 'package:flutter/material.dart';
//
// class DateTimePickerWidget extends StatefulWidget {
//   final DateTime selectedDate;
//   final Function(DateTime) onDateTimeChanged;
//
//   DateTimePickerWidget({
//     required Key key,
//     required this.selectedDate,
//     required this.onDateTimeChanged,
//   }) : super(key: key);
//
//   @override
//   State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
// }
//
// class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: GestureDetector(
//         onTap: () {
//           _selectDate(context).then((_) {
//             _selectTime(context);
//           });
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 16),
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//           decoration: BoxDecoration(
//             color: Colors.blueGrey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 " Select date and time:\n  ${widget.selectedDate.toString()}",
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//               Icon(
//                 Icons.calendar_today,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: widget.selectedDate,
//       firstDate: DateTime(2015, 8),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != widget.selectedDate) {
//       widget.onDateTimeChanged(picked);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Selected date: $picked')),
//       );
//     }
//   }
//
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(widget.selectedDate),
//     );
//     if (picked != null) {
//       DateTime newDateTime = DateTime(
//         widget.selectedDate.year,
//         widget.selectedDate.month,
//         widget.selectedDate.day,
//         picked.hour,
//         picked.minute,
//       );
//       widget.onDateTimeChanged(newDateTime);
//       if (mounted) { // Check if the widget is still mounted
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Selected date and time: $newDateTime')),
//         );
//       }
//     }
//   }
//
//
//
// }


import 'package:flutter/material.dart';

class DateTimePickerWidget extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateTimeChanged;

  DateTimePickerWidget({
    required Key key,
    required this.selectedDate,
    required this.onDateTimeChanged,
  }) : super(key: key);

  @override
  State<DateTimePickerWidget> createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " Select date:\n  ${widget.selectedDate.toString().split(' ')[0]}",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.selectedDate) {
      widget.onDateTimeChanged(picked);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected date: $picked')),
      );
    }
  }
}
