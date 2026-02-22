import 'package:flutter/material.dart';
import 'package:mail_muse/core/constants/app_colors.dart';
import 'package:mail_muse/screens/history/history_screen.dart';
import 'package:mail_muse/screens/home/home_screen.dart';

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
      
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.buttonGradient.colors.last,
          unselectedItemColor: AppColors.black,
          backgroundColor: AppColors.primary,
          currentIndex: currentIndex,

          selectedLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',

              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_toggle_off),
              label: 'History',
              activeIcon: Icon(Icons.history),
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
