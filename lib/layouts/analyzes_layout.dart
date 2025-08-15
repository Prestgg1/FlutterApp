import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/components/doctor_reservation_card.dart';

class AnalyzesLayout extends StatefulWidget {
  final Widget child;

  const AnalyzesLayout({super.key, required this.child});

  @override
  State<AnalyzesLayout> createState() => _AnalyzesLayoutState();
}

class _AnalyzesLayoutState extends State<AnalyzesLayout> {
  bool isDoctor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Analiz nəticələri',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF226C63),
                  fontSize: 29,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),

              // Yükseklikleri eşitle
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isDoctor = true;
                          });
                          context.go('/analyzes-doctor');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDoctor
                              ? const Color(0xFF226C63)
                              : Colors.transparent,
                          minimumSize: const Size(double.infinity, 50),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Həkimdən gələn rəylər',
                          style: GoogleFonts.poppins(
                            color: isDoctor ? Colors.white : Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isDoctor = false;
                          });
                          context.go('/analyzes-clinic');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDoctor
                              ? Colors.transparent
                              : const Color(0xFF226C63),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Klinikadan gələn nəticələr',
                          style: GoogleFonts.poppins(
                            color: !isDoctor ? Colors.white : Colors.black,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              widget.child,
              /*    GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: MediaQuery.of(context).size.height > 850
                      ? 0.6
                      : 0.67,
                ),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const DoctorReservationCard();
                },
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
