import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/services/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/routes_name.dart';
import '../widget/widget.dart';

class FireBaseServices {
  final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  final bar = WarningBar();
  final userPreferences = UserPreferences();

  Future signUP(BuildContext context,
      {required String textEmail, required String textPass, required String userName}) async {
    debugPrint("Button pressed");
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Loading(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          await db.collection(FBServiceManager.dbUser).doc().set({
            FBServiceManager.fbUserName: userName,
            FBServiceManager.fbEmail: textEmail,
            FBServiceManager.fbUid: auth.currentUser?.uid,
            FBServiceManager.fbSkill: [],
            FBServiceManager.fbAchievement: [],
            FBServiceManager.fbProject: [],
          });
          await userPreferences.saveLoginUserInfo(textEmail, textPass);
          // ignore: use_build_context_synchronously
          context.go(RoutesName.dashboardScreen);
        },
      );
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      final notExist = bar.snack(e.message.toString(), ColorManager.redColor);

      debugPrint("Failed to sign up${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(notExist);
      Navigator.pop(context);
    }
  }

  Future signIN(BuildContext context, {required String textEmail, required String textPass}) async {
    debugPrint("Button pressed");
    final notExist = bar.snack(FBServiceManager.serviceFirebaseNoAccount, ColorManager.redColor);

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: Loading());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          log("Seucces full logged in");
          await userPreferences.saveLoginUserInfo(textEmail, textPass).then(
            (value) {
              context.go(RoutesName.dashboardScreen);
            },
          );
          // ignore: use_build_context_synchronously
        },
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }

  Future contactUs(
    BuildContext context, {
    required String name,
    required String number,
    required String email,
    required String description,
  }) async {
    debugPrint("Button pressed");
    final success = bar.snack(FBServiceManager.serviceFbSentSuccess, ColorManager.greenColor);
    final failed = bar.snack(FBServiceManager.serviceFbSentFail, ColorManager.redColor);

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: Loading(),
          );
        });
    try {
      db.collection(FBServiceManager.dbContactUs).doc().set({
        FBServiceManager.fbUserName: name,
        FBServiceManager.fbUid: auth.currentUser?.uid,
        FBServiceManager.fbPhoneNumber: number,
        FBServiceManager.fbEmail: email,
        FBServiceManager.fbDescription: description,
      }).then((value) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(success);
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(failed);
    }
  }

  static Future addSkills(BuildContext context, List listSkill) async {
    try {
      await db
          .collection(FBServiceManager.dbUser)
          .doc(UserGlobalVariables.docId)
          .update({FBServiceManager.fbSkill: listSkill}).then((value) => log("update success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  static Future addAchievements(BuildContext context, List listAchievements) async {
    try {
      await db
          .collection(FBServiceManager.dbUser)
          .doc(UserGlobalVariables.docId)
          .update({FBServiceManager.fbAchievement: listAchievements}).then((value) => log("update success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  static Future addProject(BuildContext context, List listProject) async {
    try {
      await db
          .collection(FBServiceManager.dbUser)
          .doc(UserGlobalVariables.docId)
          .update({FBServiceManager.fbProject: listProject}).then((value) => log("update success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  static Future removeSkill(BuildContext context, String skillText) async {
    try {
      await db.collection(FBServiceManager.dbUser).doc(UserGlobalVariables.docId).update({
        FBServiceManager.fbSkill: FieldValue.arrayRemove([skillText])
      }).then((value) => log("delete skill success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  static Future removeAchievement(BuildContext context, String achievementText) async {
    try {
      await db.collection(FBServiceManager.dbUser).doc(UserGlobalVariables.docId).update({
        FBServiceManager.fbAchievement: FieldValue.arrayRemove([achievementText])
      }).then((value) => log("delete achievement success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  static Future removeProject(BuildContext context, String projectText) async {
    try {
      await db.collection(FBServiceManager.dbUser).doc(UserGlobalVariables.docId).update({
        FBServiceManager.fbProject: FieldValue.arrayRemove([projectText])
      }).then((value) => log("delete project success"));
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }
}

class UserGlobalVariables {
  static String? docId;
  static String? uid;
  static String? email;
  static String? username;

  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  static Future<void> getUserData() async {
    final data = await db
        .collection(FBServiceManager.dbUser)
        .where(FBServiceManager.fbUid, isEqualTo: auth.currentUser!.uid)
        .get();
    log("get Success");
    uid = auth.currentUser!.uid;
    docId = data.docs[0].id;
    email = data.docs[0][FBServiceManager.fbUid];
    username = data.docs[0][FBServiceManager.fbUserName];
  }
}
