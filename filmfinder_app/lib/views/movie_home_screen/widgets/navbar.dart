import 'package:filmfinder_app/utils/coloors.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final int newIndex = 0;

  void tabChosen(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      decoration: const BoxDecoration(
        color: Coolors.kNavBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            backgroundColor: Coolors.kNavBarColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Coolors.kNavBarIconColor,
            currentIndex: value,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: tabChosen,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.play_circle_filled,
                ),
                label: 'Watch',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_media_outlined),
                label: 'Media',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.table_rows_sharp),
                label: 'More',
              ),
            ],
          );
        },
      ),
    );
  }
}
