import 'package:daelim_market/screen/main/chat/chat_list_screen.dart';
import 'package:daelim_market/screen/main/home/home_screen.dart';
import 'package:daelim_market/screen/main/mypage/mypage_screen.dart';
import 'package:daelim_market/screen/main/search/search_screen.dart';
import 'package:daelim_market/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget?> _widgetOptions = [
    const HomeScreen(),
    const SearchScreen(),
    null,
    const ChatListScreen(),
    const MypageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index != 2) _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex)!,
      ),
      floatingActionButton: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          width: 62.w,
          height: 62.h,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              elevation: 0,
              backgroundColor: dmBlue,
              child: Icon(
                Icons.add,
                size: 30.h,
                color: dmWhite,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: dmGrey, width: 1.w),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightGreen,
            onTap: _onItemTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: dmWhite,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              // 홈
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/icon_home.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/icons/icon_home_fill.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: ''),
              // 검색
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/icon_search.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/icons/icon_search_selected.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: ''),
              // 빈공간
              BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 62.w,
                  ),
                  label: ''),
              // 채팅
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/icon_chat.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/icons/icon_chat_fill.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: ''),
              // 마이페이지
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/icons/icon_mypage.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/icons/icon_mypage_fill.png',
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }
}