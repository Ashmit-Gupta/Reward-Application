import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/view_models/home_view_model.dart';

import 'components/custom_app_bar.dart';
import 'components/custom_drawer.dart';
import 'components/reward_card.dart';
import 'components/rules_conditions.dart';

class QrGenerationView extends StatefulWidget {
  const QrGenerationView({super.key});

  @override
  State<QrGenerationView> createState() => _QrGenerationViewState();
}

class _QrGenerationViewState extends State<QrGenerationView> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = context.read<HomeViewModel>();
    final currReward = homeViewModel.selectedReward;
    if (currReward == null) {
      return Center(
        child: Text("Please select a Reward!!"),
      );
    }
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body: Column(
        children: [
          RewardCard(
            reward: currReward,
            checkWalletCard: false,
            cardFun: () {},
            showQRCode: true,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Rules and Conditions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          buildRulesAndConditions(),
        ],
      ),
    );
  }
}

//todo agar user ne same name ka coupon liya h toh ussme add ho jayegi value
//todo redem pe subtract
