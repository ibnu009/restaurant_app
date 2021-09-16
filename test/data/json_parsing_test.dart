import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';

var testRestaurant = {
  "id": "1",
  "name": "Test Cafe",
  "description": "Lorem Ipsum Dolor",
  "pictureId": "1",
  "city": "Bondowoso",
  "rating": 5
};
void main() {
  test("Test Parsing JSON", () async {
    var result = RestaurantForList.fromJson(testRestaurant).id;

    expect(result, "1");
  });
}
