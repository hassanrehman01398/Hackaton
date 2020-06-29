import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../constants/dimens.dart';
import '../../constants/strings.dart';
import '../../constants/text_styles.dart';
import '../../data/network/constants/endpoints.dart';
import '../../icons/covid19_icons.dart';
import '../../res/asset_images.dart';
import '../../ui/home/home_navigator.dart';
import '../../ui/home/widgets/home_card_widget.dart';
import '../../utils/cache_manager.dart';
import '../../utils/custom_scroll_behaviour.dart';
import '../../utils/device/device_utils.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/sized_box_height_widget.dart';

/// [HomeScreen] is the first Screen of the application which displays various
/// cards available to the user and handles routes for each of them
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceUtils.getScaledWidth(context, 1);
    final screenHeight = DeviceUtils.getScaledHeight(context, 1);
    return Material(
      child: Scaffold(
        // [AppBar] with 0 size used to set the statusbar background color and
        // statusbat text/icon color
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: AppColors.transparentColor,
            brightness: Brightness.light,
            elevation: 0.0,
          ),
        ),
        body: ScrollConfiguration(
          behavior: const CustomScrollBehaviour(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.horizontalPadding,
                Dimens.verticalPadding / 0.75,
                Dimens.horizontalPadding,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //    /image: AssetImage('assets/bg.png'),
                            //     fit: BoxFit.cover),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                              Colors.lightGreen[800],
                              Colors.lightGreen[500],
                              Colors.lightGreen[200]
                            ])),
                        height: MediaQuery.of(context).size.height * 0.40,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 90.0,
                      child: Text(
                        Strings.appSlogan,
                        style: TextStyles.statisticsHeadingTextStlye.copyWith(
                            fontSize: screenHeight / 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: screenHeight / 1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: CachedNetworkImageProvider(
                            Endpoints.fetchHomeGraphic,
                            cacheManager: CacheManager(),
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ], overflow: Overflow.visible),

                  // Page Header Rowƒ
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     // Page Title

                  //     // Information Icon
                  //     // GestureDetector(
                  //     //   onTap: () => showDialog(
                  //     //     context: context,
                  //     //     builder: (BuildContext context) {
                  //     //       return CustomAlertDialog(
                  //     //         title: RichText(
                  //     //           softWrap: true,
                  //     //           text: TextSpan(children: <TextSpan>[
                  //     //             // Dialog Title - Data Source
                  //     //             // TextSpan(
                  //     //             //   text:
                  //     //             //       '${Strings.projectOpenSourceHeading}\n\n',
                  //     //             //   style: TextStyles.hightlightText.copyWith(
                  //     //             //     fontSize: screenHeight / 50,
                  //     //             //   ),
                  //     //             // ),

                  //     //             // Dialoog description referncing and linking the blog post
                  //     //             // and the Author
                  //     //             TextSpan(
                  //     //               style: TextStyles
                  //     //                   .statisticsSubHeadingTextStlye
                  //     //                   .copyWith(
                  //     //                 fontSize: screenHeight / 60,
                  //     //               ),
                  //     //               children: <InlineSpan>[
                  //     //                 const TextSpan(
                  //     //                   text: Strings.projectOpenSourceDetails,
                  //     //                 ),
                  //     //                 TextSpan(
                  //     //                   text: Strings.github,
                  //     //                   style: const TextStyle(
                  //     //                     decoration: TextDecoration.underline,
                  //     //                     color: AppColors.accentBlueColor,
                  //     //                   ),
                  //     //                   // Launching the URL of the blog post
                  //     //                   // throwing an error if the user doesn't have any browswer to open the link (Shouldn't ever happen)
                  //     //                   recognizer: TapGestureRecognizer()
                  //     //                     ..onTap = () async => await canLaunch(
                  //     //                             Endpoints
                  //     //                                 .baseUrlGithubRepository)
                  //     //                         ? launch(Endpoints
                  //     //                             .baseUrlGithubRepository)
                  //     //                         : throw 'Could not launch Refernce URL',
                  //     //                 ),
                  //     //               ],
                  //     //             ),
                  //     //           ]),
                  //     //         ),

                  //     //         // Defining the Action item [Close] for the Dialog
                  //     //         actions: <Widget>[
                  //     //           GestureDetector(
                  //     //             onTap: () => Navigator.of(context).pop(),
                  //     //             child: Container(
                  //     //               padding: EdgeInsets.symmetric(
                  //     //                 horizontal: screenWidth / 25,
                  //     //                 vertical: screenHeight / 75,
                  //     //               ),
                  //     //               decoration: BoxDecoration(
                  //     //                 boxShadow: const [
                  //     //                   BoxShadow(
                  //     //                     offset: Offset(-2, 4),
                  //     //                     blurRadius: 2,
                  //     //                     color: AppColors.boxShadowColor,
                  //     //                   ),
                  //     //                 ],
                  //     //                 borderRadius: BorderRadius.all(
                  //     //                   Radius.circular(screenHeight / 75),
                  //     //                 ),
                  //     //                 color: AppColors.accentBlueColor,
                  //     //               ),
                  //     //               child: Text(
                  //     //                 'Close',
                  //     //                 style: TextStyles
                  //     //                     .statisticsHeadingTextStlye
                  //     //                     .copyWith(
                  //     //                   fontSize: screenHeight / 65,
                  //     //                 ),
                  //     //               ),
                  //     //             ),
                  //     //           ),
                  //     //         ],
                  //     //       );
                  //     //     },
                  //     //   ),
                  //     //   child: Icon(
                  //     //     Covid19Icons.error,
                  //     //     size: screenHeight / 25,
                  //     //     color: AppColors.blackColor,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),

                  // Vertical Spacing
                  // SizedBoxHeightWidget(screenHeight / 30),

                  // Vertical Spacing
                  //SizedBoxHeightWidget(screenHeight / 30),

                  Row(
                    children: <Widget>[
                      // Statistics Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.statisticsTitle,
                          imagePath: AssetImages.statistics,
                          backgroundImage: true,
                          route: HomeRoutes.statistics.name,
                        ),
                      ),

                      // Prevention Numbers Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.preventionTitle,
                          imagePath: AssetImages.prevention,
                          route: HomeRoutes.prevention.name,
                        ),
                      ),

                      // Symptoms Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.symptomsTitle,
                          imagePath: AssetImages.symptoms,
                          route: HomeRoutes.symptoms.name,
                        ),
                      ),
                    ],
                  ),

                  // Vertical Spacing
                  SizedBoxHeightWidget(screenHeight / 250),

                  Row(
                    children: <Widget>[
                      // Myth Busters Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.mythBusterTitle,
                          imagePath: AssetImages.mythBusters,
                          route: HomeRoutes.mythBusters.name,
                        ),
                      ),

                      // FAQ Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.faqTitle,
                          imagePath: AssetImages.faq,
                          route: HomeRoutes.faq.name,
                        ),
                      ),

                      // Coronavirus information Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.covidInformationTitle,
                          imagePath: AssetImages.virus,
                          route: HomeRoutes.information.name,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      // Myth Busters Card
                      Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.notifyTitle,
                          imagePath: AssetImages.notify,
                          route: HomeRoutes.notify.name,
                        ),
                      ),
Expanded(
                        flex: 1,
                        child: HomeCardWidget(
                          backgroundColor: AppColors.primaryColor,
                          title: Strings.maskdetection,
                          imagePath: AssetImages.mask,
                          route: HomeRoutes.mask.name,
                        ),
                      ),
                    ],
                  ),
                  // Sympton Checker Card
                  // GestureDetector(
                  //   onTap: () => HomeNavigator.navigatorKey.currentState
                  //       .pushNamed(HomeRoutes.symptomChecker.name),
                  //   child: Hero(
                  //     tag: 'symptomChecker',
                  //     child: SymptomCheckerCardWidget(),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 8, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
