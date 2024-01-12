import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:zoy/controllers/api_controllers/request_controller.dart';
import 'package:zoy/controllers/api_controllers/user_login.dart';
import 'package:zoy/controllers/spinner.dart';
import 'package:zoy/dummy_data.dart';
import 'package:zoy/themes/app_text_styles.dart';
import 'package:zoy/widgets/explore_widgets/swipe_card.dart';
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

  void handleUpdateUserProfile(double latitude, double longitude) async {
    await ApiRequestController().handleApiRequest(
      showSpinner: false,
      endpoint: '/account/user/update-profile',
      method: HttpMethod.patch,
      data: {
        "longitude": longitude.toString(),
        "latitude": latitude.toString(),
        "min_radius": 2,
        "max_radius": 5,
        "min_age": 18,
        "max_age": 25,
      },
      token: userController.loginApiResponse.data.token.toString(),
      successCallback: getUsersProfile,
      context: context,
    );
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

  void getUsersProfile(dynamic response) async {
    await ApiRequestController().handleApiRequest(
      showSpinner: true,
      endpoint: '/account/profile/listing',
      method: HttpMethod.get,
      token: userController.loginApiResponse.data.token.toString(),
      successCallback: (dynamic response) => {},
    );
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
        title: Text(
          'ZOy',
          style: AppTextStyle.boldPrimary18,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              print('Filter button pressed');
            },
          ),
        ],
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
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
