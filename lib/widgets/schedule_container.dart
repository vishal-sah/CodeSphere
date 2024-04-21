import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleContainer extends StatelessWidget {
  final DateTime astart;
  final DateTime aend;
  final DateTime start;
  final DateTime end;
  final DateTime mid;
  final DateTime result;
  const ScheduleContainer(
      {super.key,
      required this.astart,
      required this.aend,
      required this.start,
      required this.end,
      required this.mid,
      required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'Application Time',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${DateFormat('dd-MM-yyyy').format(astart)} - ${DateFormat('dd-MM-yyyy').format(aend)}',
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Text(
            'Submission Time',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${DateFormat('dd-MM-yyyy').format(start)} - ${DateFormat('dd-MM-yyyy').format(end)}',
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Text(
            'Mid Evaluation - Result',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${DateFormat('dd-MM-yyyy').format(mid)} - ${DateFormat('dd-MM-yyyy').format(result)}',
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
