// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:recipes_app/models/data_model.dart';
import 'package:recipes_app/provider/data_provider.dart';
import 'package:recipes_app/screens/home_screen/widgets.dart';
import 'package:recipes_app/utils/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen((result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && !isAlertSet) {
        showDialogBox();
        setState(() => isAlertSet = true);
      } else if (isDeviceConnected && isAlertSet) {
        Navigator.pop(context);
        setState(() => isAlertSet = false);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeData = ref.watch(recipeDataProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Recipes'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline_rounded))
        ],
      ),
      body: recipeData.when(
          data: (recipeData) {
            List<DataModel> recipeList =
                recipeData.map((data) => data).toList();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 340,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(recipeList[1].imageUrl),
                          ),
                        ),
                      ),
                      const Searchbar(),
                      const ContainerText(
                        bottomSize: 70,
                        text: 'Dish of the day',
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                      const ContainerText(
                          bottomSize: 40,
                          text: 'Paneer Curry',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  kheight10,
                  RecipeCardSection(
                    heading: 'Discover regional delights',
                    recipeList: recipeList,
                  ),
                  RecipeCardSection(
                    heading: 'Breakfasts for champions',
                    headingColor: Colors.white,
                    backgroundColor: Colors.black,
                    recipeList: recipeList,
                  ),
                  kheight10,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 28),
                      child: CustomCard(
                        cardHeight: 400,
                        cardWidth: 0,
                        title: recipeList[index].dishName,
                        titleSize: 23,
                        textSize: 17,
                        itemImage: recipeList[index].imageUrl,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, s) =>
              const Center(child: Text('No Internet Available')),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }

  void showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && !isAlertSet) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
