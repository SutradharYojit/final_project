import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../services/services.dart';
import 'blog_data_provider.dart';

enum EditAuth {
  edit,
  delete,
}

class BlogListScreen extends ConsumerStatefulWidget {
  const BlogListScreen({super.key});

  @override
  ConsumerState<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends ConsumerState<BlogListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  EditAuth? selectedItem;

  Future<void> getData() async {
    await ref.read(blogDataList.notifier).blogData();
  }

  @override
  Widget build(BuildContext context) {
    final blogList = ref.watch(blogDataList);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 1,
        title: Padding(
          padding: EdgeInsets.only(top: 8.0.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                ImageAssets.projectLogo,
                height: 33.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: "DancingScript",
                      ),
                    ),
                    Text(
                      UserGlobalVariables.username!,
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              UserPreferences().logOutsetData(context);
            },
            icon: Icon(
              Icons.logout_rounded,
              size: 25.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0.r),
            child: IconButton(
              onPressed: () {
                context.push(
                  RoutesName.addBlogScreen,
                  extra: BlogPreferences(blogChoice: false,),
                );
              },
              icon: Icon(
                Icons.add_task_rounded,
                size: 25.h,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: RefreshIndicator(
            onRefresh: ref.read(blogDataList.notifier).blogData,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                blogList.isEmpty
                    ? const Center(
                        child: Text("No Blog Data"),
                      )
                    : Expanded(
                        child: ListView.builder(
                          // reverse: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 15.w),
                          itemCount: blogList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.push(RoutesName.blogDetailsScreen, extra: blogList[index]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 15),
                                                child: Text(
                                                  blogList[index].attributes!.publishedAt!.substring(0, 10),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorManager.greyColor,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    UserGlobalVariables.uid == blogList[index].attributes!.authorId!,
                                                child: PopupMenuButton(
                                                  initialValue: selectedItem,
                                                  onSelected: (EditAuth item) {
                                                    if (item == EditAuth.edit) {
                                                      context.push(
                                                        RoutesName.addBlogScreen,
                                                        extra: BlogPreferences(
                                                          blogChoice: true,
                                                          title: blogList[index].attributes!.title!,
                                                          description: blogList[index].attributes!.description!,
                                                          index: blogList[index].id!
                                                        ),
                                                      );
                                                    } else {
                                                      ref
                                                          .read(blogDataList.notifier)
                                                          .blogDelete(blogList[index].id!, index);
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<EditAuth>>[
                                                    const PopupMenuItem(
                                                      value: EditAuth.edit,
                                                      child: PopMenuBtn(
                                                        title: "Edit",
                                                        icon: Icons.edit,
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: EditAuth.delete,
                                                      child: PopMenuBtn(
                                                        title: "Delete",
                                                        icon: Icons.delete_outline_rounded,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            // margin: EdgeInsets.symmetric(vertical: 10.r),
                                            constraints: BoxConstraints(minHeight: 150.h),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  blogList[index].attributes!.imageUrl!,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 7.w),
                                            child: Text(
                                              blogList[index].attributes!.title!,
                                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              constraints: BoxConstraints(minHeight: 30.h, maxHeight: 75.h),
                                              child: Text(
                                                blogList[index].attributes!.description!,
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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

class BlogPreferences {
  final bool blogChoice;
  final String? title;
  final String? description;
  final int? index;

  BlogPreferences({
    required this.blogChoice,
    this.title,
    this.description,
    this.index,
  });
}

class PopMenuBtn extends StatelessWidget {
  const PopMenuBtn({super.key, required this.title, required this.icon});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 10.r),
          child: Text(title),
        ),
      ],
    );
  }
}
