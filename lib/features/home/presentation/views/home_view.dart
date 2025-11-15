import 'package:flutter/material.dart';
import 'package:my_works_apps/core/utils/app_colors/app_colors.dart';
import 'package:my_works_apps/features/home/presentation/views/widgets/header_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          HeaderSection(),
        ],
      ),
    );
  }
}
