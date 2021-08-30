import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

Widget restaurantItem(BuildContext context, Restaurant restaurant) {
  final responsiveHeight = MediaQuery.of(context).size.height * 0.15;
  final responsiveWidth = MediaQuery.of(context).size.width * 0.45;
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(25)),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: responsiveWidth,
      height: responsiveHeight,
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Image.network(
                  restaurant.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                child: Text(restaurant.name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                child: Text(
                  restaurant.city,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.blue,
                    size: 45.0,
                  ),
                  Text(
                    restaurant.rating.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
