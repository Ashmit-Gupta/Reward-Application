import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/view_models/auth_view_model.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, Widget? child) {
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
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  await authViewModel.logOut();
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
