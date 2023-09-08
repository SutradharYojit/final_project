import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/services/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/routes_name.dart';
import '../widget/widget.dart';
// Class defines the All Firebase services Like Login, Signup and more.

class FireBaseServices {
  final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  static final dbUserDocument =
      FirebaseFirestore.instance.collection(FBServiceManager.dbUser).doc(UserGlobalVariables.docId);

  //used to define the for Scaffold messenger for to show the custom snack bar
  static final bar = WarningBar();
  final userPreferences = UserPreferences();
  static final update = bar.snack(FBServiceManager.serviceFbUpdateSuccess, ColorManager.greenColor);
  static final delete = bar.snack(FBServiceManager.serviceFbDeleteSuccess, ColorManager.redColor);

  // Define to Signup the user to the app or for create a new account
  Future signUP(BuildContext context,
      {required String textEmail, required String textPass, required String userName}) async {
    debugPrint("Button pressed");

    // Show Loading screen while function is called
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Loading(),
        );
      },
    );
    try {
      // set the user credentials to the firebase Authentication Services
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          // save the user data to the Firebase clod store Services
          await db.collection(FBServiceManager.dbUser).doc().set({
            FBServiceManager.fbUserName: userName,
            FBServiceManager.fbEmail: textEmail,
            FBServiceManager.fbUid: auth.currentUser?.uid,
            FBServiceManager.fbSkill: [],
            FBServiceManager.fbAchievement: [],
            FBServiceManager.fbProject: [],
          });
          // save the user credentials locally so user don't need to login in every time
          await userPreferences.saveLoginUserInfo(textEmail, textPass);
          // ignore: use_build_context_synchronously
          context.go(RoutesName.dashboardScreen); // move to dashboard screen
        },
      );
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      final notExist = bar.snack(e.message.toString(), ColorManager.redColor);

      debugPrint("Failed to sign up${e.message}");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(notExist);
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // remove the loding screen and give the warning to the user when exception is catch
    }
  }

// Signin Function to logged in app
  Future signIN(BuildContext context, {required String textEmail, required String textPass}) async {
    debugPrint("Button pressed");
    final notExist = bar.snack(FBServiceManager.serviceFirebaseNoAccount, ColorManager.redColor);
    // Show Loading screen while function is called

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: Loading());
        });
    try {
      // check if user is credentials are correct or not
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: textEmail, password: textPass).then(
        (value) async {
          log("Success full logged in");
          // save the user credentials locally so user don't need to login in every time

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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(notExist);
    }
  }

// Function to store the data from user to contact Us
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
    // Lading Screen
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: Loading(),
        );
      },
    );
    try {
      // store the contact us information from user with his uid
      db.collection(FBServiceManager.dbContactUs).doc().set({
        FBServiceManager.fbUserName: name,
        FBServiceManager.fbUid: auth.currentUser?.uid, //current user uid
        FBServiceManager.fbPhoneNumber: number,
        FBServiceManager.fbEmail: email,
        FBServiceManager.fbDescription: description,
      }).then((value) {
        Navigator.pop(context); // remove the loading screen

        ScaffoldMessenger.of(context).showSnackBar(success);
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Navigator.pop(context); // remove the loading screen
      ScaffoldMessenger.of(context).showSnackBar(failed);
    }
  }

  // Function to Update the user as User_name
  static Future updateUsername(BuildContext context, String userName) async {
    try {
      await dbUserDocument.update({FBServiceManager.fbUserName: userName}).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(update);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to add the List of the Skills in database
  static Future addSkills(BuildContext context, List listSkill) async {
    try {
      await dbUserDocument.update({FBServiceManager.fbSkill: listSkill}).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(update);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to add the List of the achievement in database
  static Future addAchievements(BuildContext context, List listAchievements) async {
    try {
      await dbUserDocument.update({FBServiceManager.fbAchievement: listAchievements}).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(update);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to add the List of the project in database
  static Future addProject(BuildContext context, List listProject) async {
    try {
      await dbUserDocument.update({FBServiceManager.fbProject: listProject}).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(update);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to remove the skill from database
  static Future removeSkill(BuildContext context, String skillText) async {
    try {
      await dbUserDocument.update({
        FBServiceManager.fbSkill: FieldValue.arrayRemove([skillText])
      }).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(delete);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to remove the achievement from databas
  static Future removeAchievement(BuildContext context, String achievementText) async {
    try {
      await dbUserDocument.update({
        FBServiceManager.fbAchievement: FieldValue.arrayRemove([achievementText])
      }).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(delete);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }

  // Function to remove the project from database

  static Future removeProject(BuildContext context, String projectText) async {
    try {
      await dbUserDocument.update({
        FBServiceManager.fbProject: FieldValue.arrayRemove([projectText])
      }).then((value) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(delete);
      });
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
    }
  }
}
// This mainly store the Firebase user uid , user collection docId and user_name where you can access this from ant where in app,
class UserGlobalVariables {
  static String? docId;
  static String? uid;
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
    username = data.docs[0][FBServiceManager.fbUserName];
  }
}
