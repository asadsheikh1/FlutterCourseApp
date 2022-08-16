import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/courses.dart';
import '/widgets/header_with_image.dart';
import '/widgets/recommended_courses.dart';
import '/widgets/featureed_courses.dart';
import '/widgets/my_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Courses>(context, listen: false).fetchAndSetCourse();
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Courses>(context).fetchAndSetCourse().then((_) {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isLoading
          ? const NewCardSkeleton()
          : RefreshIndicator(
              onRefresh: () => widget._refreshProducts(context),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HeaderWithImage(size: size),
                    const MyTitle(title: "Recommended"),
                    const RecommendedCourses(),
                    const SizedBox(height: 20),
                    const MyTitle(title: "Featured"),
                    const FeaturedCourses(),
                  ],
                ),
              ),
            ),
    );
  }
}

class NewCardSkeleton extends StatelessWidget {
  const NewCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 20, width: 200),
                    Skeleton(height: 20, width: 150),
                  ],
                ),
                const Skeleton(height: 50, width: 180),
              ],
            ),
            const SizedBox(height: 10),
            const Skeleton(height: 100, width: 450),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skeleton(height: 24, width: 180),
            Row(
              children: const [
                Skeleton(height: 140, width: 300),
                Skeleton(height: 140, width: 88),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skeleton(height: 24, width: 180),
            Row(
              children: const [
                Skeleton(height: 190, width: 320),
                Skeleton(height: 190, width: 68),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  final double? height, width;

  const Skeleton({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
