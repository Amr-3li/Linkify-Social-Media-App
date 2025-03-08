import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/home_drawer.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/utils/lists.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 1);
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
      backgroundColor: MyColors.backgroundColor,
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
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: bottomNavigationBar(),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      height: 52,
      decoration: const BoxDecoration(
          color: Color.fromARGB(125, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 100, 100, 100),
                blurRadius: 10,
                offset: Offset(0, 12),
                blurStyle: BlurStyle.normal)
          ]),
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
                  size: 35));
        }).toList(),
      ),
    );
  }
}
