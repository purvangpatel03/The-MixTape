import 'package:flutter/material.dart';
import 'package:music_streaming_app/theme/colors.dart';

class MainBottomBar extends StatefulWidget {
  final Function(int) onChanged;
  const MainBottomBar({super.key, required this.onChanged});

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: ThemeColor.white,
          fontWeight: FontWeight.w500
        ),
        unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: ThemeColor.white,
            fontWeight: FontWeight.w500
        ),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          widget.onChanged(index);
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Search',
              icon: Icon(Icons.search_outlined), activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Your Library',
              icon: Icon(Icons.featured_play_list_outlined),
              activeIcon: Icon(Icons.featured_play_list),
          ),
        ],
      ),
    );
  }
}
