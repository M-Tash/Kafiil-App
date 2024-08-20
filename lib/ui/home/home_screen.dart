import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/domain/di.dart';
import 'package:kafiil_test/utils/custom_widgets/custom_bottom_navigation_bar.dart';

import 'cubit/home_screen_view_model.dart';
import 'cubit/states.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = HomeScreenViewModel(
      getCountriesUseCase: injectGetCountriesUseCase(),
      getServicesUseCase: injectGetServicesUseCase(),
      getPopularServicesUseCase: injectPopularServicesUseCase(),
      getProfileUseCase: injectGetProfileUseCase());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenViewModel>(
      create: (context) => viewModel,
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: buildCustomBottomNavigationBar(
              context: context,
              selectedIndex: viewModel.selectedIndex,
              onTapFunction: (index) {
                if (viewModel.selectedIndex == index) {
                  viewModel.refreshCurrentTab();
                } else {
                  viewModel.changeSelectedIndex(index);
                }
              },
            ),
            body: viewModel.tabs[viewModel.selectedIndex],
          );
        },
      ),
    );
  }
}
