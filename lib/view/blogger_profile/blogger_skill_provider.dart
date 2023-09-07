import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firebase_services.dart';

final skillsList = StateNotifierProvider<BloggerSkills, List>((ref) => BloggerSkills());

class BloggerSkills extends StateNotifier<List> {
  BloggerSkills() : super([]);

  void addSkills(String skills) {
    state.insert(0, skills);
    state = [...state];
  }

  void removeSkills(int index, BuildContext context) async {
    await FireBaseServices.removeSkill(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  void addAllSkills(skills) {
    state.clear();
    state = [...state];
    state.addAll(skills);
    state = [...state];
  }
}

final achievementsList = StateNotifierProvider<BloggerAchievements, List>((ref) => BloggerAchievements());

class BloggerAchievements extends StateNotifier<List> {
  BloggerAchievements() : super([]);

  void addAchievements(String achievements) {
    state.insert(0, achievements);
    state = [...state];
  }

  void removeAchievements(int index,BuildContext context) async {
    await FireBaseServices.removeAchievement(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  void addAllAchievements(achievements) {
    state.clear();
    state.addAll(achievements);
    state = [...state];
  }
}

final projectList = StateNotifierProvider<BloggerProject, List>((ref) => BloggerProject());

class BloggerProject extends StateNotifier<List> {
  BloggerProject() : super([]);

  void addProject(String project) {
    state.insert(0, project);
    state = [...state];
  }

  void removeProject(int index ,BuildContext context)async {
    await FireBaseServices.removeProject(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  void addAllProject(project) {
    state.clear();
    state.addAll(project);
    state = [...state];
  }
}
