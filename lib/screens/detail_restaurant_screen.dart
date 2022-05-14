import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/source/data/models/restaurant.dart';
import 'package:restaurant_app/source/data/models/restaurant_for_list.dart';
import 'package:restaurant_app/source/network/responses/detail_restaurant_response.dart';
import 'package:restaurant_app/source/network/services/restaurant_network_service.dart';
import 'package:restaurant_app/utils/connection_supervisor.dart';
import 'package:restaurant_app/utils/const_value.dart';
import 'package:restaurant_app/widgets/menu_item.dart';

class DetailRestaurantScreen extends StatefulWidget {
  static const routeName = '/detailRestaurant';
  final String idRestaurant;

  DetailRestaurantScreen({required this.idRestaurant});

  @override
  _DetailRestaurantScreenState createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  late Future<DetailRestaurantResponse> _futureDetailRestaurant;

  Map _source = {ConnectivityResult.none: false};
  final ConnectionSupervisor _connection = ConnectionSupervisor.instance;

  @override
  void initState() {
    super.initState();
    _connection.init();
    _connection.myStream.listen((event) {
      setState(() => _source = event);
    });
    _futureDetailRestaurant =
        RestaurantNetworkService().fetchRestaurantDetail(widget.idRestaurant);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.idRestaurant,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          body: FutureBuilder(
            future: _futureDetailRestaurant,
            builder: (context, snapshot) {
              var state = snapshot.connectionState;
              switch (state) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    if (_source.keys.toList()[0] == ConnectivityResult.none) {
                      print(snapshot.error);
                      return Center(
                        child: Text(
                          "Tidak ada koneksi Internet, periksa kembali sambungan internet Anda!",
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      print(snapshot.error);
                      return Center(child: Text("Terjadi Kesalahan"));
                    }
                  } else if (snapshot.hasData) {
                    var data = snapshot.data as DetailRestaurantResponse;
                    return _detailRestaurantBody(context, data.restaurant!);
                  } else {
                    return Text('');
                  }
                default:
                  return Text('');
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    _connection.disposeConnectionStream();
    super.dispose();
  }
}

Widget _detailRestaurantBody(BuildContext context, Restaurant restaurant) {
  final screen = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screen.height * 0.4,
          child: Container(
              height: screen.height * 0.4,
              width: screen.width * 1,
              child: Image.network("$PICTURE_URL_LARGE${restaurant.pictureId}",
                  fit: BoxFit.cover)),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          restaurant.city,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.star, color: Colors.yellow),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          restaurant.rating.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Consumer<DatabaseProvider>(builder: (context, provider, _) {
              return FutureBuilder<bool>(
                future: provider.isRestaurantFavorited(restaurant.id),
                builder: (context, snapshot) {
                  var isFavorite = snapshot.data ?? false;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {
                        if (isFavorite) {
                          provider.removeFromFavoriteRestaurant(restaurant.id);
                        } else {
                          var restaurantForList = RestaurantForList(
                              id: restaurant.id,
                              name: restaurant.name,
                              description: restaurant.description,
                              pictureId: restaurant.pictureId,
                              city: restaurant.city,
                              rating: restaurant.rating);
                          provider.addToFavoriteRestaurant(restaurantForList);
                        }
                      },
                      icon: isFavorite
                          ? Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            )
                          : Icon(Icons.favorite_border),
                    ),
                  );
                },
              );
            })
          ],
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
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: SizedBox(
            height: screen.height * 0.175,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.foods.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => imageDialog(
                          name: restaurant.menus.foods[index].name,
                          assetImage: FOOD_PLACE_HOLDER),
                    );
                  },
                  child: menuItem(
                      context: context,
                      name: restaurant.menus.foods[index].name,
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
            'menus Minuman',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: SizedBox(
            height: screen.height * 0.175,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => imageDialog(
                          name: restaurant.menus.drinks[index].name,
                          assetImage: DRINK_PLACE_HOLDER),
                    );
                  },
                  child: menuItem(
                      context: context,
                      name: restaurant.menus.drinks[index].name,
                      type: DRINK_TYPE),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
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
