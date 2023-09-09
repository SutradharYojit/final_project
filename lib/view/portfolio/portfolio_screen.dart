import 'dart:developer';

import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:final_project_blog_app/services/firebase_services.dart';
import 'package:final_project_blog_app/view/blog_listing/blog_list_screen.dart';
import 'package:final_project_blog_app/view/blogger_profile/blogger_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../resources/resources.dart';
import '../../widget/shimmer_screen.dart';
import '../../widget/widget.dart';
import '../blogger_profile/blogger_data_provider.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> with SingleTickerProviderStateMixin {

  final ScrollController _scrollController = ScrollController();
  // user to give scroll animation
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final Animation<Offset> position = Tween<Offset>(
    begin: const Offset(10, 0),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.linear),
  );


  @override
  void initState() {
    super.initState();
    getUpdates(); // Fetch blogger Porfolio Data

    // Add scroll controller  listener to control over scroll animation
    _scrollController.addListener(() {
      log(_scrollController.offset .toString());
      if (_scrollController.offset > 500) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void getUpdates() async {
    await UserGlobalVariables.getUserData();
    ref.read(bloggerData.notifier).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(bloggerData);
    final loading = ref.read(bloggerData.notifier).loading;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: StringManager.portfolioAppBarTitle,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: IconButton(
              onPressed: () {
                context.push(RoutesName.bloggerProfileScreen,
                    extra: BloggerProfileData(portfolioScreen: true, data: data[0]));
                // Navigation to user profile screen to add and update the user profile
              },
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          // refresh Indicator to update the the current profiles Data
          onRefresh: ref.read(bloggerData.notifier).getUserData,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                loading
                    ? Expanded(
                  child: ShimmerLoading(
                    height: 80.h,
                  ),
                )
                    : Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigation to the see the profile
                              context.push(
                                RoutesName.bloggerProfileScreen,
                                extra: BloggerProfileData(
                                  portfolioScreen: false,
                                  data: data[index],
                                ),
                              );
                            },
                            child: Card(
                              elevation: 10,
                              color: ColorManager.whiteColor,
                              child: Padding(
                                padding: EdgeInsets.all(15.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(children: []),
                                    Text(
                                      data[index].userName!,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].email!,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            "${StringManager.skillTxt} ${data[index].skill!.length}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            "${StringManager.achievementTxt}:  ${data[index].achievement!.length}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            "${StringManager.projectTxt}:  ${data[index].project!.length}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      //scroll animation
                      Positioned(
                        bottom: 15.h,
                        right: 0.h,
                        child: UpAnimation(position: position, scrollController: _scrollController),
                      ),

                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
