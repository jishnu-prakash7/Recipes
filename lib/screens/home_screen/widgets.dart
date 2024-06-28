import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipes_app/models/data_model.dart';
import 'package:recipes_app/utils/constants.dart';

//text under searchbar
class ContainerText extends StatelessWidget {
  final String text;
  final double bottomSize;
  final double fontSize;
  final FontWeight fontWeight;
  const ContainerText({
    required this.bottomSize,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: bottomSize,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}

//searchbar
class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: SizedBox(
        height: 35,
        child: TextFormField(
          decoration: const InputDecoration(
              fillColor: Color.fromARGB(179, 251, 250, 250),
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              hintText: 'Search',
              hintStyle: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.zero),
        ),
      ),
    );
  }
}

//text inside card
Row cardTextSection(
    {required String text,
    required IconData icon,
    Color? iconColor,
    required double size}) {
  return Row(
    children: [
      Icon(
        icon,
        size: size,
        color: iconColor ?? Colors.grey,
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        text,
        style: TextStyle(fontSize: size),
      )
    ],
  );
}

//recipie section

class RecipeCardSection extends StatelessWidget {
  final String heading;
  final Color? backgroundColor;
  final Color? headingColor;
  final List<DataModel> recipeList;
  const RecipeCardSection({
    super.key,
    required this.heading,
    this.backgroundColor,
    this.headingColor,
    required this.recipeList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kheight10,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              heading,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: headingColor),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: recipeList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CustomCard(
                  cardHeight: 290,
                  cardWidth: 245,
                  title: recipeList[index].dishName,
                  titleSize: 18,
                  textSize: 16,
                  itemImage: recipeList[index].imageUrl,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//card

class CustomCard extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final String title;
  final String itemImage;
  final double titleSize;
  final double textSize;
  const CustomCard({
    super.key,
    required this.cardHeight,
    required this.cardWidth,
    required this.title,
    required this.titleSize,
    required this.textSize,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      width: cardWidth,
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: cardHeight / 1.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          topStart: Radius.circular(10)),
                      color: Colors.teal),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image(
                        fit: BoxFit.cover, image: NetworkImage(itemImage)),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: Color.fromARGB(255, 207, 206, 206),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: titleSize),
                  ),
                  kheight5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardTextSection(
                          text: '20 minutes',
                          icon: Icons.access_time,
                          iconColor: Colors.black,
                          size: textSize),
                      cardTextSection(
                          text: 'Vegetarian',
                          icon: Icons.circle,
                          iconColor: const Color.fromARGB(255, 23, 160, 128),
                          size: textSize)
                    ],
                  ),
                  kheight5,
                  RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 13,
                      itemBuilder: (context, _) => const Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (rating) {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
