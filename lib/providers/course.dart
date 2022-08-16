class Course {
  final String id;
  final String title;
  final String description;
  final double rating;
  final String imageUrl;
  final List<dynamic> playlist;
  bool isFavourite;
  bool isEnrolled;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.playlist,
    this.isFavourite = false,
    this.isEnrolled = false,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    double? rating,
    String? imageUrl,
    List<dynamic>? playlist,
    bool? isFavourite,
    bool? isEnrolled,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      playlist: playlist ?? this.playlist,
      isFavourite: isFavourite ?? this.isFavourite,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }
}
