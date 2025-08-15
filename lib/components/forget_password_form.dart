import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safatapp/services/api.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _onSubmit() async {
    final email = _emailController.text.trim();

    setState(() {
      _isEmailValid = _validateEmail(email);
    });

    if (!_isEmailValid) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final api = ApiService().api;
      final response = await api
          .getAuthApi()
          .forgotPasswordApiAuthForgotPasswordPost(email: email);

      final message = response.data?.message ?? "İşlem tamamlandı";

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        context.push("/otp/$email");
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Hesab tapılmadı")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Hesab tapılmadı")));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: GoogleFonts.poppins(
            color: const Color(0xFF2A2A2A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Email input
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _isEmailValid ? const Color(0xFFE1E1E1) : Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email daxil edin',
                hintStyle: const TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 14,
                ),
                errorText: _isEmailValid ? null : 'Düzgün email daxil edin',
                errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                if (!_isEmailValid && _validateEmail(value)) {
                  setState(() => _isEmailValid = true);
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Devam et butonu
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
            onPressed: _isLoading ? null : _onSubmit,
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Dəvam et',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
