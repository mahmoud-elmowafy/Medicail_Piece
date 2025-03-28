import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_piece/features/user/home/presentation/home_screen.dart';

class UserDashBoardScreen extends ConsumerWidget {
  const UserDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current index from the bottomNavProvider

    // Define the screens corresponding to each tab
    final List<Widget> screens = [
      HomeScreen(),
      // ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: screens[0], // Display the selected screen
      ),
      // bottomNavigationBar: CustomBottomNavBar(), // Bottom navigation bar
    );
  }
}
