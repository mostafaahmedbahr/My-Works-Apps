import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int projectCount = 0;
  int clientCount = 0;

  @override
  void initState() {
    super.initState();
    _getStats();
  }

  _getStats() async {
    var projectsSnapshot = await FirebaseFirestore.instance.collection('projects').get();
    var clientsSnapshot = await FirebaseFirestore.instance.collection('clients').get();

    setState(() {
      projectCount = projectsSnapshot.size;
      clientCount = clientsSnapshot.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('بروفايل 👨‍💻'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'اسمك هنا',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'مطور Flutter & Firebase',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('المشاريع', '$projectCount', Icons.work),
                  _buildStatItem('العملاء', '$clientCount', Icons.people),
                  _buildStatItem('السنين', '2+', Icons.star),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildNavButton(
                      'مشاريعي 🚀',
                      Icons.work,
                      Colors.blue,
                          () => Navigator.pushNamed(context, '/projects')
                  ),
                  SizedBox(height: 10),
                  _buildNavButton(
                      'خبراتي 💪',
                      Icons.code,
                      Colors.green,
                          () => Navigator.pushNamed(context, '/skills')
                  ),
                  SizedBox(height: 10),
                  _buildNavButton(
                      'تواصل معايا 📱',
                      Icons.contact_page,
                      Colors.orange,
                          () => Navigator.pushNamed(context, '/contact')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 30),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(String text, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}