import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/course.dart';
import '/providers/courses.dart';
import '/widgets/course_item.dart';

class FeaturedCourses extends StatelessWidget {
  const FeaturedCourses({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<Courses>(context);
    final List<Course> reversedCourses = courses.items.reversed.toList();

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => CourseItem(
          id: reversedCourses[index].id,
          title: reversedCourses[index].title,
          imageUrl: reversedCourses[index].imageUrl,
        ),
        itemCount: courses.items.length,
      ),
    );
  }
}
