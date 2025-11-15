import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خبراتي 💪'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('skills').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var skill = snapshot.data!.docs[index];
              return _buildSkillItem(skill);
            },
          );
        },
      ),
    );
  }

  Widget _buildSkillItem(DocumentSnapshot skill) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getSkillIcon(skill['category']),
                    color: _getSkillColor(skill['category'])),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    skill['name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${skill['level']}%',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: skill['level'] / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(_getSkillColor(skill['category'])),
            ),
            SizedBox(height: 4),
            Text(
              skill['description'],
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSkillIcon(String category) {
    switch (category) {
      case 'programming':
        return Icons.code;
      case 'design':
        return Icons.design_services;
      case 'tools':
        return Icons.build;
      default:
        return Icons.star;
    }
  }

  Color _getSkillColor(String category) {
    switch (category) {
      case 'programming':
        return Colors.blue;
      case 'design':
        return Colors.purple;
      case 'tools':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}