import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppointmentPage extends StatelessWidget {
  const DoctorAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: 972,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 339,
              top: 16,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Fc109a988-2a1c-466e-8ec6-c4a98146c889.png',
                width: 21,
                height: 21,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 366,
              top: 19,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Ff47e387c-e375-4fdd-9f94-d1df3ce4cfaf.png',
                width: 21,
                height: 16,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 393,
              top: 16,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F544e6748-a77f-4adc-831e-b489806f719e.png',
                width: 21,
                height: 21,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 125,
              top: 67,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F1740095f-0737-40b3-b748-353a2010c3f0.png',
                width: 180,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 215,
              top: 71,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F0d022895-4f8d-40f2-b913-117fd0a6ff82.png',
                width: 85,
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 164,
              top: 71,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F93cfce23-5e65-4eb0-87f6-a1704ea66b09.png',
                width: 54,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 139,
              top: 70,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Fbfed83f3-eb45-4cdc-bd41-c77e777a76c7.png',
                width: 23,
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 132,
              top: 79,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F7d69ef79-a896-488c-98ad-3be0aaaaed85.png',
                width: 4,
                height: 11,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 129,
              top: 83,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F385afaec-2869-41c4-8ec0-4d8418af25c7.png',
                width: 10,
                height: 4,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 24,
              top: 80,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F7a95d4e1-db4a-4227-814b-2e3448b7adbc.png',
                width: 8,
                height: 16,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              left: 27,
              top: 504,
              child: Container(
                width: 375,
                height: 409,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F000000),
                      spreadRadius: 0,
                      offset: Offset.zero,
                      blurRadius: 25,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 46,
              top: 682,
              child: Text(
                'Xəbərdarlıq et',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              left: 47,
              top: 729,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 744,
              child: Text(
                '30\nMinit',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 116,
              top: 729,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 131,
              top: 744,
              child: Text(
                '40\nMinit',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 185,
              top: 729,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9EBE7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              left: 198,
              top: 742,
              child: Text(
                '25\nMinit',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Rubik',
                  color: const Color(0xFF226C63),
                  fontSize: 14,
                ),
              ),
            ),
            Positioned(
              left: 254,
              top: 729,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 269,
              top: 744,
              child: Text(
                '10\nMinit',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 323,
              top: 729,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 338,
              top: 743,
              child: Text(
                '35\nMinit',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 46,
              top: 538,
              child: Text(
                'Uyğun saatlar',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: const Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              left: 47,
              top: 585,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 60,
              top: 601,
              child: Text(
                '10:00\nAM',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 116,
              top: 585,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 129,
              top: 601,
              child: Text(
                '12:00\nAM',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 185,
              top: 585,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9EBE7),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              left: 195,
              top: 599,
              child: Text(
                '02:00\nPM',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Rubik',
                  color: const Color(0xFF1F8871),
                  fontSize: 14,
                ),
              ),
            ),
            Positioned(
              left: 254,
              top: 585,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 266,
              top: 601,
              child: Text(
                '03:00\nPM',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 323,
              top: 585,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 335,
              top: 601,
              child: Text(
                '04:00\nPM',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Rubik', fontSize: 13),
              ),
            ),
            Positioned(
              left: 47,
              top: 196,
              child: Container(
                width: 335,
                height: 280,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Positioned(
              left: 47,
              top: 196,
              child: Container(
                width: 335,
                height: 52,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Color(0xFF248C76),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
              ),
            ),
            Positioned(
              left: 333,
              top: 217,
              child: SizedBox(
                width: 39,
                height: 11,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F2031ed98-7149-4b1a-a843-31c4e54af2fc.png',
                        width: 39,
                        height: 11,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 57,
              top: 209,
              child: SizedBox(
                width: 115,
                child: Text(
                  'February 2021',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 72,
              top: 258,
              child: Text(
                'Mo      Tu      We      Th      Fr      Sa      Su',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 128,
              top: 299,
              child: Text(
                '1         2         3        4        5        6       ',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 89,
              top: 334,
              child: Text(
                '7        8         9        10       11      12       13       ',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 204,
              top: 364,
              child: Container(
                width: 34,
                height: 34,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: const Color(0x7000A17E),
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
            Positioned(
              left: 75,
              top: 369,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  children: const [
                    TextSpan(text: '14      15        16          '),
                    TextSpan(
                      text: '17',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(text: '       18      19      20       '),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 75,
              top: 404,
              child: Text(
                '21      22       23       24      25      26      27       ',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 75,
              top: 439,
              child: Text(
                '28      29       30',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 43,
              top: 285,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F87b6bcb1-0eff-4e7f-991d-bfc47c4bbe27.png',
                width: 339,
                height: 1,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 22,
              top: 899,
              child: Container(
                width: 385,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF226C63),
                  border: Border.all(color: const Color(0xFF226C63)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 153,
                      top: 12,
                      child: Text(
                        'Dəvam et',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 22,
              top: 108,
              child: SizedBox(
                width: 386,
                height: 44,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 386,
                        height: 44,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              spreadRadius: 0,
                              offset: Offset.zero,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 16,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2F6c1ab4bd-dc6d-462e-a0a5-57018b3b5785.png',
                        width: 13,
                        height: 14,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: 44,
                      top: 15,
                      child: SizedBox(
                        width: 77,
                        height: 17,
                        child: Text(
                          'Axtarış',
                          style: GoogleFonts.getFont(
                            'Rubik',
                            color: const Color(0xFF677294),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 307,
                      top: 15,
                      child: SizedBox(
                        width: 42,
                        height: 16,
                        child: Text(
                          'Filter',
                          style: GoogleFonts.getFont(
                            'Rubik',
                            color: const Color(0xFF677294),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 353,
                      top: 18,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0S4Cv9GzpkFeQFL3zg0b%2Fb80fc0e7-a231-4e1a-8abc-8737aa5031c7.png',
                          width: 14,
                          height: 14,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
