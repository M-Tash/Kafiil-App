import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafiil_test/ui/home/cubit/home_screen_view_model.dart';
import 'package:kafiil_test/utils/my_theme.dart';

import '../../../../utils/custom_widgets/pagination.dart';
import '../../cubit/states.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  int currentPage = 1;
  final int itemsPerPage = 8;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    HomeScreenViewModel.getBloc(context).getCountries(page: currentPage);
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
    HomeScreenViewModel.getBloc(context).getCountries(page: page);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isPortrait = screenHeight > screenWidth;

    double containerHeight =
        isPortrait ? screenHeight * 0.5 : screenHeight * 0.5;
    double containerWidth = isPortrait ? screenWidth * 0.9 : screenWidth * 0.7;
    double paddingTop = isPortrait ? screenHeight * 0.05 : screenHeight * 0.03;
    double titlePaddingHorizontal =
        isPortrait ? screenWidth * 0.05 : screenWidth * 0.15;
    double titlePaddingVertical =
        isPortrait ? screenHeight * 0.04 : screenHeight * 0.05;
    double headerHeight =
        isPortrait ? screenHeight * 0.05 : screenHeight * 0.09;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: titlePaddingHorizontal,
                  vertical: titlePaddingVertical,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Countries',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: isPortrait
                              ? screenHeight * 0.022
                              : screenHeight * 0.055,
                        ),
                  ),
                ),
              ),
              BlocBuilder<HomeScreenViewModel, HomeScreenState>(
                builder: (context, state) {
                  List<Map<String, String>> countries = [];
                  if (state is CountriesSuccessState) {
                    countries = state.countriesData.data
                            ?.map((country) => {
                                  'country': country.name ?? '',
                                  'capital': country.capital ?? '',
                                })
                            .toList() ??
                        [];
                    totalPages =
                        state.countriesData.pagination?.totalPages ?? 1;
                  }
                  return Center(
                    child: Column(
                      children: [
                        buildCountriesList(
                          state,
                          countries,
                          containerHeight,
                          containerWidth,
                          headerHeight,
                          isPortrait,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                          child: PaginationControls(
                            currentPage: currentPage,
                            totalPages: totalPages,
                            onPageChanged: _onPageChanged,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountriesList(HomeScreenState state,
      List<Map<String, String>> countries,
      double containerHeight,
      double containerWidth,
      double headerHeight,
    bool isPortrait,
  ) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      height: containerHeight,
      width: containerWidth,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: headerHeight * 0.25),
            child: Container(
              height: headerHeight,
              width: containerWidth * 0.96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyTheme.grey50Color,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Country',
                        style: TextStyle(
                          color: const Color(0xff696F79),
                          fontSize: isPortrait
                              ? screenHeight * 0.020
                              : screenHeight * 0.050,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Capital',
                        style: TextStyle(
                          color: const Color(0xff696F79),
                          fontSize: isPortrait
                              ? screenHeight * 0.020
                              : screenHeight * 0.050,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (state is CountriesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.primary900Color,
                    ),
                  );
                } else if (state is CountriesErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is CountriesSuccessState) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 1),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  countries[index]['country']!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontSize: isPortrait
                                        ? screenHeight * 0.016
                                        : screenHeight * 0.040,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  countries[index]['capital']!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color(0xff000000),
                                    fontSize: isPortrait
                                        ? screenHeight * 0.016
                                        : screenHeight * 0.040,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: MyTheme.grey100Color,
                      thickness: 1.0,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyTheme.primary900Color,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
