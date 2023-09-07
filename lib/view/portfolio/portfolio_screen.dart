import 'dart:developer';

import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:final_project_blog_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';
import '../blogger_profile/blogger_data_provider.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {



  @override
  void initState() {
    super.initState();
    UserGlobalVariables.getUserData();
    ref.read(bloggerData.notifier).getUserData();
  }


  @override
  Widget build(BuildContext context) {
    final data = ref.watch(bloggerData);
    final loading = ref.read(bloggerData.notifier).loading;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Portfolio",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: IconButton(
              onPressed: () {
                context.push(RoutesName.bloggerProfileScreen);
              },
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ref.read(bloggerData.notifier).getUserData,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: loading
                ? const Center(
                    child: SpinKitFoldingCube(
                      color: Colors.black,
                      size: 45,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
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
                                            "Skills: ${data[index].skill!.length}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            "Achivements:  ${data[index].achievement!.length}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                          Text(
                                            "Project:  ${data[index].project!.length}",
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
                            );
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
