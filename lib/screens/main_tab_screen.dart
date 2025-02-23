import 'package:event_planner_app/config/colors.dart';
import 'package:event_planner_app/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:event_planner_app/widgets/drawer.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  // Default selected tab is Home
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // List to hold the screens for tab navigation
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    // Initialize screens for navigation
    _screens.addAll([
      // Home screen widget
      const HomeScreen(),
      // Profile screen widget
      ProfileScreen(
        // Function to open the drawer
        openDrawer: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
    ]);
  }

  // Method to update the selected tab when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // Custom drawer widget
      drawer: const CustomDrawer(),
      // Display selected screen
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Set the current index of the selected tab
        currentIndex: _selectedIndex,
        // Handle tab tap
        onTap: _onItemTapped,
        backgroundColor: AppColors.primaryTextColor,
        selectedItemColor: AppColors.secondaryTextColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        selectedLabelStyle: AppTextStyles.bottomNav,
        unselectedLabelStyle: AppTextStyles.bottomNav,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              width: 28,
              height: 28,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 28,
              height: 28,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
