import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_drawer.dart';
import 'package:true_gym/core/consts.dart';
import 'package:true_gym/core/lists.dart';

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
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        height: 52,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color:
                      const Color.fromARGB(255, 100, 100, 100).withOpacity(0.9),
                  blurRadius: 10,
                  offset: const Offset(0, 12),
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
      ),
    );
  }
}
