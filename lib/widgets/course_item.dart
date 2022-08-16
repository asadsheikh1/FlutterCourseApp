import 'package:flutter/material.dart';

import '/screens/course_detail_screen.dart';

class CourseItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const CourseItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      CourseDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 250,
        width: 300,
        child: Card(
          elevation: 10,
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(4),
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                child: Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
