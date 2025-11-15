import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDataModel {
  final String name;
  final String image;
  final String bio;
  final String job;
  final num expYears;
  final num customers;

  const ProfileDataModel({
    required this.name,
    required this.image,
    required this.bio,
    required this.job,
    required this.expYears,
    required this.customers,
  });

  factory ProfileDataModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ProfileDataModel(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      bio: data['bio'] ?? '',
      job: data['job'] ?? '',
      expYears: data['expYears'] ?? '0',
      customers: data['customers'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'bio': bio,
      'job': job,
      'expYears': expYears,
      'customers': customers,
    };
  }
}