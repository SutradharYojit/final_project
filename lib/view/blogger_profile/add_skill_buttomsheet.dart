import 'package:final_project_blog_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/services.dart';
import '../../widget/widget.dart';
import '../view.dart';
import 'blogger_skill_provider.dart';

class AddSkillModalSheet extends StatefulWidget {
  const AddSkillModalSheet({
    super.key,
    required this.title,
    required this.blogger,
  });

  final String title;
  final Blogger blogger;

  @override
  State<AddSkillModalSheet> createState() => _AddSkillModalSheetState();
}

class _AddSkillModalSheetState extends State<AddSkillModalSheet> {
  final TextEditingController _addSkillCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                PrimaryTextFilled(
                  controller: _addSkillCtrl,
                  prefixIcon: Icon(
                    Icons.star_border_rounded,
                    size: 30.sp,
                    color: ColorManager.gradientPurpleColor,
                  ),
                  maxLength: 20,
                  maxLines: 1,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return PrimaryButton(
                      onTap: () {
                        // switch case to manage the bottom sheet
                        switch (widget.blogger) {
                          case Blogger.skills:
                            {
                              // function to add the skills to the firebase
                              ref.read(skillsList.notifier).addSkills(
                                _addSkillCtrl.text.trim(),
                              );
                              final listSkill = ref.watch(skillsList);
                              FireBaseServices.addSkills(context, listSkill);// add the skills to the firebase
                              _addSkillCtrl.clear();
                              break;
                            }
                          case Blogger.achievement:
                            {
                              // function to add the achievement to the firebase
                              ref.read(achievementsList.notifier).addAchievements(
                                _addSkillCtrl.text.trim(),
                              );
                              final listAchievement = ref.watch(achievementsList);
                              FireBaseServices.addAchievements(context, listAchievement);
                              break;
                            }
                          case Blogger.project:
                            {
                              // function to add the project to the firebase

                              ref.read(projectList.notifier).addProject(
                                _addSkillCtrl.text.trim(),
                              );
                              final listProject = ref.watch(projectList);
                              FireBaseServices.addProject(context, listProject);
                              break;
                            }
                          default:
                            {
                              //
                              break;
                            }
                        }
                        _addSkillCtrl.clear();
                        Navigator.pop(context);
                      },
                      title: "Add",
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
