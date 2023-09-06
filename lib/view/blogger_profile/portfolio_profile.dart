import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'blogger_skill_provider.dart';

class PortfolioProfileScreen extends StatelessWidget {
  PortfolioProfileScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(
            title: "Profile",
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 48.r,
                          backgroundImage: const NetworkImage(
                            "https://c4.wallpaperflare.com/wallpaper/39/346/426/digital-art-men-city-futuristic-night-hd-wallpaper-preview.jpg",
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 17.r,
                            child: IconButton(
                              onPressed: () {},
                              icon: Center(
                                child: Icon(
                                  Icons.camera,
                                  size: 18.h,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _nameController,
                      hintText: "Your Name",
                      labelText: "Name",
                      prefixIcon: const Icon(
                        Icons.text_format_rounded,
                        color: ColorManager.gradientPurpleColor,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      controller: _emailController,
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        color: ColorManager.gradientPurpleColor,
                      ),
                      maxLines: 1,
                      readOnly: true,
                    ),
                  ),
                  Divider(
                    color: ColorManager.greyColor,
                    height: 30.h,
                  ),
                  AddSkills(
                    text: "Skills",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final skill = ref.watch(skillsList);
                        return ListView.builder(
                          itemCount: skill.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const CustomAvatar(
                              title: "arsadasdasdasdt",
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: ColorManager.greyColor,
                    height: 30.h,
                  ),
                  AddSkills(
                    text: "Achievement",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final achievement = ref.watch(achievementsList);

                        return ListView.builder(
                          itemCount: achievement.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const CustomAvatar(
                              title: "art",
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: ColorManager.greyColor,
                    height: 30.h,
                  ),
                  AddSkills(
                    text: "Projects",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Consumer(
                      builder: (context, ref, child) {
                        final project = ref.watch(projectList);
                        return ListView.builder(
                          itemCount: project.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const CustomAvatar(
                              title: "art",
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}