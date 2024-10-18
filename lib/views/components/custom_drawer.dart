import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/model/user_model.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/auth_view_model.dart';
import 'package:reward_app/view_models/logout_view_model.dart';
import 'package:reward_app/view_models/sidebar_navigation_view_model.dart';
import 'package:reward_app/view_models/user_view_model.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<LogOutViewModel, SideBarNavigationViewModel,
        UserViewModel>(
      builder: (context, logOutViewModel, navigationViewModel, userViewModel,
          Widget? child) {
        // Use FutureBuilder to handle the asynchronous data fetching
        return FutureBuilder<UserData>(
          future: userViewModel.getUser(), // Asynchronous call
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              UserData userData = snapshot.data!; // Use the fetched data

              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(userData.displayName),
                      accountEmail: Text(userData.email),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: userData.photoURL ?? '',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/user_logo.png'),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.dashboard_customize_outlined),
                      title: Text("DashBoard"),
                      selected: navigationViewModel.selectedIndex == 0,
                      selectedTileColor: Colors.grey[350],
                      onTap: () {
                        navigationViewModel.setSelectedIndex(0);
                        Navigator.pushNamed(context, RoutesName.home);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.wallet),
                      title: Text("Wallet"),
                      selected: navigationViewModel.selectedIndex == 1,
                      selectedTileColor: Colors.grey[350],
                      onTap: () async {
                        navigationViewModel.setSelectedIndex(1);
                        Navigator.pushReplacementNamed(
                            context, RoutesName.wallet);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Logout"),
                      onTap: () async {
                        Utils.dialogBox(context, () async {
                          await logOutViewModel.logout();
                          Navigator.pushNamedAndRemoveUntil(
                              context, RoutesName.login, (route) => false);
                        }, () {}, "LogOut", "Are you sure you want to Logout?");
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text('No user data available');
            }
          },
        );
      },
    );
  }
}
