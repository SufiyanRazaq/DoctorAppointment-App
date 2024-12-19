import 'package:doctor_app/styles/colors.dart';
import 'package:doctor_app/tabs/HomeTab.dart';
import 'package:doctor_app/tabs/ScheduleTab.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(onPressedScheduleCard: goToSchedule),
      ScheduleTab(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(MyColors.primary),
          elevation: 0,
          toolbarHeight: 0, // Hides the app bar if not needed
        ),
        body: screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: Color(MyColors.primary),
          unselectedItemColor: Color(MyColors.bg02),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _selectedIndex == 0
                          ? Color(MyColors.primary)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Icon(Icons.local_hospital),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _selectedIndex == 1
                          ? Color(MyColors.primary)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Icon(Icons.calendar_today),
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
