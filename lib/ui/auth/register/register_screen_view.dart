import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/domain/di.dart';
import 'package:kafiil_test/ui/auth/login/login_screen_view.dart';
import 'package:kafiil_test/ui/auth/register/cubit/register_screen_view_model.dart';
import 'package:kafiil_test/ui/auth/register/tabs/register_first_tab.dart';
import 'package:kafiil_test/ui/auth/register/tabs/register_second_tab.dart';

import '../../../utils/my_theme.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel(
      registerUseCase: injectRegisterUseCase(),
      appDependenciesUseCase: injectAppDependenciesUseCase());
  int _currentIndex = 0;

  void _handleNext() {
    setState(() {
      _currentIndex = 1;
      viewModel.isErrorVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isPortrait = screenHeight > screenWidth;

    double scaleHeight = screenHeight / 857.0;
    double scaleWidth = screenWidth / 375.0;

    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: MyTheme.bgGrey900Color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: scaleWidth * 20,
                top: scaleHeight * 70,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Image.asset(
                      'assets/icons/Vector_outline.png',
                      width: isPortrait ? scaleWidth * 8 : scaleWidth * 15,
                      height: isPortrait ? scaleHeight * 15 : scaleHeight * 30,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    'Register',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: isPortrait
                              ? screenHeight * 0.025
                              : screenHeight * 0.065,
                        ),
                  ),
                ],
              ),
            ),
            _currentIndex == 0
                ? RegisterFirstTab(viewModel: viewModel, onNext: _handleNext)
                : RegisterSecondTab(
                    viewModel: viewModel, onSubmit: viewModel.register),
          ],
        ),
      ),
      ),
    );
  }
}
