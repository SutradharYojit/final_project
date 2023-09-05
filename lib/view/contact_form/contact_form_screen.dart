import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';
import '../../widget/widget.dart';

class ContactFormScreen extends StatelessWidget {
  ContactFormScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(
            title: "Contact Us",
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _nameController,
                    hintText: "Enter Your Name",
                    labelText: "Name",
                    prefixIcon: const Icon(
                      Icons.text_format_rounded,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _phoneController,
                    hintText: "Enter phone Number",
                    labelText: "Phone Number",
                    prefixIcon: const Icon(
                      Icons.call,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    prefixText: "+91-",
                    maxLength: 10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _emailController,
                    hintText: StringManager.emailHintTxt,
                    labelText: StringManager.emailLabelTxt,
                    prefixIcon: const Icon(
                      Icons.mail_rounded,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.r),
                  child: PrimaryTextFilled(
                    controller: _descriptionController,
                    hintText: "Enter Description",
                    labelText: "Description",
                    prefixIcon: const Icon(
                      Icons.description,
                      color: ColorManager.gradientPurpleColor,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                PrimaryButton(
                  title: "Send Message",
                  onTap: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
