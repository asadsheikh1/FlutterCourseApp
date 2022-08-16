import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/courses.dart';
import '/widgets/course_item.dart';

class EnrolledScreen extends StatelessWidget {
  static const routeName = '/enrolled';
  const EnrolledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final courses = Provider.of<Courses>(context);
    final enrolledCourses = courses.enrolledItems;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.2 - 27,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.2 - 27,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),
                  topRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          enrolledCourses.isEmpty
              ? Center(
                  child: Text(
                    'You are not enrolled\n in any course.'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Enrolled'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (_, index) => Column(
                            children: [
                              CourseItem(
                                id: enrolledCourses[index].id,
                                title: enrolledCourses[index].title,
                                imageUrl: enrolledCourses[index].imageUrl,
                              ),
                              const Divider(),
                            ],
                          ),
                          itemCount: enrolledCourses.length,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
