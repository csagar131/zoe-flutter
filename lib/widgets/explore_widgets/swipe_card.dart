import 'package:flutter/material.dart';
import 'package:zoy/themes/app_text_styles.dart';

class SwipeCard extends StatelessWidget {
  final String name;
  final int age;
  final int distance;
  final String city;
  final String imgUrl;
  final VoidCallback swipeRight;
  final VoidCallback swipeLeft;

  const SwipeCard(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.age,
      required this.distance,
      required this.city,
      required this.swipeRight,
      required this.swipeLeft});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          clipBehavior: Clip.values[2],
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.bottomLeft,
          child: Image.network(
            imgUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: AppTextStyle.regularWhite24,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    age.toString(),
                    style: AppTextStyle.regularWhite28,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '$distance km away',
                    style: AppTextStyle.regularWhite14,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Lives in $city',
                    style: AppTextStyle.regularWhite14,
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: swipeLeft,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: swipeRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      width: 65,
                      height: 65,
                      child: const Icon(
                        Icons.favorite,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
