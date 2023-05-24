import 'package:first_flutter/globals.dart';
import 'package:first_flutter/screens/splash_screen.dart';
import 'package:first_flutter/tabs/hijb_tab.dart';
import 'package:first_flutter/tabs/page_tab.dart';
import 'package:first_flutter/tabs/para_tab.dart';
import 'package:first_flutter/tabs/surah_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(40),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: secondary_purple,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: GNav(
            backgroundColor: secondary_purple,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: purple,
            padding: EdgeInsets.all(12),
            gap: 8,
            onTabChange: (index) {
              print(index);
              if (index == 0) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
              } else if (index == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ));
              }
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.handshake_rounded,
                text: "Prayer",
              ),
              GButton(
                icon: Icons.bookmark,
                text: "Bookmark",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
      // _bottomNavigationBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      // Kalo di scroll hilang, (with nested scroll view)
                      child: _greeting(),
                    ),
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: background,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      shape: Border(
                          bottom: BorderSide(
                              color: Colors.white.withOpacity(.1), width: 3)),
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        child: _tab(),
                      ),
                    )
                  ],
              body: const TabBarView(
                children: [SurahTab(), ParaTab(), PageTab(), HijbTab()],
              )),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
      unselectedLabelColor: text,
      labelColor: Colors.white,
      indicatorColor: purple,
      indicatorWeight: 3,
      tabs: [
        _tabItem(label: "Surah"),
        _tabItem(label: "Para"),
        _tabItem(label: "Page"),
        _tabItem(label: "Hijb"),
      ],
    );
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column _greeting() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 24,
      ),
      Text(
        "Assalamualaikum",
        style: GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.w500, color: text),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        "Muhammad Lazuardi Adinegara",
        style: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      const SizedBox(
        height: 24,
      ),
      _lastRead()
    ]);
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, .6],
                  colors: [Color(0xFFDF98FA), Color(0xFF9055FF)])),
        ),
        Positioned(
            bottom: 2,  
            right: 0,
            child: SvgPicture.asset('assets/svg/quran_img.svg')),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svg/book.svg'),
                  const SizedBox(width: 8),
                  Text(
                    "Last Read",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Al - Fatihah",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Ayat No. 1",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset('assets/svg/menu_icon.svg')),
          const SizedBox(
            width: 24,
          ),
          Text(
            "Quran App",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset('assets/svg/search_icon.svg')),
        ]),
      );

//   BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         backgroundColor: secondary_purple,
//         items: [
//           _bottomBarItem(icon: "assets/svg/menu1.svg", label: "Quran"),
//           _bottomBarItem(icon: "assets/svg/menu2.svg", label: "Tips"),
//           _bottomBarItem(icon: "assets/svg/menu3.svg", label: "Prayer"),
//           _bottomBarItem(icon: "assets/svg/menu4.svg", label: "Doa"),
//           _bottomBarItem(icon: "assets/svg/menu5.svg", label: "Bookmark"),
//         ],
//       );

//   BottomNavigationBarItem _bottomBarItem(
//           {required String icon, required String label}) =>
//       BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             icon,
//             color: text,
//           ),
//           activeIcon: SvgPicture.asset(
//             icon,
//             color: purple,
//           ),
//           label: label);
}
