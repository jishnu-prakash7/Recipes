// import 'package:flutter/material.dart';
// import 'package:recipes_app/screens/home_screen/widgets.dart';
// import 'package:recipes_app/utils/constants.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Recipes'),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.favorite_outline_rounded))
//         ],
//       ),
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   height: 340,
//                   width: MediaQuery.sizeOf(context).width,
//                   child: const ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15),
//                     ),
//                     child: Image(
//                         fit: BoxFit.cover,
//                         image: NetworkImage(
//                             'https://cdn.tasteatlas.com/images/dishes/b6b9680a32c84a9381a1ea5f5e529698.jpg')),
//                   ),
//                 ),
//                 const Searchbar(),
//                 const ContainerText(
//                   bottomSize: 70,
//                   text: 'Dish of the day',
//                   fontSize: 35,
//                   fontWeight: FontWeight.w900,
//                 ),
//                 const ContainerText(
//                     bottomSize: 40,
//                     text: 'Egg Curry',
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.favorite_rounded,
//                       color: Colors.red,
//                       size: 25,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             kheight10,
//             const RecipeCardSection(
//               heading: 'Discover regional delights',
//             ),
//             const RecipeCardSection(
//               heading: 'Breakfasts for champions',
//               headingColor: Colors.white,
//               backgroundColor: Colors.black,
//             ),
//             kheight10,
//             SizedBox(
//               height: 600,
//               child: ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (context, index) => const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 28),
//                   child: CustomCard(
//                     cardHeight: 400,
//                     cardWidth: 0,
//                     title: 'Bissi belle bhaath,North Karnataka style',
//                     titleSize: 23,
//                     textSize: 17,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:recipes_app/screens/home_screen/widgets.dart';
import 'package:recipes_app/services/api_services.dart';
import 'package:recipes_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ApiServices().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 340,
                  width: MediaQuery.of(context).size.width,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.tasteatlas.com/images/dishes/b6b9680a32c84a9381a1ea5f5e529698.jpg')),
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
                    text: 'Egg Curry',
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
                )
              ],
            ),
            kheight10,
            const RecipeCardSection(
              heading: 'Discover regional delights',
            ),
            kheight10,
            const RecipeCardSection(
              heading: 'Breakfasts for champions',
              headingColor: Colors.white,
              backgroundColor: Colors.black,
            ),
            kheight10,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 28),
                child: CustomCard(
                  cardHeight: 400,
                  cardWidth: 0,
                  title: 'Bissi belle bhaath,North Karnataka style',
                  titleSize: 23,
                  textSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
