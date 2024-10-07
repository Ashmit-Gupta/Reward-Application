import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:intl/intl.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final String img;
  final Color color;

  const RewardCard(
      {super.key,
      required this.reward,
      required this.img,
      required this.color});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic padding and font sizes based on screen width
    double padding = screenWidth * 0.04;
    double fontSizeTitle = screenWidth * 0.07;
    double fontSizeSubtitle = screenWidth * 0.040;
    double fontSizeIdentifier = screenWidth * 0.04;
    double qrCodeSize = screenWidth * 0.28;

    return Card(
      shadowColor: AppColors.blackColor,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: color,
      child: Stack(
        children: [
          // Background image with rounded corners, inside a Stack
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity, // Ensure it fills the card width
              height: screenHeight * 0.38, // Give it a fixed height
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content of the card (Text, QR code, etc.)
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Balance Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reward.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeSubtitle,
                          ),
                        ),
                        Text(
                          reward.points,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeSubtitle * 0.9,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Subtitle, description, and QR code Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reward.subtitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTitle * 1.1, // Slightly larger
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            reward.description,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // QR Code (dynamically sized)
                    Container(
                      width: qrCodeSize,
                      height: qrCodeSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.qr_code,
                        size: qrCodeSize * 0.85,
                        color: color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // Identifier and Expiry Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Identifier',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeSubtitle,
                          ),
                        ),
                        Text(
                          reward.identifier,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeIdentifier,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Expiry date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeSubtitle,
                          ),
                        ),
                        Text(
                          // DateFormat.yMMMd().format(reward.expiryDate),
                          DateFormat.yMMMd().format(reward.validity),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSizeIdentifier,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
