import 'package:first_flutter/globals.dart';
import 'package:first_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, //Keseluruhan Rata Center
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Per Componen Rata Center
                children: [
                  Text('Quran App',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Learn Quran and \n Recite once everyday',
                    style: GoogleFonts.poppins(
                      color: text,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Stack(clipBehavior: Clip.none, children: [
                    Container(
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF672CBC)),
                        child: SvgPicture.asset('assets/svg/splash_img.svg')),
                    Positioned(
                      left: 0,
                      bottom: -24,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 18),
                            decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Get Started',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: background),
                            ),
                          ),
                        ),
                      ),
                    )
                  ])
                ]),
          ),
        ),
      ),
    );
  }
}
