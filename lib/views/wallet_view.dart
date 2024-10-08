import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/res/components/custom_app_bar.dart';
import 'package:reward_app/res/components/custom_drawer.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';

import '../res/components/reward_card.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // WalletViewModel walletViewModel = Provider.of<WalletViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body:
          Consumer<WalletViewModel>(builder: (context, walletViewModel, child) {
        // final rewards = walletViewModel.allRewards.data ?? [];
        final resource = walletViewModel.allRewards;
        if (resource.status == Status.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (resource.status == Status.ERROR) {
          return Center(child: Text('Error: ${resource.message}'));
        } else if (resource.data == null || resource.data!.isEmpty) {
          return Center(child: Text('No rewards available'));
        }
        final rewards = resource.data!;
        return ListView.builder(
          itemCount: rewards.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                RewardCard(reward: rewards[index]),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
