import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  final String title;
  final String points;
  final String description;
  final String identifier;
  final String imageUrl;
  final String subtitle;
  final DateTime validity;
  final bool available;
  // final Color color;

  Reward({
    required this.title,
    required this.points,
    required this.identifier,
    required this.description,
    required this.subtitle,
    required this.imageUrl,
    required this.available,
    required this.validity,
  });

  // Convert Firebase document snapshot to Reward model
  factory Reward.fromMap(Map<String, dynamic> data) {
    return Reward(
      title: data['title'] ?? '',
      points: data['points'] ?? '0',
      identifier: data['identifier'] ?? 'xxx-xxx-xxx-xxx',
      description: data['description'] ?? '',
      subtitle: data['subtitle'] ?? '',
      validity: (data['validity'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'] ?? 'assets/images/fall_back_img.jpg',
      available: data['available'] ?? false,
    );
  }
}
