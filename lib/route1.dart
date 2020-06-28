import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/res/asset_images.dart';
import 'package:hackathon/routes.dart';
import 'package:hackathon/stores/statistics/statistics_notifier.dart';
import 'package:hackathon/ui/home/home_navigator.dart';
import 'package:hackathon/ui/splash/splash_screen.dart';
import 'package:hackathon/ui/static/static_error_screen.dart';
import 'package:hackathon/utils/bloc/application_bloc.dart';
import 'package:hackathon/utils/bloc/application_events.dart';
import 'package:hackathon/utils/bloc/application_state.dart';
import 'package:hackathon/utils/connection_status_singleton.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'constants/colors.dart';
import 'constants/strings.dart';
import 'data/repository/base_repository.dart';
import 'data/repository/user_repository.dart';

/// [SimpleBloocDelegate] handles all the Bloc events delegated by the [BlocSupervisor]
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    debugPrint('Main Event (SimpleBlocDelegate) :- $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('Main Transition (SimpleBlocDelegate) :- $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    debugPrint('Main Error (SimpleBlocDelegate) :- $error');
  }
}

/// The main function is the entry point of our application,
/// telling Dart where it should start running our code
Future<void> main() async {
  final BaseRepository repository = UserRepository();

  // Initialize WidgetsBinding before runApp
  WidgetsFlutterBinding.ensureInitialized();

  final ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) {
      // Making the [BlocProvider]<ApplicationBloc> available to the entire application
      runApp(
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) {
            return ApplicationBloc(userRepository: repository)
              ..add(AppStarted(context: context));
          },
          child: Route1(
            repository: repository,
          ),
        ),
      );
    },
  );
}

/// Handles all [Bloc] states using [BlocBuilder] to handle the appropriate
/// staes gracefully
///
/// **Required**
/// 1. [BaseRepository] - Used for [HomeChangeNotifier] to make the relevant requests
class Route1 extends StatelessWidget {
  final BaseRepository repository;

  const Route1({Key key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      theme: themeData,
      routes: Routes.routes,
      home: BlocBuilder<ApplicationBloc, ApplicationState>(
        builder: (BuildContext context, ApplicationState state) {
          debugPrint('Main State :- $state');
          if (state is ApplicationUninitialized) {
            return SplashScreen();
          }

          // If the user is logging in to the application for the first time
          // TODO :- Develop the Tutorial Screen and pass it to the [home] parameter
          if (state is ApplicationTutorialState) {
            return MaterialApp(
              theme: themeData,
              debugShowCheckedModeBanner: false,
            );
          }

          // To handle the state with [ApplicationInitialized] after all the required
          // data is pre-fetched to direct the user to the [HomeScreen]
          if (state is ApplicationInitialized) {
            return ChangeNotifierProvider<StatisticsChangeNotifier>(
              create: (BuildContext context) => StatisticsChangeNotifier(
                userRepository: repository,
              ),
              child: Scaffold(
                body: HomeNavigator(),
              ),
            );
          }

          // To handle the state with the [ApplicationNetworkException] to display the
          // Error Screen with the Empty State - No Network
          if (state is ApplicationNetworkException) {
            return Scaffold(
              // [AppBar] with 0 size used to set the statusbar background color and
              // statusbat text/icon color
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: AppBar(
                  backgroundColor: AppColors.whiteColor,
                  brightness: Brightness.light,
                  elevation: 0.0,
                ),
              ),
              body: Center(
                child: StaticErrorScreen(
                  onRetry: () {
                    BlocProvider.of<ApplicationBloc>(context).add(
                      AppStarted(context: context),
                    );
                  },
                  image: const AssetImage(AssetImages.noInternet),
                  title: Strings.noInternetErrorDesc,
                  desc: Strings.noInternetErrorDesc,
                  actionText: Strings.retryButton,
                ),
              ),
            );
          }

          // To handle the Generic Error to display the Error Screen
          // with the Empty State - No Network
          return Scaffold(
            // [AppBar] with 0 size used to set the statusbar background color and
            // statusbat text/icon color
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: AppBar(
                backgroundColor: AppColors.whiteColor,
                brightness: Brightness.light,
                elevation: 0.0,
              ),
            ),
            body: Center(
              child: StaticErrorScreen(
                onRetry: () {
                  BlocProvider.of<ApplicationBloc>(context).add(
                    AppStarted(context: context),
                  );
                },
                image: const AssetImage(AssetImages.genericError),
                title: Strings.genericErrorTitle,
                desc: Strings.genericErrorDesc,
                actionText: Strings.retryButton,
              ),
            ),
          );
        },
      ),
    );
  }
}
