import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScreen extends StatelessWidget {
  final DocumentSnapshot project;

  const ProjectDetailScreen({super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project['title']),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel للصور
            Container(
              height: 250,
              child: PageView.builder(
                itemCount: project['images'].length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: project['images'][index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // التصنيف والتصنيف
                  Row(
                    children: [
                      Chip(
                        label: Text(project['category']),
                        backgroundColor: Colors.blue[100],
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20),
                          SizedBox(width: 4),
                          Text(project['rating'].toString()),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // الوصف
                  Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    project['description'],
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),

                  // التقنيات المستخدمة
                  Text(
                    'التقنيات المستخدمة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['technologies'] as List<dynamic>).map((tech) {
                      return Chip(
                        label: Text(tech),
                        backgroundColor: Colors.green[100],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),

                  // التحديات
                  Text(
                    'التحديات والحلول',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    project['challenges'],
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(height: 16),

                  // مدة المشروع
                  _buildInfoItem('مدة المشروع', project['duration']),
                  _buildInfoItem('الحالة', project['status']),

                  // زر زيارة المشروع
                  if (project['projectUrl'] != null && project['projectUrl'].isNotEmpty)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton.icon(
                        onPressed: () => _launchUrl(project['projectUrl']),
                        icon: Icon(Icons.launch),
                        label: Text('زيارة المشروع'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}