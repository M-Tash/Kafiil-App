import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/ui/auth/register/register_screen_view.dart';
import 'package:kafiil_test/utils/custom_widgets/custom_check.dart';
import 'package:kafiil_test/utils/my_theme.dart';

import '../../../domain/di.dart';
import '../../../utils/custom_widgets/custom_text_form_field.dart';
import '../../home/home_screen.dart';
import 'cubit/login_screen_view_model.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, bool> fieldErrors = {
    'email': false,
    'password': false,
  };

  LoginScreenViewModel viewModel =
      LoginScreenViewModel(loginUseCase: injectLoginUseCase());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double baseWidth = isPortrait ? 375 : 812;
    double baseHeight = isPortrait ? 812 : 375;

    double scaleWidth = screenWidth / baseWidth;
    double scaleHeight = screenHeight / baseHeight;

    double iconSize = 24.0;
    double padding = screenWidth * 0.05;
    double fixedBorderRadius = 4;
    double buttonBorderRadius = 12.0;

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<LoginScreenViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            viewModel.showLoadingDialog(context);
          } else if (state is LoginSuccessState) {
            viewModel.dismissLoadingDialog(context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else if (state is LoginErrorState) {
            viewModel.dismissLoadingDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Center(child: Text(state.errorMessage ?? 'Login failed')),
                backgroundColor: MyTheme.primary900Color,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaleHeight * 80, bottom: scaleHeight * 30),
                      child: Row(
                        children: [
                          Text('Account Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: isPortrait
                                        ? screenHeight * 0.025
                                        : screenHeight * 0.065,
                                  )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaleHeight * 10, bottom: scaleHeight * 10),
                      child: Image.asset(
                        'assets/images/Login-image.png',
                        width: scaleWidth * 225,
                        height: scaleHeight * 225,
                      ),
                    ),
                    SizedBox(height: scaleHeight * 10),
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            hasError: fieldErrors['email']!,
                            tagText: 'Email Address',
                            controller: viewModel.emailController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                setState(() {
                                  fieldErrors['email'] = true;
                                });
                                return '';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                setState(() {
                                  fieldErrors['email'] = true;
                                });
                                return 'Invalid email address';
                              }
                              fieldErrors['email'] = false;
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            hasError: fieldErrors['password']!,
                            tagText: 'Password',
                            controller: viewModel.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            isObscure: viewModel.isObscure,
                            isSuffixIcon: true,
                            suffixIcon: GestureDetector(
                              child: Icon(
                                viewModel.isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: iconSize,
                                color: MyTheme.grey400Color,
                              ),
                              onTap: () {
                                setState(() {
                                  viewModel.isObscure = !viewModel.isObscure;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                setState(() {
                                  fieldErrors['password'] = true;
                                });
                                return '';
                              }
                              if (value.trim().length < 8 ||
                                  value.trim().length > 30) {
                                setState(() {
                                  fieldErrors['password'] = true;
                                });
                                return 'Password must be between 8 and 30 characters';
                              }
                              fieldErrors['password'] = false;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                          Row(
                            children: [
                              CustomCheckbox(
                                value: viewModel.rememberMe,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    viewModel.rememberMe = newValue;
                                  });
                                },
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text('Remember me',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: isPortrait
                                            ? screenHeight * 0.017
                                            : screenHeight * 0.05,
                                      )),
                              const Spacer(),
                              GestureDetector(
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        fontSize: isPortrait
                                            ? screenHeight * 0.017
                                            : screenHeight * 0.05,
                                      ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.015,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: scaleHeight * 20, bottom: scaleHeight * 20),
                      child: GestureDetector(
                        onTap: () {
                          bool isEmailValid = viewModel.emailController.text
                                  .trim()
                                  .isNotEmpty &&
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(
                                      viewModel.emailController.text.trim());

                          bool isPasswordValid = viewModel
                                  .passwordController.text
                                  .trim()
                                  .isNotEmpty &&
                              viewModel.passwordController.text.trim().length >=
                                  8 &&
                              viewModel.passwordController.text.trim().length <=
                                  30;

                          viewModel.validateForm();

                          if (!viewModel.isErrorVisible &&
                              isEmailValid &&
                              isPasswordValid) {
                            viewModel.login();
                          } else {
                            String errorMessage;

                            if (viewModel.emailController.text.trim().isEmpty) {
                              errorMessage =
                                  'Please fill in all required fields.';
                            } else if (!isEmailValid) {
                              errorMessage = 'Invalid email address';
                            } else if (viewModel.passwordController.text
                                .trim()
                                .isEmpty) {
                              errorMessage =
                                  'Please fill in all required fields.';
                            } else if (!isPasswordValid) {
                              errorMessage = 'Invalid password';
                            } else {
                              errorMessage =
                                  'Please fill in all required fields.';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  errorMessage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: MyTheme.grey50Color),
                                ),
                                backgroundColor: MyTheme.primary900Color,
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          // Match the width of text fields
                          height: scaleHeight * 50,
                          decoration: BoxDecoration(
                            color: MyTheme.primary900Color,
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: isPortrait
                                          ? screenHeight * 0.017
                                          : screenHeight * 0.05,
                                      color: MyTheme.grey50Color),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: isPortrait
                                      ? screenHeight * 0.017
                                      : screenHeight * 0.05,
                                ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Register',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: isPortrait
                                          ? screenHeight * 0.017
                                          : screenHeight * 0.05,
                                    ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
