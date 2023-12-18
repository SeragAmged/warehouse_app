import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final int index;
  final String title;
  final int currentNavIndex;
  final void Function(int) onTap;
  const NavBarItem({
    super.key,
    required this.index,
    required this.currentNavIndex,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flex: currentNavIndex == index ? 2 : 1,
      child: Container(
        decoration: BoxDecoration(
          color: currentNavIndex == index
              ? const Color.fromRGBO(87, 126, 86, 0.65)
              : Colors.white,
          boxShadow: currentNavIndex == index
              ? [
                  const BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: Color.fromRGBO(88, 129, 87, 0.59),
                    offset: Offset(0, 0),
                    blurRadius: 22,
                    spreadRadius: .0025,
                  ),
                ]
              : null,
        ),
        child: InkWell(
          onTap: () => onTap(index),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: currentNavIndex == index
                      ? Colors.white
                      : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
