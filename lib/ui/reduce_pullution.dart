
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:hackathon/utils/colors.dart';
import 'package:hackathon/utils/page_transformer.dart';
import 'package:hackathon/utils/text_styles.dart';
import 'package:hackathon/utils/ui_helpers.dart';
import 'package:hackathon/widgets/parallax_cards.dart';
import 'package:hackathon/widgets/swiping_cards.dart';

List<String> swipingCardImages = [
  'assets/1.png',
  'assets/2.jpg',
  'assets/3.jpg',
  'assets/4.jpg',
  'assets/5.jpg',
 // 'assets/music/album1.jpg',
];

List<String> swipingCardTitles = [
  'Random Access Memories',
  'Voicenotes',
  'Stargazing',
  'Night Visions',
  'In A Perfect World',
  //'Native',
];

class ParallaxCardItem {
  ParallaxCardItem({
    this.title,
    this.body,
    this.imagePath,
  });

  final String title;
  final String body;
  final String imagePath;
}

final parallaxCardItemsList = <ParallaxCardItem>[
  ParallaxCardItem(
    title: 'Blurryface',
    body: 'Twenty One Pilots',
    imagePath: 'assets/3.jpg',
  ),
  ParallaxCardItem(
    title: 'Free Spirit',
    body: 'Khalid',
    imagePath: 'assets/2.jpg',
  ),
  ParallaxCardItem(
    title: 'Overexposed',
    body: 'Maroon 5',
    imagePath: 'assets/1.png',
  ),
];

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;
var gradientStartColor;
var gradientEndColor;
PageController controller =
    PageController(initialPage: swipingCardImages.length - 1);
var i = swipingCardImages.length - 1;

class ReducePullution extends StatefulWidget {
  @override
  _ReducePullutionState createState() => _ReducePullutionState();
}

class _ReducePullutionState extends State<ReducePullution> {
  var currentPage = swipingCardImages.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: swipingCardImages.length - 1);
    controller.addListener(
      () {
        setState(
          () {
            currentPage = controller.page;
          },
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              //gradient colors change according to set theme
              colors: isThemeCurrentlyDark(context)
                  ? [GradientColors.darkStart, GradientColors.darkEnd]
                  : [GradientColors.lightStart, GradientColors.lightEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(EvaIcons.arrowIosBack),
                      tooltip: 'Go back',
                      color: isThemeCurrentlyDark(context)
                          ? MaterialColors.teal
                          : MyColors.light,
                      iconSize: 26.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    GradientText(
                      'Tips to reduce Pollution',
                      shaderRect: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                      gradient: isThemeCurrentlyDark(context)
                          ? Gradients.coldLinear
                          : Gradients
                              .haze, //gradient colors change according to set theme
                      style: isThemeCurrentlyDark(context)
                          ? TitleStylesDefault.white
                          : TitleStylesDefault.black,
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  SwipingCards(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: swipingCardImages.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: SizedBox.fromSize(
                  size: Size.fromHeight(500.0),
                  child: PageTransformer(
                    pageViewBuilder: (context, visibilityResolver) {
                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount: parallaxCardItemsList.length,
                        itemBuilder: (context, index) {
                          final item = parallaxCardItemsList[index];
                          final pageVisibility =
                              visibilityResolver.resolvePageVisibility(index);

                          return ParallaxCards(
                            item: item,
                            pageVisibility: pageVisibility,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}