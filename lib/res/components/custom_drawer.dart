import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/auth_view_model.dart';
import 'package:reward_app/view_models/sidebar_navigation_view_model.dart';
import 'package:reward_app/view_models/user_view_model.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthViewModel, SideBarNavigationViewModel, UserViewModel>(
      builder: (context, authViewModel, navigationViewModel, userViewModel,
          Widget? child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userViewModel.name ?? "Guest"),
                accountEmail: Text(userViewModel.email ?? "guest@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userViewModel.imageUrl ?? '',
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
                title: Text("wallet"),
                selected: navigationViewModel.selectedIndex == 1,
                selectedTileColor: Colors.grey[350],
                onTap: () async {
                  navigationViewModel.setSelectedIndex(1);
                  Navigator.pushReplacementNamed(context, RoutesName.wallet);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  Utils.dialogBox(context, () async {
                    Navigator.pushReplacementNamed(context, RoutesName.login);
                    await authViewModel.logOut(context);
                  }, () {}, "LogOut", "Are you sure you want to Logout ?");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
