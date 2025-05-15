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
  int currentIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
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
        physics: const NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.symmetric(),
      height: 60,
      decoration: const BoxDecoration(
        color: MyColors.appBarColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navigationItems.asMap().entries.map((e) {
          return IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = e.key;
                  pageController.jumpToPage(currentIndex);
                });
              },
              icon: Icon(e.value,
                  color: currentIndex == e.key
                      ? MyColors.iconActiveColor
                      : MyColors.iconNavColor,
                  size: 35));
        }).toList(),
      ),
    );
  }
}
