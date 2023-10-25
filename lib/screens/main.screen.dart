import 'package:flutter/material.dart';
import 'package:mohoro/bloc/bottom.navbar.bloc.dart';
import 'package:mohoro/common.libs.dart';
import 'package:mohoro/screens/tabs/home.screen.dart';
import 'package:mohoro/screens/tabs/search.screen.dart';
import 'package:mohoro/screens/tabs/sources.screen.dart';
import 'package:mohoro/style/theme.dart' as style;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: $styles.colors.deepPurple,
          centerTitle: true,
          title: const Text(
            "Mohoro",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return const HomeScreen();
              // testScreen("Home");
              case NavBarItem.SOURCES:
                return const SourceScreen();
              case NavBarItem.SEARCH:
                return const SearchScreen();
              default:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0,
                    blurRadius: 10.0,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    label: "Sources",
                    icon: Icon(Icons.grid_view_outlined),
                    activeIcon: Icon(Icons.grid_view_rounded),
                  ),
                  BottomNavigationBarItem(
                    label: "Search",
                    icon: Icon(Icons.search_outlined),
                    activeIcon: Icon(Icons.search),
                  ),
                ],
                backgroundColor: Colors.white,
                iconSize: 20.0,
                unselectedItemColor: $styles.colors.greyMedium,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: $styles.colors.deepPurple,
                currentIndex: snapshot.data!.index,
                onTap: _bottomNavBarBloc.pickItem,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testScreen(String text) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text),
        ],
      ),
    );
  }
}
