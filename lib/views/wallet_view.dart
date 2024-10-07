import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';

import '../res/components/reward_card.dart';
import '../view_models/reward_view_model.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context);
    return Consumer<RewardViewModel>(
        builder: (context, rewardViewModel, child) {
      final rewards = walletViewModel.allRewards.data ?? [];
      return ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          Column(
            children: [
              RewardCard(
                reward: rewards[index],
                img: 'assets/images/coffee.jpg',
                color: Colors.red[900] ?? Colors.red,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        },
      );
    });
  }
}
