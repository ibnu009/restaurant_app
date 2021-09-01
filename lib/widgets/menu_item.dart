import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/const_value.dart';

Widget menuItem(
    {required BuildContext context,
    required String name,
    required String type}) {
  final screen = MediaQuery.of(context).size;

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          width: screen.width * 0.35,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.srcOver),
              child: Image.asset(
                type == FOOD_TYPE ? FOOD_PLACE_HOLDER : DRINK_PLACE_HOLDER,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Spacer(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}
