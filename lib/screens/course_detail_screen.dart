import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/providers/auth.dart';
import '/providers/courses.dart';
import '/widgets/my_title.dart';
import '/screens/playlist_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/course-detail';

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  Widget buildContainer(Widget child) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            width: 4.0,
          ),
          shape: BoxShape.rectangle,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 260,
        width: 380,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<Courses>(context);
    final authData = Provider.of<Auth>(context);
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final selectedCourse = courses.findById(id);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(selectedCourse.title.toUpperCase()),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(selectedCourse.imageUrl),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const MyTitle(title: "Description"),
                    Text(
                      selectedCourse.description.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const MyTitle(title: "Rating"),
                    RatingBarIndicator(
                      rating: selectedCourse.rating,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Theme.of(context).primaryColor,
                      ),
                      itemCount: 5,
                      itemSize: 30,
                      unratedColor:
                          Theme.of(context).primaryColor.withAlpha(50),
                      direction: Axis.horizontal,
                    ),
                    MyTitle(title: "${selectedCourse.rating.toString()} / 5"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const MyTitle(title: "Playlist"),
                    buildContainer(
                      ListView.builder(
                        itemBuilder: (ctx, index) => Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text('# ${(index + 1)}'),
                              ),
                              title: Text('Video # ${index + 1}'),
                              trailing: Consumer<Courses>(
                                builder: (_, courses, child) => Icon(
                                  courses.findById(id).isEnrolled
                                      ? Icons.lock_open
                                      : Icons.lock,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                        itemCount: selectedCourse.playlist.length,
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<Courses>(
                builder: (_, courses, child) => ElevatedButton(
                  onPressed: () {
                    courses.pressEnroll(id, authData.userId!).then((_) {
                      Navigator.of(context).pushNamed(
                        PlaylistScreen.routeName,
                        arguments: id,
                      );
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 40,
                    ),
                    backgroundColor: courses.findById(id).isEnrolled
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    elevation: 4,
                  ),
                  child: courses.findById(id).isEnrolled
                      ? Text(
                          'View'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          'Enroll'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<Courses>(
        builder: (_, courses, child) => FloatingActionButton(
          foregroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            courses.toggleFavorite(id, authData.userId!);
          },
          child: Icon(
            courses.findById(id).isFavourite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
        ),
      ),
    );
  }
}
