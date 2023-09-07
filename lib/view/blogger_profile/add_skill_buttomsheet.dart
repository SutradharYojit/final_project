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
                  maxLength: 15,
                  maxLines: 1,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final listSkill = ref.watch(skillsList);
                    return PrimaryButton(
                      onTap: () {
                        switch (widget.blogger) {
                          case Blogger.skills:
                            {
                              ref.read(skillsList.notifier).addSkills(
                                _addSkillCtrl.text.trim(),
                              );
                              final listSkill = ref.watch(skillsList);
                              FireBaseServices.addSkills(context, listSkill);
                              _addSkillCtrl.clear();
                              break;
                            }
                          case Blogger.achievement:
                            {
                              ref.read(achievementsList.notifier).addAchievements(
                                _addSkillCtrl.text.trim(),
                              );
                              final listAchievement = ref.watch(achievementsList);
                              FireBaseServices.addAchievements(context, listAchievement);
                              break;
                            }
                          case Blogger.project:
                            {
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
