import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_blog_app/services/firebase_services.dart';
import 'package:final_project_blog_app/view/blogger_profile/blogger_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/model.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_skill_buttomsheet.dart';
import 'blogger_skill_provider.dart';

// Enums we use to mange the add skill/Achievemt / project bottom sheet
enum Blogger { skills, achievement, project }

class BloggerProfileScreen extends ConsumerStatefulWidget {
  const BloggerProfileScreen({super.key, required this.profileData});

  final BloggerProfileData profileData;

  @override
  ConsumerState<BloggerProfileScreen> createState() => _BloggerProfileScreenState();
}

class _BloggerProfileScreenState extends ConsumerState<BloggerProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final bar = WarningBar();
  final FocusNode _focus = FocusNode();
  ValueNotifier<bool> nameFocus = ValueNotifier(false); // to manage the focus

  @override
  void initState() {
    super.initState();
    // call after widget is build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addData();
      if (widget.profileData.portfolioScreen) {
        _focus.addListener(_onFocusChange); // initialize the focus node listener
      }
    });
  }

  // function to check the status of the focus
  void _onFocusChange() {
    if (_focus.hasFocus) {
      nameFocus.value = true;
    } else {
      nameFocus.value = false;
    }
  }

  void addData() {
    //this case is invoke when user need to add or update the data
    if (widget.profileData.portfolioScreen) {
      final userdata = ref.read(bloggerData);
      ref.read(skillsList.notifier).addAllSkills(userdata[0].skill);
      ref.read(achievementsList.notifier).addAllAchievements(userdata[0].achievement);
      ref.read(projectList.notifier).addAllProject(userdata[0].project);
      _nameController.text = widget.profileData.data!.userName!;
      _emailController.text = widget.profileData.data!.email!;
    } else {
      // this case is invoked when you press the porfoilo profile from the porfolio screeb
      ref.read(skillsList.notifier).addAllSkills(widget.profileData.data!.skill);
      ref.read(achievementsList.notifier).addAllAchievements(widget.profileData.data!.achievement);
      ref.read(projectList.notifier).addAllProject(widget.profileData.data!.project);
      _nameController.text = widget.profileData.data!.userName!;
      _emailController.text = widget.profileData.data!.email!;
    }
  }

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
                          child: Consumer(
                            builder: (context, ref, child) {
                              return CircleAvatar(
                                radius: 17.r,
                                child: IconButton(
                                  onPressed: () async {},
                                  icon: Center(
                                    child: Icon(
                                      Icons.camera,
                                      size: 18.h,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.r),
                    child: PrimaryTextFilled(
                      focusNode: _focus,
                      readOnly: !widget.profileData.portfolioScreen,
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
                  // widget is invoked when user want to update his username
                  ValueListenableBuilder(
                    valueListenable: nameFocus,
                    builder: (context, value, child) {
                      return Visibility(
                        visible: value,
                        child: PrimaryButton(
                          title: StringManager.updateProfileBtn,
                          onTap: () {
                            // Function to update the the user name
                            FireBaseServices.updateUsername(context, _nameController.text.trim());
                            _focus.unfocus();
                          },
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: ColorManager.greyColor,
                    height: 30.h,
                  ),
                  AddSkills(
                    text: "Skills",
                    visible: widget.profileData.portfolioScreen,
                    onPressed: () {
                      // to add the skills
                      buildShowModalBottomSheet(
                        context,
                        widget: const AddSkillModalSheet(title: "Add Skill", blogger: Blogger.skills),
                      );
                    },
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
                            return Dismissible(
                              // to manage the dismissable state
                              direction: widget.profileData.portfolioScreen
                                  ? DismissDirection.horizontal
                                  : DismissDirection.none,
                              onDismissed: (direction) {
                                // function to remove skills
                                ref.read(skillsList.notifier).removeSkills(index, context);
                              },
                              key: UniqueKey(),
                              child: CustomAvatar(
                                title: "${index + 1}. ${skill[index]}",
                              ),
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
                    visible: widget.profileData.portfolioScreen,
                    onPressed: () {
                      //bottom sheet to add the Achievements
                      buildShowModalBottomSheet(
                        context,
                        widget: const AddSkillModalSheet(title: "Add Achievement", blogger: Blogger.achievement),
                      );
                    },
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
                            return Dismissible(
                              direction: widget.profileData.portfolioScreen
                                  ? DismissDirection.horizontal
                                  : DismissDirection.none,
                              onDismissed: (direction) {
                                // function to remove Achievements
                                ref.read(achievementsList.notifier).removeAchievements(index, context);
                              },
                              key: UniqueKey(),
                              child: CustomAvatar(
                                title: "${index + 1}. ${achievement[index]}",
                              ),
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
                    visible: widget.profileData.portfolioScreen,
                    onPressed: () {
                      //bottom sheet to add the project

                      buildShowModalBottomSheet(
                        context,
                        widget: const AddSkillModalSheet(title: "Add Projects", blogger: Blogger.project),
                      );
                    },
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
                            return Dismissible(
                              direction: widget.profileData.portfolioScreen
                                  ? DismissDirection.horizontal
                                  : DismissDirection.none,
                              onDismissed: (direction) {
                                // function to remove project
                                ref.read(projectList.notifier).removeProject(index, context);
                              },
                              key: UniqueKey(),
                              child: CustomAvatar(
                                title: "${index + 1}. ${project[index]}",
                              ),
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


// class model to manage the same screen from current user and from another user
class BloggerProfileData {
  final bool portfolioScreen;
  final UserDataModel? data;

  BloggerProfileData({
    this.data,
    required this.portfolioScreen,
  });
}
