import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/courses.dart';
import '/widgets/course_item.dart';

class RecommendedCourses extends StatelessWidget {
  const RecommendedCourses({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<Courses>(context);

    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => CourseItem(
          id: courses.items[index].id,
          title: courses.items[index].title,
          imageUrl: courses.items[index].imageUrl,
        ),
        itemCount: courses.items.length,
      ),
    );
  }
}
