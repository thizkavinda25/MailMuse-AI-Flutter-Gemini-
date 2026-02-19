import 'package:flutter/material.dart';
import 'package:mail_muse/constants/app_colors.dart';
import 'package:mail_muse/screens/history_screen.dart';
import 'package:mail_muse/screens/home_screen.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  int currentIndex = 0;
  final List<Widget> pages = [HomeScreen(), HistoryScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.bottomNavSelectColor,
        unselectedItemColor: AppColors.black,
        backgroundColor: AppColors.background,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'History',
            activeIcon: Icon(Icons.history),
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
