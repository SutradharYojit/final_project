import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:final_project_blog_app/resources/resources.dart';
import 'package:final_project_blog_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../auth/signup/signup_screen.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final TextEditingController _descriptionController = TextEditingController();
  File? imageFile;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          title: "Add Blog",
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Center(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12.r),
                    padding: EdgeInsets.all(6.r),
                    dashPattern: const [7, 3],
                    strokeWidth: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                      child: imageFile != null
                          ? SizedBox(
                              height: 170.h,
                              width: double.infinity,
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 170.h,
                              width: double.infinity,
                              color: ColorManager.gradientLightPurpleColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    splashColor: Colors.teal,
                                    onPressed: () async {
                                      final image = await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      setState(() {
                                        imageFile = File(image!.path);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      size: 50.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _titleController,
                    hintText: StringManager.titleHintTxt,
                    labelText: StringManager.titleLabelTxt,
                    prefixIcon: const Icon(
                      Icons.title,
                      color: ColorManager.gradientPurpleColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _descriptionController,
                    hintText: StringManager.descriptionHintTxt,
                    labelText: StringManager.descriptionLabelTxt,
                    prefixIcon: const Icon(
                      Icons.title,
                      color: ColorManager.gradientPurpleColor,
                    ),
                  ),
                ),
                PrimaryButton(
                  title: StringManager.addBlogBtn,
                  onTap: () async {
                    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                    if (_titleController.text.trim() == "" ||
                        _titleController.text.trim().isEmpty ||
                        _descriptionController.text.trim() == "" ||
                        _descriptionController.text.trim().isEmpty) {
                      requiredAllFilled(context);
                    } else {
                      //Add Blog Data function
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
