import 'package:codesphere/auth/forgot_password.dart';
import 'package:codesphere/auth/login_page.dart';
import 'package:codesphere/dashboard/hackathon_page.dart';
import 'package:codesphere/dashboard/projects_page.dart';
import 'package:codesphere/firebase/firebase_functions.dart';
import 'package:codesphere/landingPage/landing_page.dart';
import 'package:codesphere/screens/create_hackathon_page.dart';
import 'package:codesphere/screens/edit_profile.dart';
import 'package:codesphere/screens/organise_hackathon.dart';
import 'package:codesphere/screens/portfolio_page.dart';
import 'package:codesphere/widgets/theme_button.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedPage = 1;
  int _hoveredTab = 0;
  bool _isDarkTheme = false;
  List<Widget> pages = [
    const ProfileForm(),
    HackathonPage(),
    ProjectPage(),
  ];
  final AuthServices auth = AuthServices();

  String? currentUserId;
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
      currentUserId = auth.getCurentUser()!.uid;
      isUser = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('CodeSphere'),
            if (!isSmallScreen)
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTabItem('Profile', 0),
                    buildTabItem('Hackathons', 1),
                    buildTabItem('Projects', 2),
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
                          child: Text('Profile'),
                        ),
                        const PopupMenuItem(
                          value: 1,
                          child: Text('Hackathons'),
                        ),
                        const PopupMenuItem(
                          value: 2,
                          child: Text('Projects'),
                        ),
                      ];
                    },
                    position: PopupMenuPosition.under,
                    onSelected: (value) {
                      _selectPage(value);
                    },
                  ),
                const ThemeToggleButton(),
                isUser
                    ? PopupMenuButton<int>(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 1,
                              child: Text('My Portfolio'),
                            ),
                            const PopupMenuItem(
                              value: 2,
                              child: Text('Change Password'),
                            ),
                            const PopupMenuItem(
                              value: 3,
                              child: Text('Organize a Hackathon'),
                            ),
                            const PopupMenuItem(
                              value: 4,
                              child: Text('Logout'),
                            ),
                          ];
                        },
                        position: PopupMenuPosition.under,
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Portfolio(
                                  userId: auth.getCurentUser()!.uid,
                                ),
                              ),
                            );
                          } else if (value == 2) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          } else if (value == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HackathonOrganizePage(),
                              ),
                            );
                          }
                          if (value == 4) {
                            auth.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LandingPage(initialPage: 0),
                              ),
                            );
                          }
                        },
                        child: FutureBuilder(
                          future: auth.getUserTile(uid: currentUserId!),
                          builder: (context, snapshot) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('user'),
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/abc.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmailPasswordLoginPage(),
                            ),
                          );
                        },
                        child: const Text('SignIn'),
                      ),
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
