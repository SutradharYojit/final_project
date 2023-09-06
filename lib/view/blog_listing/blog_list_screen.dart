import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'blog_data_provider.dart';

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
                      "Yojit Suthar",
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
          Padding(
            padding: EdgeInsets.only(right: 15.0.r),
            child: IconButton(
              onPressed: () {
                context.push(RoutesName.addBlogScreen);
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
          child: Column(
            children: [
              blogList.isEmpty
                  ? const Center(
                      child: Text("No Blog Data"),
                    )
                  : Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 15.w),
                        itemCount: blogList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // context.push(RoutesName.blogDetailsScreen);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          blogList[index].attributes!.authorId!,
                                          style: TextStyle(fontSize: 16.sp),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 10.r),
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
                                            constraints: BoxConstraints(minHeight: 50.h, maxHeight: 75.h),
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
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0.r, bottom: 15.r),
                                  child: Text(
                                    blogList[index].attributes!.publishedAt!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.greyColor,
                                    ),
                                  ),
                                )
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
    );
  }
}
