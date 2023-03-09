import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:inuny_test/components/animation/fade_animation.dart';
import 'package:inuny_test/services/auth_service.dart';
import 'package:inuny_test/utils/constants.dart';
import 'package:ionicons/ionicons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final AuthService service = AuthService();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          InkWell(
              onTap: () async {
                await service.logOut();
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              child: const Icon(
                Iconsax.logout,
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {},
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  const Icon(Iconsax.notification),
                  Positioned(
                    top: -1.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 13,
                        minHeight: 13,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 10.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(width: 5.0),
                Icon(Iconsax.search_normal, size: 16.0),
                SizedBox(width: 5.0),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search..',
                    ),
                  ),
                )
              ],
            ),
          ).fadeInList(0, false),
          const SizedBox(height: 20.0),
          buildCategories(maxHeight),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text(
              'Popular Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          buildPopularCourse(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Text(
              'Popular Skill Tests',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          buildSkillTests(),
        ],
      ),
    );
  }

  buildCategories(maxHeight) {
    return SizedBox(
      height: maxHeight < 800
          ? MediaQuery.of(context).size.height / 6.3
          : MediaQuery.of(context).size.height / 8,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3.5,
        ),
        itemCount: categories.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50.0,
            width: 210.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: colors[index].withOpacity(0.1),
                    ),
                    child: Center(
                      child: Icon(
                        icons[index],
                        color: colors[index],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                maxHeight < 820
                    ? Text(
                        categories[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      )
                    : Text(
                        categories[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            ),
          ).fadeInList(index + 1, false);
        },
      ),
    );
  }

  buildPopularCourse() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: courses.length,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.4),
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(courseIcon[index], size: 40.0),
                          const Spacer(),
                          const Icon(
                            Ionicons.star,
                            color: Colors.amber,
                            size: 15.0,
                          ),
                          const SizedBox(width: 5.0),
                          const Text(
                            '5.0',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        courses[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          const Icon(Ionicons.play, size: 15.0),
                          const SizedBox(width: 3.0),
                          Text(
                            '${Random().nextInt(30)} Sessions',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(
                            Ionicons.caret_up,
                            size: 15.0,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 3.0),
                          const Text(
                            'Beginner',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ).fadeInList(index + 2, false),
          );
        },
      ),
    );
  }

  buildSkillTests() {
    return SizedBox(
      height: 350.0,
      child: ListView.builder(
        itemCount: skillTests.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: colors[index].withOpacity(0.3),
                      child: Icon(
                        skillLogo[index],
                        size: 40.0,
                        color: colors[index],
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          skillTests[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            const Icon(Ionicons.play, size: 15.0),
                            const SizedBox(width: 3.0),
                            Text(
                              '${Random().nextInt(30)} Questions',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
                              Ionicons.person,
                              size: 15.0,
                            ),
                            const SizedBox(width: 3.0),
                            const Text(
                              '5K participants',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ).fadeInList(index + 3, true);
        },
      ),
    );
  }
}
