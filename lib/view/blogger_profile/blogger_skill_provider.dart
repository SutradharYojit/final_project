import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firebase_services.dart';

// this are the provider to manage the sate of the app

final skillsList = StateNotifierProvider<BloggerSkills, List>((ref) => BloggerSkills()); // skill list provider

class BloggerSkills extends StateNotifier<List> {
  BloggerSkills() : super([]);

  // function to insert the skills
  void addSkills(String skills) {
    state.insert(0, skills);
    state = [...state];
  }

  // function to remove the skills from the list and firebase
  void removeSkills(int index, BuildContext context) async {
    await FireBaseServices.removeSkill(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  // function to add all the skills to the list
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

  // function to insert the Achievements
  void addAchievements(String achievements) {
    state.insert(0, achievements);
    state = [...state];
  }

  // function to remove the Achievements from the list and firebase
  void removeAchievements(int index, BuildContext context) async {
    await FireBaseServices.removeAchievement(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  // function to add all the Achievements to the list

  void addAllAchievements(achievements) {
    state.clear();
    state.addAll(achievements);
    state = [...state];
  }
}

final projectList = StateNotifierProvider<BloggerProject, List>((ref) => BloggerProject());

class BloggerProject extends StateNotifier<List> {
  BloggerProject() : super([]);

  // function to insert the Project

  void addProject(String project) {
    state.insert(0, project);
    state = [...state];
  }

  // function to remove the  Project from the list and firebase

  void removeProject(int index, BuildContext context) async {
    await FireBaseServices.removeProject(context, state[index]);
    state.removeAt(index);
    state = [...state];
  }

  // function to add all the Project to the list

  void addAllProject(project) {
    state.clear();
    state.addAll(project);
    state = [...state];
  }
}
