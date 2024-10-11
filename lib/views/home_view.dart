import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/res/components/custom_app_bar.dart';
import 'package:reward_app/res/components/custom_drawer.dart';
import 'package:reward_app/utils/routes/routes_name.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/home_view_model.dart';
import 'package:reward_app/res/components/reward_list_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: const CustomAppBar(),
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          switch (homeViewModel.rewards.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());

            case Status.ERROR:
              Utils.flushBarErrorMessage(
                  "error ${homeViewModel.rewards.message}", context);
              return Center(
                  child: Text('Error: ${homeViewModel.rewards.message}'));

            case Status.COMPLETED:
              final rewards = homeViewModel.rewards.data ?? [];
              if (rewards.isEmpty) {
                return const Center(child: Text("No rewards available"));
              }
              return RewardListBuilder(
                rewards: rewards,
                checkWalletCard: false,
                onCardTap: (rewards) {
                  homeViewModel.selectReward(rewards);
                  Navigator.pushNamed(context, RoutesName.rewardQR);
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  // });
                },
              );
            default:
              return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }
}
