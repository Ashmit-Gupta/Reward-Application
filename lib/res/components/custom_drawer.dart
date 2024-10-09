import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/auth_view_model.dart';
import 'package:reward_app/view_models/sidebar_navigation_view_model.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, SideBarNavigationViewModel>(
      builder: (context, authViewModel, navigationViewModel, Widget? child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(authViewModel.user?.displayName ?? "Guest"),
                accountEmail:
                    Text(authViewModel.user?.email ?? "guest@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      authViewModel.user?.photoURL ??
                          'https://www.reelo.io/_next/image?url=%2Fassets%2Fimages%2Fnew-home%2Fmore-features%2Ffeedback.webp&w=1920&q=100',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                    ),
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
                  Utils.dialogBox(context, () {}, () async {
                    await authViewModel.logOut();
                    Navigator.pushReplacementNamed(context, RoutesName.login);
                  }, "LogOut", "Are you sure you want to Logout ?");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
