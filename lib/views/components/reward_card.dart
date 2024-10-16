import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reward_app/data/model/user_reward_model.dart';
import 'package:reward_app/res/app_color.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final bool checkWalletCard;
  final Function cardFun;
  // final Color color = Utils.getRandomColor(); // we can use the provider for that to handle the state for the color of the reward
  final bool showQRCode;

  const RewardCard({
    super.key,
    required this.reward, // can be changed with viewmodel
    required this.checkWalletCard, //i am reusing this widget to display the cards in both the wallet from where the user can buy the cards and on the dashboard so that's why some texts needs to be changed !!
    // required this.color,
    required this.cardFun,
    this.showQRCode = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Color color = Utils.getRandomColor();

    // Dynamic padding and font sizes based on screen width
    double padding = screenWidth * 0.04;
    double fontSizeTitle = screenWidth * 0.07;
    double fontSizeSubtitle = screenWidth * 0.040;
    double fontSizeIdentifier = screenWidth * 0.04;
    double qrCodeSize = screenWidth * 0.28;
    return InkWell(
      onTap: () {
        cardFun();
      },
      child: Card(
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
                    reward.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/fall_back_img.jpg');
                    },
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
                            checkWalletCard ? 'Amount' : 'Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeSubtitle,
                            ),
                          ),
                          Text(
                            checkWalletCard
                                ? '\$${reward.points}'
                                : '${reward.points}',
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
                                fontSize:
                                    fontSizeTitle * 1.1, // Slightly larger
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
                        child: showQRCode
                            ? QrImageView(
                                data: reward.identifier,
                                version: QrVersions.auto,
                                size: qrCodeSize * 0.85,

                                // backgroundColor: color,
                              )
                            : Icon(
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
                            checkWalletCard
                                ? 'xxx-xxx-xxx-xxx'
                                : reward.identifier,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeIdentifier,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        //issue date
                        children: [
                          checkWalletCard
                              ? Container()
                              : Column(
                                  children: [
                                    Text(
                                      'Issue date',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeSubtitle,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMMMd()
                                          .format(reward.validity),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSizeIdentifier,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          //expiry date
                          Column(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
