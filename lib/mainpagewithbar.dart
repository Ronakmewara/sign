import 'package:flutter/material.dart';
import 'package:signup_page/homepage.dart';
import 'package:signup_page/profilepage.dart';
import 'package:signup_page/settingpage.dart';
import 'package:signup_page/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin<MainPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final List<String> pageTitles = ['Home', 'Profile', 'Setting'];

    const List<Widget> pages = [Homepage(), ProfilePage(), SettingPage()];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            pageTitles[selectedIndex],
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontSize: 25),
          ),
        ),
        backgroundColor: primaryColor,
      ),
     body:  Center(
       child: pages.elementAt(selectedIndex),
     ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },

      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
