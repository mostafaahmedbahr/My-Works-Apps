import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_works_apps/core/utils/app_colors/app_colors.dart';
import 'package:my_works_apps/core/utils/app_images/png_images.dart';
import 'package:my_works_apps/core/utils/helpers/spacing.dart';
import 'package:my_works_apps/features/home/presentation/view_model/home_cubit.dart';
import 'package:my_works_apps/features/home/presentation/view_model/home_states.dart';
import 'header_section_shimmer.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<HomeCubit , HomeStates>(
      buildWhen: (previous, current){
        return current is GetProfileDataSuccessState || current is GetProfileDataErrorState || current is GetProfileDataLoadingState;
      },
      builder: (context,state){
        var homeCubit = context.read<HomeCubit>();
        return
          state is GetProfileDataLoadingState ? HeaderSectionShimmer():
              state is GetProfileDataErrorState ? Text(state.message):
          Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.blue , AppColors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.white.withValues(alpha: 0.3), Colors.white.withValues(alpha: 0.1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(50),
                        child: Image.asset(AppImages.profileImage,fit: BoxFit.contain,width: double.infinity,)),
                  ),
                ],
              ),
              verticalSpace(20),
              Text(
                homeCubit.profileDataModel?.name??"No Name",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              verticalSpace(8),
              Text(
                homeCubit.profileDataModel?.job??"No Job",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              verticalSpace(8),
              Text(
                textAlign: TextAlign.center,
                homeCubit.profileDataModel?.bio??"No Bio",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
