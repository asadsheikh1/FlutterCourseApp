import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/auth.dart';
import '/screens/home_screen.dart';
import '/screens/enrolled_screen.dart';
import '/screens/favourites_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/add_course_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const routeName = '/tabs';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Home',
    },
    {
      'page': const EnrolledScreen(),
      'title': 'Enrolled',
    },
    {
      'page': const FavouritesScreen(),
      'title': 'Favourites',
    },
    {
      'page': const ProfileScreen(),
      'title': 'Profile',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        elevation: 4,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text('Asad Sheikh'),
              automaticallyImplyLeading: false,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Course'),
              onTap: () {
                Navigator.of(context).pushNamed(AddCourseScreen.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            onTap: _selectPage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey.shade300,
            showUnselectedLabels: true,
            currentIndex: _selectedPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 40),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.app_registration_rounded, size: 40),
                label: 'Enrolled',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 40),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 40),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
