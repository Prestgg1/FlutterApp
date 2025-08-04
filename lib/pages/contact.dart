import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const [
              SizedBox(height: 60),
              Text(
                'Rezervasyon üçün\nəlaqə saxlayın',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ContactForm(), // Stateful form
              SizedBox(height: 40),
              ContactInfo(), // Mərkəzləşdirilmiş statik info
            ],
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  InputDecoration _inputDecoration(BuildContext context, String hint) {
    final color = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: color.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Bura göndərmə loqikası gələcək
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Form uğurla göndərildi')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: _inputDecoration(context, "Ad"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ad boş ola bilməz';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: phoneController,
            decoration: _inputDecoration(context, "Telefon"),
            keyboardType: TextInputType.phone,

            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Telefon boş ola bilməz';
              } else if (value.length < 9) {
                return 'Telefon nömrəsi düzgün deyil';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: emailController,
            decoration: _inputDecoration(context, "Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email boş ola bilməz';
              } else if (!value.contains('@')) {
                return 'Email düzgün deyil';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: messageController,
            maxLines: 4,
            decoration: _inputDecoration(context, "Mesaj"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Mesaj boş ola bilməz';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Təqdim edin",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, color: color.primary),
            const SizedBox(width: 8),
            const Text("(123) 456-7890", textAlign: TextAlign.center),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email, color: color.primary),
            const SizedBox(width: 8),
            const Text("shafatapp@health.care", textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}
