import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/utils/const_value.dart';

Widget restaurantItem(
    {required RestaurantForList restaurant,
    required bool isFavorited,
    required Function() onFavoriteClick}) {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(25)),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                child: Image.network(
                  "$PICTURE_URL_SMALL${restaurant.pictureId}",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                child: Container(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: RichText(
                          overflow: TextOverflow.fade,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "${restaurant.name}\n",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: restaurant.city,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ]),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                            onPressed: onFavoriteClick,
                            icon: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  isFavorited ? Colors.redAccent : Colors.grey,
                            )),
                      )
                    ],
                  ),
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
