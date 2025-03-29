import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final List<Widget> pages;
  final List<IconData> icons;
  final int currentIndex;

  const NavigationButtons({
    super.key,
    required this.pages,
    required this.icons,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    int nextIndex = (currentIndex + 1) % pages.length;
    int prevIndex = (currentIndex - 1 + pages.length) % pages.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Row(
            children: [
              const Icon(Icons.chevron_left),
              Icon(icons[prevIndex]),
            ],
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => pages[prevIndex]),
            );
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Row(
            children: [
              Icon(icons[nextIndex]),
              const Icon(Icons.chevron_right),
            ],
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => pages[nextIndex]),
            );
          },
        ),
      ],
    );
  }
}
