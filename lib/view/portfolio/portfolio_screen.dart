import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:final_project_blog_app/services/firebase_services.dart';
import 'package:final_project_blog_app/view/blogger_profile/blogger_profile_screen.dart';
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
    getUpdates(); // Fetch blogger Porfolio Data
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
                context.push(RoutesName.bloggerProfileScreen, extra: BloggerProfileData(portfolioScreen: true,data: data[0]));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
