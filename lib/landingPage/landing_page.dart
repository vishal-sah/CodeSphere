import 'package:codesphere/auth/login_page.dart';
import 'package:codesphere/dashboard/dashboard.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/landingPage/about_page.dart';
import 'package:codesphere/landingPage/faqPage.dart';
import 'package:codesphere/widgets/theme_button.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final int initialPage;
  const LandingPage({super.key, required this.initialPage});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedPage = 0;
  int _hoveredTab = 0;
  List<Widget> pages = [
    const AboutPage(),
    const Text('2'),
    const FAQsPage(),
  ];
  final AuthServices auth = AuthServices();
  bool isUser = false;

  void _selectPage(int pageIndex) {
    setState(() {
      _selectedPage = pageIndex;
    });
  }

  void _setHoveredTab(int tabIndex) {
    setState(() {
      _hoveredTab = tabIndex;
    });
  }

  @override
  void initState() {
    if (auth.getCurentUser() != null) {
      isUser = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width <= 600;
    bool isDarkTheme = false;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingPage(initialPage: 0)));
              },
              child: const Row(
                children: [
                  // Image.asset(
                  //   'assets/images/abc.png',
                  //   height: 30,
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'CodeSphere',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            if (!isSmallScreen)
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTabItem('About', 0),
                    buildTabItem('Hackathons', 1),
                    buildTabItem('FAQs', 2),
                  ],
                ),
              ),
            Row(
              children: [
                if (isSmallScreen)
                  PopupMenuButton<int>(
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 0,
                          child: Text('About'),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Hackathons'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('FAQs'),
                        ),
                        const PopupMenuItem(
                          value: 3,
                          child: Text('Go to Dashboard'),
                        ),
                      ];
                    },
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      if (value == 3) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashBoard(),
                          ),
                        );
                      } else {
                        _selectPage(value);
                      }
                    },
                  ),
                const ThemeToggleButton(),
                isUser
                    ? MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()));
                        },
                        child: const Text('Go to Dashboard'),
                      )
                    : MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailPasswordLoginPage()));
                        },
                        child: const Text('SignIn'),
                      )
              ],
            ),
          ],
        ),
      ),
      body: pages[_selectedPage],
    );
  }

  Widget buildTabItem(String title, int index) {
    bool isHovered = _hoveredTab == index;

    return MouseRegion(
      onEnter: (_) => _setHoveredTab(index),
      onExit: (_) => _setHoveredTab(-1),
      child: InkWell(
        onTap: () => _selectPage(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: _selectedPage == index
              ? Colors.blue.shade700
              : (isHovered ? Colors.blue.shade100 : Colors.transparent),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _selectedPage == index ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
