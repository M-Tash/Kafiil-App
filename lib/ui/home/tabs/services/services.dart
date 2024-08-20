import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/ui/home/cubit/home_screen_view_model.dart';
import 'package:kafiil_test/utils/my_theme.dart';

import '../../../../domain/entities/ServicesDataEntity.dart';
import '../../../../utils/custom_widgets/custom_service_card.dart';
import '../../cubit/states.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() {
    final viewModel = HomeScreenViewModel.getBloc(context);
    viewModel.getServices();
    viewModel.getPopularServices();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double paddingVertical =
        isPortrait ? screenHeight * 0.045 : screenHeight * 0.03;
    double paddingHorizontal =
        isPortrait ? screenWidth * 0.04 : screenWidth * 0.06;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingVertical),
        child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
          builder: (context, state) {
            if (state is ServicesLoadingState ||
                state is PopularServicesLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: MyTheme.primary900Color,
                ),
              );
            } else if (state is ServicesErrorState) {
              return Center(child: Text(state.errorMessage));
            } else if (state is PopularServicesErrorState) {
              return Center(child: Text(state.errorMessage));
            } else if (state is CombinedServicesSuccessState) {
              return _buildContent(
                  context,
                  state.servicesData.data ?? [],
                  state.popularServicesData.data ?? [],
                  screenWidth,
                  screenHeight,
                  isPortrait,
                  paddingHorizontal);
            } else if (state is ServicesSuccessState) {
              return _buildContent(context, state.servicesData.data ?? [], [],
                  screenWidth, screenHeight, isPortrait, paddingHorizontal);
            } else if (state is PopularServicesSuccessState) {
              return _buildContent(
                  context,
                  [],
                  state.popularServicesData.data ?? [],
                  screenWidth,
                  screenHeight,
                  isPortrait,
                  paddingHorizontal);
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      List<ServiceDataEntity> services,
      List<ServiceDataEntity> popularServices,
      double screenWidth,
      double screenHeight,
      bool isPortrait,
      double paddingHorizontal) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: paddingHorizontal,
                top: screenHeight * 0.045,
                bottom: screenHeight * 0.03),
            child: Text(
              'Services',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize:
                        isPortrait ? screenHeight * 0.03 : screenHeight * 0.05,
                  ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: isPortrait ? screenHeight * 0.27 : screenHeight * 0.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return LogoCard(
                        service: services[index],
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        isPortrait: isPortrait);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.04, bottom: screenHeight * 0.03),
            child: Text(
              'Popular Services',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize:
                        isPortrait ? screenHeight * 0.03 : screenHeight * 0.05,
                  ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: isPortrait ? screenHeight * 0.27 : screenHeight * 0.50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularServices.length,
                  itemBuilder: (context, index) {
                    return LogoCard(
                        service: popularServices[index],
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        isPortrait: isPortrait);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}