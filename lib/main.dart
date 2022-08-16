import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/auth.dart';
import '/providers/courses.dart';
import '/screens/home_screen.dart';
import '/screens/auth_screen.dart';
import '/screens/tabs_screen.dart';
import '/screens/enrolled_screen.dart';
import '/screens/favourites_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/course_detail_screen.dart';
import '/screens/add_course_screen.dart';
import '/screens/playlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Courses>(
          create: (ctx) => Courses(null, null, []),
          update: (ctx, auth, previousCourses) => Courses(
            auth.token,
            auth.userId,
            previousCourses == null ? [] : previousCourses.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Course App',
          theme: ThemeData(
            fontFamily: 'Lato',
            primarySwatch: Colors.cyan,
            accentColor: Colors.white,
            textTheme: ThemeData.light().textTheme.copyWith(
                  subtitle1: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Lato-Bold',
                    fontWeight: FontWeight.w900,
                  ),
                  subtitle2: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato-Bold',
                    color: Colors.white,
                  ),
                  bodyText1: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato-Thin',
                  ),
                  bodyText2: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato-Bold',
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
          ),
          home: auth.isAuth ? const TabsScreen() : const AuthScreen(),
          routes: {
            AuthScreen.routeName: (context) => const AuthScreen(),
            TabsScreen.routeName: (context) => const TabsScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            EnrolledScreen.routeName: (context) => const EnrolledScreen(),
            FavouritesScreen.routeName: (context) => const FavouritesScreen(),
            ProfileScreen.routeName: (context) => const ProfileScreen(),
            CourseDetailScreen.routeName: (context) =>
                const CourseDetailScreen(),
            AddCourseScreen.routeName: (context) => const AddCourseScreen(),
            PlaylistScreen.routeName: (context) => const PlaylistScreen(),
          },
        ),
      ),
    );
  }
}
