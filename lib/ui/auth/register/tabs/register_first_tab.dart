import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kafiil_test/domain/di.dart';
import 'package:kafiil_test/ui/auth/register/cubit/register_screen_view_model.dart';

import '../../../../utils/custom_widgets/custom_radio.dart';
import '../../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../../../utils/my_theme.dart';

class RegisterFirstTab extends StatefulWidget {
  final RegisterScreenViewModel viewModel;
  final VoidCallback onNext;

  const RegisterFirstTab({
    super.key,
    required this.viewModel,
    required this.onNext,
  });

  @override
  State<RegisterFirstTab> createState() => _RegisterFirstTabState();
}

class _RegisterFirstTabState extends State<RegisterFirstTab> {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel(
      registerUseCase: injectRegisterUseCase(),
      appDependenciesUseCase: injectAppDependenciesUseCase());

  void validateForm() {
    final form = widget.viewModel.formKey.currentState;
    if (form != null && form.validate()) {
      widget.onNext();
    } else {
      setState(() {
        widget.viewModel.isErrorVisible = true;
      });
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: MyTheme.primary900Color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double baseWidth = isPortrait ? 375 : 812;
    double baseHeight = isPortrait ? 812 : 375;

    double scaleWidth = screenWidth / baseWidth;
    double scaleHeight = screenHeight / baseHeight;

    double padding = screenWidth * 0.05;
    double fixedBorderRadius = 4;
    double buttonBorderRadius = 12.0;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: scaleHeight * 20, horizontal: padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: widget.viewModel.isErrorVisible,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom:
                        isPortrait ? screenHeight * 0.02 : screenHeight * 0.03),
                child: Container(
                  width: double.infinity,
                  height:
                      isPortrait ? screenHeight * 0.04 : screenHeight * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(fixedBorderRadius),
                    color: MyTheme.error50Color,
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: isPortrait
                                ? screenWidth * 0.05
                                : screenWidth * 0.03,
                            right: isPortrait
                                ? screenWidth * 0.02
                                : screenWidth * 0.01),
                        child: SvgPicture.asset(
                          'assets/icons/mark_vector.svg',
                          height: isPortrait
                              ? screenHeight * 0.020
                              : screenHeight * 0.05,
                          width: isPortrait
                              ? screenWidth * 0.020
                              : screenWidth * 0.05,
                        ),
                      ),
                      Text(
                        'Fill the required fields',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: isPortrait
                                      ? screenHeight * 0.015
                                      : screenHeight * 0.04,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: scaleHeight * 0.012),
              child: Image.asset(
                'assets/icons/stepper.png',
                width: isPortrait ? scaleWidth * 350 : scaleWidth * 600,
                height: isPortrait
                    ? scaleHeight * 50 : scaleHeight * 100,
              ),
            ),
            Form(
              key: widget.viewModel.formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          width: double.infinity,
                          // Make it responsive
                          tagText: 'First Name',
                          keyboardType: TextInputType.name,
                          controller: widget.viewModel.firstNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              widget.viewModel.isErrorVisible = true;
                              return '';
                            } else if (value.trim().length > 50) {
                              showSnackBar(
                                  'First name cannot exceed 50 characters.');
                              return '';
                            } else if (!RegExp(r'^[a-zA-Z]+$')
                                .hasMatch(value.trim())) {
                              showSnackBar(
                                  'First name should contain only letters.');
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: CustomTextFormField(
                          width: double.infinity,
                          // Make it responsive
                          tagText: 'Last Name',
                          keyboardType: TextInputType.name,
                          controller: widget.viewModel.lastNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              widget.viewModel.isErrorVisible = true;
                              return '';
                            } else if (value.trim().length > 50) {
                              showSnackBar(
                                  'Last name cannot exceed 50 characters.');
                              return '';
                            } else if (!RegExp(r'^[a-zA-Z]+$')
                                .hasMatch(value.trim())) {
                              showSnackBar(
                                  'Last name should contain only letters.');
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: scaleHeight * 0.02),
                  CustomTextFormField(
                    tagText: 'Email Address',
                    controller: widget.viewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        widget.viewModel.isErrorVisible = true;
                        return '';
                      } else if (value.trim().length > 64) {
                        showSnackBar('Email cannot exceed 64 characters.');
                        return '';
                      } else {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                            .hasMatch(value);
                        if (!emailValid) {
                          showSnackBar('Please enter a valid email address.');
                          return '';
                        }
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: scaleHeight * 0.02),
                  CustomTextFormField(
                    tagText: 'Password',
                    controller: widget.viewModel.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: widget.viewModel.isObscure,
                    isSuffixIcon: true,
                    suffixIcon: GestureDetector(
                      child: widget.viewModel.isObscure
                          ? Icon(Icons.visibility_off_outlined,
                              size: 18.0 * scaleWidth,
                              color: MyTheme.grey400Color)
                          : Icon(
                              Icons.visibility_outlined,
                              size: 18.0 * scaleWidth,
                              color: MyTheme.grey400Color,
                            ),
                      onTap: () {
                        setState(() {
                          widget.viewModel.isObscure =
                              !widget.viewModel.isObscure;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        widget.viewModel.isErrorVisible = true;
                        return '';
                      } else if (value.trim().length < 8) {
                        showSnackBar('Password must be at least 8 characters.');
                        return '';
                      } else if (value.trim().length > 40) {
                        showSnackBar('Password cannot exceed 40 characters.');
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: scaleHeight * 0.02),
                  CustomTextFormField(
                    tagText: 'Confirm Password',
                    controller: widget.viewModel.confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: widget.viewModel.isObscure2,
                    isSuffixIcon: true,
                    suffixIcon: GestureDetector(
                      child: widget.viewModel.isObscure2
                          ? Icon(Icons.visibility_off_outlined,
                              size: 18.0 * scaleWidth,
                              color: MyTheme.grey400Color)
                          : Icon(
                              Icons.visibility_outlined,
                              size: 18.0 * scaleWidth,
                              color: MyTheme.grey400Color,
                            ),
                      onTap: () {
                        setState(() {
                          widget.viewModel.isObscure2 =
                              !widget.viewModel.isObscure2;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        widget.viewModel.isErrorVisible = true;
                        return '';
                      } else if (widget
                              .viewModel.confirmPasswordController.text !=
                          widget.viewModel.passwordController.text) {
                        showSnackBar('Passwords do not match.');
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: scaleHeight * 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'User Type',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: isPortrait
                                  ? screenHeight * 0.017
                                  : screenHeight * 0.05,
                            ),
                      ),
                      SizedBox(height: scaleHeight * 10),
                      Row(
                        children: [
                          CustomRadio(
                            title: 'Seller',
                            value: 1,
                            groupValue: widget.viewModel.userType,
                            onChanged: (int value) {
                              setState(() {
                                widget.viewModel.userType = 1;
                              });
                            },
                            activeBorderColor: MyTheme.primary900Color,
                            inactiveBorderColor: MyTheme.grey300Color,
                          ),
                          CustomRadio(
                            title: 'Buyer',
                            value: 2,
                            groupValue: widget.viewModel.userType,
                            onChanged: (int value) {
                              setState(() {
                                widget.viewModel.userType = 2;
                              });
                            },
                            activeBorderColor: MyTheme.primary900Color,
                            inactiveBorderColor: MyTheme.grey300Color,
                          ),
                          CustomRadio(
                            title: 'Both',
                            value: 3,
                            groupValue: widget.viewModel.userType,
                            onChanged: (int value) {
                              setState(() {
                                widget.viewModel.userType = 3;
                              });
                            },
                            activeBorderColor: MyTheme.primary900Color,
                            inactiveBorderColor: MyTheme.grey300Color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: scaleHeight * 50),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: validateForm,
                child: Container(
                  width: screenWidth * 0.4,
                  height: scaleHeight * 50,
                  decoration: BoxDecoration(
                    color: MyTheme.primary900Color,
                    borderRadius: BorderRadius.circular(buttonBorderRadius),
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!.copyWith(
                          fontSize: isPortrait
                              ? screenHeight * 0.017
                              : screenHeight * 0.05,
                          color: MyTheme.bgGrey900Color),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
