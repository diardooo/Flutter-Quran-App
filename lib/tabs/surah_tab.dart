import 'package:first_flutter/globals.dart';
import 'package:first_flutter/models/surah.dart';
import 'package:first_flutter/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<ListSurah>> _getSurahList() async {
    String data = await rootBundle.loadString('assets/data/list_surah.json');
    return SurahFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListSurah>>(
        future: _getSurahList(),
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, listSurah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: Color(0xFF7B80AD).withOpacity(.35),
                  ),
              itemCount: snapshot.data!.length);
        });
  }

  Widget _surahItem(
          {required ListSurah listSurah, required BuildContext context}) =>
      GestureDetector(
        behavior:
            HitTestBehavior.opaque, // Agar bisa di hit di semua area list item
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
              noSurat: listSurah.nomor,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/svg/nomor_surah.svg'),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Center(
                        child: Text(
                      "${listSurah.nomor}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${listSurah.namaLatin}",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        listSurah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFA19CC5),
                          fontSize: 12,
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
                            color: const Color(0xFFA19CC5),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${listSurah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFFA19CC5),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
              Spacer(),
              Text(
                listSurah.nama,
                style: GoogleFonts.amiri(
                    color: purple, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );
}
