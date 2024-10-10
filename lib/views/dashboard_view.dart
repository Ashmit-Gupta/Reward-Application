import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_app/data/response/status.dart';
import 'package:reward_app/res/components/custom_app_bar.dart';
import 'package:reward_app/res/components/custom_drawer.dart';
import 'package:reward_app/utils/utils.dart';
import 'package:reward_app/view_models/reward_view_model.dart';
import '../res/components/reward_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      appBar: const CustomAppBar(),
      body: Consumer<RewardViewModel>(
        builder: (context, rewardViewModel, child) {
          switch (rewardViewModel.rewards.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());

            case Status.ERROR:
              Utils.flushBarErrorMessage(
                  "error ${rewardViewModel.rewards.message}", context);
              return Center(
                  child: Text('Error: ${rewardViewModel.rewards.message}'));

            case Status.COMPLETED:
              final rewards = rewardViewModel.rewards.data ?? [];
              if (rewards.isEmpty) {
                return const Center(child: Text("No rewards available"));
              }
              return ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      RewardCard(
                        reward: rewards[index],
                        checkWalletCard: false,
                        color: Utils.getRandomColor(),
                        cardFun: () {
                          //todo add the qr page
                          print("qr code generate karva diyo !!");
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  );
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
