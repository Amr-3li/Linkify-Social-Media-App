import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_appbar.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_drawer.dart';
import 'package:true_gym/Features/profile/presentation/view/profile.dart';
import 'package:true_gym/lists.dart';
import 'package:true_gym/views/pages/app_pages/settings.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const HomeDrawer(),
      body: PageView.builder(
          itemCount: pages.length,
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return pages[index];
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        height: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: navigationItems.asMap().entries.map((e) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = e.key;
                    pageController.animateToPage(currentIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  });
                },
                icon: Icon(e.value,
                    color: currentIndex == e.key ? Colors.white : Colors.grey,
                    size: 40));
          }).toList(),
        ),
      ),
    );
  }
}
