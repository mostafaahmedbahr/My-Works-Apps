import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تواصل معايا 📱'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // نموذج التواصل
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'أرسل لي رسالة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'اسمك',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'الرسالة',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitMessage,
                        icon: Icon(Icons.send),
                        label: Text('إرسال الرسالة'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // وسائل التواصل الاجتماعي
            Text(
              'وسائل التواصل',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('social_links').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: snapshot.data!.docs.map((doc) {
                    return ActionChip(
                      avatar: Icon(_getSocialIcon(doc['platform'])),
                      label: Text(doc['platform']),
                      onPressed: () => _launchUrl(doc['url']),
                      backgroundColor: _getSocialColor(doc['platform']),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _submitMessage() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance.collection('messages').add({
      'name': _nameController.text,
      'email': _emailController.text,
      'message': _messageController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });

    // Reset form
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();

    // Show success message
    // يمكنك إضافة SnackBar هنا
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'linkedin':
        return Icons.business;
      case 'github':
        return Icons.code;
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt;
      default:
        return Icons.link;
    }
  }

  Color _getSocialColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'linkedin':
        return Colors.blue[800]!;
      case 'github':
        return Colors.black87;
      case 'twitter':
        return Colors.lightBlue;
      case 'facebook':
        return Colors.blue[600]!;
      case 'instagram':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}