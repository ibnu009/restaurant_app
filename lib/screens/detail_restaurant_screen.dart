import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/utils/const_value.dart';
import 'package:restaurant_app/widgets/menu_item.dart';

class DetailRestaurantScreen extends StatelessWidget {
  static const routeName = '/detailRestaurant';
  final Restaurant restaurant;

  DetailRestaurantScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screen.height * 0.4,
              child: Stack(
                children: [
                  Container(
                      height: screen.height * 0.4,
                      width: screen.width * 1,
                      child:
                          Image.network(restaurant.image, fit: BoxFit.cover)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 20,
                                color: Colors.black12)
                          ]),
                      child: Row(
                        children: [
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Icon(Icons.star, color: Colors.yellow),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 16),
              child: Text(
                restaurant.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12),
              child: Row(
                children: [
                  Icon(Icons.place, color: Colors.redAccent),
                  Text(
                    restaurant.city,
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 16),
              child: ReadMoreText(
                restaurant.description,
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black45),
              ),
            ),
            // Foods
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 16),
              child: Text(
                'Menu Makanan',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: screen.height * 0.175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menu.foods.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => imageDialog(
                              name: restaurant.menu.foods[index].name,
                              assetImage: FOOD_PLACE_HOLDER),
                        );
                      },
                      child: MenuItem(
                          context: context,
                          name: restaurant.menu.foods[index].name,
                          type: FOOD_TYPE),
                    );
                  },
                ),
              ),
            ),
            // drinks
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 16),
              child: Text(
                'Menu Minuman',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: screen.height * 0.175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menu.drinks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (_) => imageDialog(
                              name: restaurant.menu.drinks[index].name,
                              assetImage: DRINK_PLACE_HOLDER),
                        );
                      },
                      child: MenuItem(
                          context: context,
                          name: restaurant.menu.drinks[index].name,
                          type: DRINK_TYPE),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget imageDialog({required String name, required String assetImage}) {
  return Dialog(
    child: Container(
      padding: EdgeInsets.only(top: 12),
      width: 200,
      height: 265,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(assetImage), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}
