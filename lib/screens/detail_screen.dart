import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:first_flutter/globals.dart';
import 'package:first_flutter/models/ayat.dart';
import 'package:first_flutter/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<ListSurah> _getDetailSurah() async {
    var data = await Dio().get("https://equran.id/api/surat/$noSurat");
    return ListSurah.fromJson(json.decode(data.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListSurah>(
        future: _getDetailSurah(),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: background,
            );
          }
          ListSurah surah = snapshot.data!;
          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurat == 1 ? 1 : 0))),
                  itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          );
        });
  }

  Widget _ayatItem({required Ayat ayat}) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: secondary_purple,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), color: purple),
                    child: Center(
                        child: Text(
                      "   ${ayat.nomor}   ",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
                  ),
                  Spacer(),
                  IconButton(
                      iconSize: 24,
                      onPressed: () => {},
                      icon: SvgPicture.asset('assets/svg/share.svg')),
                  IconButton(
                      iconSize: 24,
                      onPressed: () => {},
                      icon: SvgPicture.asset('assets/svg/play.svg')),
                  IconButton(
                      iconSize: 24,
                      onPressed: () => {},
                      icon: SvgPicture.asset('assets/svg/bookmark.svg'))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            ayat.ar,
            style: GoogleFonts.amiri(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            ayat.idn,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w400, color: text),
            textAlign: TextAlign.start,
          ),
        ],
      );

  Widget _details({required ListSurah surah}) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Stack(children: [
          Container(
            height: 257,
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
              child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    'assets/svg/quran_img.svg',
                    width: 324 - 55,
                  ))),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  surah.namaLatin,
                  style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  surah.arti,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Divider(
                  color: Colors.white.withOpacity(.35),
                  thickness: 2,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      surah.jumlahAyat.toString(),
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SvgPicture.asset('assets/svg/bismillah.svg'),
              ],
            ),
          )
        ]),
      );

  AppBar _appBar({required BuildContext context, required ListSurah surah}) =>
      AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
              onPressed: (() => Navigator.of(context).pop()),
              icon: SvgPicture.asset('assets/svg/back.svg')),
          const SizedBox(
            width: 24,
          ),
          Text(
            surah.namaLatin,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset('assets/svg/search_icon.svg')),
        ]),
      );
}
