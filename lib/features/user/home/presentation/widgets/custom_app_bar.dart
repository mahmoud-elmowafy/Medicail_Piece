import 'package:flutter/material.dart';
import 'package:medical_piece/core/constants/app_colors.dart';
import 'package:medical_piece/core/utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBarColor, // Background color of the app bar
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(5), // Circular bottom border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 4, // Shadow blur radius
            offset: const Offset(0, 2), // Shadow offset
          ),
        ],
      ),
      child: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title container with home icon
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white, // Title background color
                  borderRadius: BorderRadius.circular(20), // Circular title border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Shadow color for title
                      blurRadius: 2, // Shadow blur radius
                      offset: const Offset(0, 2), // Shadow offset for title
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home,
                        size: Dimensions.iconSizeDefault,
                        color: AppColors.primaryColor), // Home icon
                    const SizedBox(width: 8), // Spacing between icon and title
                    Center(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // GestureDetector(
                    //   onTap: ()
                    //   {
                    //     Navigator.push(
                    //         context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
                    //   },
                    //   child: const Icon(Icons.notifications,
                    //       size: Dimensions.iconSizeDefault,
                    //       color: AppColors.primaryColor),
                    // ), // Dropdown icon
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Notification icon outside of the title container
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background color of the circular notification
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color for notification icon
                    blurRadius: 4, // Shadow blur radius
                    offset: const Offset(0, 2), // Shadow offset for notification icon
                  ),
                ],
              ),
              // child: IconButton(
              //   icon: const Icon(
              //     Icons.logout,
              //     size: Dimensions.iconSizeDefault,
              //     color: AppColors.errorColor,
              //   ), // Notification icon
              //   onPressed: () {
              //     // Show the confirmation dialog
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: Text('Log Out'),
              //           content: Text('Are you sure you want to log out?'),
              //           actions: <Widget>[
              //             // Cancel button
              //             TextButton(
              //               onPressed: () {
              //                 Navigator.of(context).pop(); // Close the dialog
              //               },
              //               child: Text('Cancel',style: TextStyle(color: Colors.green),),
              //             ),
              //             // Confirm button
              //             TextButton(
              //               onPressed: () {
              //                 // Perform the logout
              //                 FirebaseAuthService().signOut(context);
              //                 // Navigator.of(context).pop(); // Close the dialog
              //               },
              //               child: Text('Log Out',style: TextStyle(color: Colors.red)),
              //             ),
              //           ],
              //         );
              //       },
              //     );
              //   },
              // )
              // ,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove AppBar elevation
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 15); // Include circular border height
}
