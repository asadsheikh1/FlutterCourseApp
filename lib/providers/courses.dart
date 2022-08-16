import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'course.dart';

class Courses with ChangeNotifier {
  List<Course> _items = [];

  final String? authToken;
  final String? userId;

  Courses(this.authToken, this.userId, this._items);

  List<Course> get items {
    return [..._items];
  }

  List<Course> get favouriteItems {
    return _items.where((course) => course.isFavourite).toList();
  }

  List<Course> get enrolledItems {
    return _items.where((course) => course.isEnrolled == true).toList();
  }

  Course findById(String id) {
    return items.firstWhere((course) => course.id == id);
  }

  Future<void> addCourse(Course course) async {
    final url = Uri.parse(
        'https://course-app-d8207-default-rtdb.firebaseio.com/courses.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': course.title,
            'description': course.description,
            'rating': course.rating,
            'imageUrl': course.imageUrl,
            'playlist': [""],
            'isEnrolled': course.isEnrolled,
          },
        ),
      );
      final newCourse = Course(
        id: json.decode(response.body)['name'],
        title: course.title,
        description: course.description,
        rating: course.rating,
        imageUrl: course.imageUrl,
        playlist: course.playlist,
        isEnrolled: course.isEnrolled,
      );

      _items.add(newCourse);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetCourse() async {
    var url = Uri.parse(
        'https://course-app-d8207-default-rtdb.firebaseio.com/courses.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

      url = Uri.parse(
          'https://course-app-d8207-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken');
      final favouriteResponse = await http.get(url);
      final favouriteData = json.decode(favouriteResponse.body);

      url = Uri.parse(
          'https://course-app-d8207-default-rtdb.firebaseio.com/userEnrolled/$userId.json?auth=$authToken');
      final enrolledResponse = await http.get(url);
      final enrolledData = json.decode(enrolledResponse.body);

      final List<Course> loadedCourse = [];
      extractedData.forEach((courseId, courseData) {
        loadedCourse.add(Course(
          id: courseId,
          title: courseData['title'],
          description: courseData['description'],
          rating: courseData['rating'],
          imageUrl: courseData['imageUrl'],
          playlist: courseData['playlist'],
          isFavourite:
              favouriteData == null ? false : favouriteData[courseId] ?? false,
          isEnrolled:
              enrolledData == null ? false : enrolledData[courseId] ?? false,
        ));
      });
      _items = loadedCourse;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(String id, String userId) async {
    final item = findById(id);
    final url = Uri.parse(
        'https://course-app-d8207-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken');

    try {
      await http
          .put(
        url,
        body: json.encode(
          !item.isFavourite,
        ),
      )
          .then((_) {
        if (_items.contains(item)) {
          _items.remove(item);
          _items.add(item.copyWith(isFavourite: !item.isFavourite));
        }
      });
    } catch (error) {
      rethrow;
    }

    notifyListeners();
  }

  Future<void> pressEnroll(String id, String userId) async {
    final url = Uri.parse(
        'https://course-app-d8207-default-rtdb.firebaseio.com/userEnrolled/$userId/$id.json?auth=$authToken');

    try {
      await http.put(
        url,
        body: json.encode(
          true,
        ),
      );
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }
}
