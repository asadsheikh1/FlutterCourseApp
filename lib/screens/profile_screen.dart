import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/auth.dart';
import '/widgets/list_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.2 - 27,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(10),
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
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      width: 5.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        ExactAssetImage('assets/images/profile.jpg'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width * .5,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Asad Sheikh'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                        child: Icon(Icons.verified, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Text(
                  'sheikhasad@gmail.com',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                const ListTileWIdget(
                  icon: Icons.menu_book_rounded,
                  title: 'Name',
                  data: 'Asad Sheikh',
                ),
                const ListTileWIdget(
                  icon: Icons.email_rounded,
                  title: 'Email',
                  data: 'sheikhasad@gmail.com',
                ),
                const ListTileWIdget(
                  icon: Icons.phone,
                  title: 'Phone',
                  data: '+923215820285',
                ),
                const ListTileWIdget(
                  icon: Icons.menu_book_rounded,
                  title: 'Date of Birth',
                  data: '11-12-2001',
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                  child: ListTile(
                    title: Text(
                      'Logout'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                    leading: const Icon(Icons.logout, color: Colors.red),
                    trailing:
                        const Icon(Icons.arrow_forward_ios, color: Colors.red),
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
