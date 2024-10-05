import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.menu),
      // ),
      title: Row(
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.orangeAccent,
          ),
          SizedBox(
            width: 10,
          ),
          const Text(
            "Reward Loyalty",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold // Adjust font size as per the image
                ),
          )
        ],
      ),
      actions: [
        IntrinsicHeight(
          child: Row(
            children: [
              CircleAvatar(
                  radius: 15,
                  child: CountryFlag.fromCountryCode(
                    'IN',
                    shape: Circle(),
                    height: 10,
                    width: 30,
                  )
                  // backgroundImage: CountryFlag.fromCountryCode('IN'),
                  ),
              SizedBox(
                width: 20,
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                width: 10,
                indent: 10,
                endIndent: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.sunny),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
