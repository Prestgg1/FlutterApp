import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:safatapp/services/api.dart';

class OtpInputSection extends StatefulWidget {
  const OtpInputSection({super.key, required this.email});

  final String email;

  @override
  State<OtpInputSection> createState() => _OtpInputSectionState();
}

class _OtpInputSectionState extends State<OtpInputSection> {
  final List<TextEditingController> _otpControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  bool isLoading = false;

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> submitForm() async {
    print("Form uğurla göndərildi");
    setState(() {
      isLoading = true;
    });
    try {
      final api = ApiService().api;
      final response = await api.getAuthApi().checkOtpApiAuthCheckOtpPost(
        checkOtpRequest: backend.CheckOtpRequest(
          (b) => b
            ..email = widget.email
            ..otp = _otpControllers.map((c) => c.text).join(),
        ),
      );
      print(response);
      final message = response.data?.message ?? "İşlem tamamlandı";
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Düzgün kod girildi")));
        context.push(
          "/reset-password/${widget.email}/${_otpControllers.map((c) => c.text).join()}",
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Otp kod yanlışdır")));
      }
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Otp kod yanlışdır")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // OTP inputları
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return SizedBox(
              width: 51,
              height: 51,
              child: TextField(
                controller: _otpControllers[index],
                textAlign: TextAlign.center,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < 4) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                    }
                  } else {
                    if (index > 0) {
                      FocusScope.of(context).previousFocus();
                    }
                  }
                },
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
                  ),
                ),
                style: GoogleFonts.poppins(fontSize: 24, color: Colors.black),
              ),
            );
          }),
        ),

        const SizedBox(height: 40),

        // Buton
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF226C63),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              submitForm();
            },
            child: Text(
              'Kodu doğrulayın',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Resend email metni
        Center(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                color: const Color(0xFF989898),
                fontSize: 14,
              ),
              children: [
                const TextSpan(text: 'Haven’t got the email yet? '),
                TextSpan(
                  text: 'Resend email',
                  style: const TextStyle(
                    color: Color(0xFF648DDB),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Buraya tekrar gönderme işlemi yazılabilir
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email yenidən göndərildi"),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
