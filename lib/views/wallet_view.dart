import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/view_models/wallet_view_model.dart';
import '../utils/routes/routes_name.dart';
import 'components/custom_app_bar.dart';
import 'components/custom_drawer.dart';
import 'components/reward_list_builder.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SideBar(),
      body:
          Consumer<WalletViewModel>(builder: (context, walletViewModel, child) {
        final resource = walletViewModel.allRewards;
        if (resource.status == Status.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (resource.status == Status.ERROR) {
          return Center(child: Text('Error: ${resource.message}'));
        } else if (resource.data == null || resource.data!.isEmpty) {
          return Center(child: Text('No rewards available'));
        }
        final rewards = resource.data!;
        return RewardListBuilder(
          rewards: rewards,
          checkWalletCard: true,
          onCardTap: (rewards) {
            walletViewModel.selectReward(rewards);
            Navigator.pushNamed(context, RoutesName.payment);
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            // });
          },
        );
      }),
    );
  }
}
