import 'package:flutter/material.dart';
import 'package:reward_app/data/model/user_reward_model.dart';

import 'reward_card.dart';

class RewardListBuilder extends StatelessWidget {
  const RewardListBuilder({
    super.key,
    required this.rewards,
    required this.checkWalletCard,
    required this.onCardTap,
  });

  final List<Reward> rewards;
  final bool checkWalletCard;
  final Function(Reward) onCardTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        // return Column(
        //   children: [
        //     RewardCard(
        //       reward: rewards[index],
        //       checkWalletCard:
        //           checkWalletCard, //context se khud check kaar liya kaha pe h !
        //       cardFun: onCardTap,
        //     ),
        //     SizedBox(height: 20),
        //   ],
        // );
        return Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: RewardCard(
            reward: rewards[index],
            checkWalletCard:
                checkWalletCard, //context se khud check kaar liya kaha pe h !
            cardFun: () => onCardTap(rewards[index]),
          ),
        );
      },
    );
  }
}
