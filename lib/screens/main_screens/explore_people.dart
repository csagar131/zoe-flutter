import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:zoe/api/api_config.dart';
import 'package:zoe/controllers/api_controllers/user_login.dart';
import 'package:zoe/controllers/spinner.dart';
import 'package:zoe/dummy_data.dart';
import 'package:zoe/models/response_model.dart';
import 'package:zoe/themes/app_text_styles.dart';
import 'package:zoe/widgets/explore_widgets/swipe_card.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class ExplorePeopleScreen extends StatefulWidget {
  const ExplorePeopleScreen({super.key});

  @override
  State<ExplorePeopleScreen> createState() => _ExplorePeopleScreenState();
}

class _ExplorePeopleScreenState extends State<ExplorePeopleScreen>
    with SingleTickerProviderStateMixin {
  final CardSwiperController cardSwiperController = CardSwiperController();
  final SpinnerController spinnerController = Get.put(SpinnerController());
  final UserController userController = Get.put(UserController());

  bool isEndReached = false;

  late List<dynamic> candidates = data;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  @override
  void dispose() {
    cardSwiperController.dispose();
    super.dispose();
  }

  void getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    handleUpdateUserProfile(position.latitude, position.longitude);
  }

  void handleUpdateUserProfile(double latitude, double longitude) async {
    try {
      spinnerController.toggleSpinner();
      final postData = json.encode({
        "longitude": longitude.toString(),
        "latitude": latitude.toString(),
        "min_radius": 2,
        "max_radius": 5,
        "min_age": 18,
        "max_age": 25,
      });
      final response = await dio.patch('/account/user/update-profile',
          data: postData,
          options: Options(headers: {
            'Authorization':
                'Token ${userController.loginApiResponse.data.token.toString()}'
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) {
          return;
        }
        getUsersProfile();
      }
    } on DioException catch (e) {
      String errorMessage = e.toString();
      // errorMessage = ApiResponse.fromJson(e.response!.data).message;
      if (context.mounted) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(15),
        );
      }
    } finally {
      spinnerController.toggleSpinner();
    }
  }

  void getUsersProfile() async {
    try {
      spinnerController.toggleSpinner();

      final response = await dio.get('/account/profile/listing',
          options: Options(headers: {
            'Authorization':
                'Token ${userController.loginApiResponse.data.token.toString()}'
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) {
          return;
        }
      }
    } on DioException catch (e) {
      String errorMessage = e.toString();
      errorMessage = ApiResponse.fromJson(e.response!.data).message;
      if (context.mounted) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(15),
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (context.mounted) {
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(15),
        );
      }
    } finally {
      spinnerController.toggleSpinner();
    }
  }

  void handleOnEnd() {
    setState(() {
      isEndReached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    SpinnerController spinnerController = Get.put(SpinnerController());
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   PopupMenuButton<String>(
        //     onSelected: (value) {
        //       handlePopupMenuSelected(value);
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return {'Logout'}.map((String choice) {
        //         return PopupMenuItem<String>(
        //           value: choice,
        //           child: Text(choice),
        //         );
        //       }).toList();
        //     },
        //   ),
        // ],
        title: Text(
          'ZOe',
          style: AppTextStyle.boldPrimary18,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => spinnerController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: !isEndReached
                      ? CardSwiper(
                          isLoop: false,
                          onEnd: () {
                            handleOnEnd();
                          },
                          controller: cardSwiperController,
                          numberOfCardsDisplayed: 2,
                          cardsCount: candidates.length,
                          cardBuilder: (context,
                                  index,
                                  horizontalOffsetPercentage,
                                  verticalOffsetPercentage) =>
                              SwipeCard(
                            imgUrl: data[index]['imgUrl']!,
                            name: data[index]['name']!,
                            age: data[index]['age']!,
                            distance: data[index]['distance']!,
                            city: data[index]['city']!,
                            swipeRight: cardSwiperController.swipeRight,
                            swipeLeft: cardSwiperController.swipeLeft,
                          ),
                        )
                      : Center(
                          child: Text(
                            'You are all caught up...',
                            style: AppTextStyle.mediumBlack16,
                          ),
                        ),
                ),
              ),
      ),
    );
  }
}
