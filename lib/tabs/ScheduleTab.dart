import 'package:doctor_app/constants.dart';
import 'package:doctor_app/styles/colors.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

enum FilterStatus { Upcoming, Complete, Cancel }

List<Map> schedules = [
  {
    'img': 'assets/doc1.png',
    'doctorName': 'Dr. Henry',
    'doctorTitle': 'Dental Specialist',
    'reservedDate': 'Monday, Aug 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/doc3.png',
    'doctorName': 'Dr. Peter',
    'doctorTitle': 'Skin Specialist',
    'reservedDate': 'Monday, Sep 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming
  },
  {
    'img': 'assets/doc2.png',
    'doctorName': 'Dr. Jon Doe',
    'doctorTitle': 'General Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Complete
  },
  {
    'img': 'assets/doc5.png',
    'doctorName': 'Dr. Sarah Wilson',
    'doctorTitle': 'Pediatric Specialist',
    'reservedDate': 'Monday, Jul 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Cancel
  },
];

class _ScheduleTabState extends State<ScheduleTab> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((schedule) {
      return schedule['status'] == status;
    }).toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Schedule',
              textAlign: TextAlign.left,
              style: kTitleStyle.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 20),
            _buildFilterBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSchedules.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildScheduleCard(filteredSchedules[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Color(MyColors.bg),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: FilterStatus.values.map((filterStatus) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      status = filterStatus;
                      _alignment = _getAlignment(filterStatus);
                    });
                  },
                  child: Center(
                    child: Text(
                      filterStatus.name,
                      style: kFilterStyle,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment: _alignment,
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              color: Color(MyColors.primary),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                status.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Alignment _getAlignment(FilterStatus filterStatus) {
    switch (filterStatus) {
      case FilterStatus.Upcoming:
        return Alignment.centerLeft;
      case FilterStatus.Complete:
        return Alignment.center;
      case FilterStatus.Cancel:
        return Alignment.centerRight;
    }
  }

  Widget _buildScheduleCard(Map schedule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(schedule['img']),
                  radius: 25,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule['doctorName'],
                      style: TextStyle(
                        color: Color(MyColors.header01),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      schedule['doctorTitle'],
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            DateTimeCard(
              reservedDate: schedule['reservedDate'],
              reservedTime: schedule['reservedTime'],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {},
                    child: const Text('Reschedule'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final String reservedDate;
  final String reservedTime;

  const DateTimeCard({
    Key? key,
    required this.reservedDate,
    required this.reservedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 18,
                color: Color(MyColors.primary),
              ),
              const SizedBox(width: 8),
              Text(
                reservedDate,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(MyColors.primary),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: Color(MyColors.primary),
              ),
              const SizedBox(width: 8),
              Text(
                reservedTime,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(MyColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
