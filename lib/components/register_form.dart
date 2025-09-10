import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';
import 'package:toastification/toastification.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String name = '';
  String fincode = '';
  String address = '';
  String street = '';
  String city = '';
  String? gender;
  String region = '';
  String phone = '';
  ({int year, int month, int day})? birthday;
  String email = '';
  String password = '';
  bool rememberMe = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // 🔹 burada UI yenilənəcək
      });

      context.read<AuthBloc>().add(
        AuthRegister(
          name,
          fincode,
          address,
          street,
          region,
          city,
          gender!,
          phone,
          birthday!,
          email,
          password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          toastification.show(
            context: context,
            title: Text('Xoş gəldiniz'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 2),
          );
          context.go('/');
        } else if (state is Unauthenticated && state.error != null) {
          toastification.show(
            context: context,
            title: Text(state.error!),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          );
        }

        setState(() {
          _isLoading = state is AuthInitial || state is Authenticated
              ? false
              : state is Unauthenticated
              ? false
              : _isLoading;
        });
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              label: "Ad",
              hint: "Adınızı daxil edin",
              onChanged: (v) => setState(() => name = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Ad boş ola bilməz" : null,
            ),
            _buildTextField(
              label: "Fincode",
              hint: "Fincode daxil edin",
              onChanged: (v) => setState(() => fincode = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Fincode boş ola bilməz" : null,
            ),
            _buildTextField(
              label: "Ünvan",
              hint: "Ünvan daxil edin",
              onChanged: (v) => setState(() => address = v),
              validator: (v) =>
                  v == null || v.isEmpty ? "Ünvan boş ola bilməz" : null,
            ),
            _buildTextField(
              label: "Küçə",
              hint: "Küçə adını daxil edin",
              onChanged: (v) => setState(() => street = v),
            ),
            _buildTextField(
              label: "Şəhər",
              hint: "Şəhər adını daxil edin",
              onChanged: (v) => setState(() => city = v),
            ),
            const Text(
              "Cinsiyyət",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: gender,
              decoration: _inputDecoration("Cinsiyyət seçin"),
              items: [
                "Kişi",
                "Qadın",
              ].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
              onChanged: (v) => setState(() => gender = v),
              validator: (v) => v == null ? "Cinsiyyət seçilməyib" : null,
            ),

            const SizedBox(height: 20),
            _buildTextField(
              label: "Telefon",
              hint: "+994 50 123 45 67",
              keyboardType: TextInputType.phone,
              onChanged: (v) => setState(() => phone = v),
            ),
            _buildDatePickerField(label: "Doğum tarixi"),
            _buildTextField(
              label: "Region",
              hint: "Region daxil edin",
              onChanged: (v) => setState(() => region = v),
            ),
            _buildTextField(
              label: "Email",
              hint: "Example@gmail.com",
              onChanged: (v) => setState(() => email = v),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email boş ola bilməz';
                if (!v.contains('@')) return 'Email düzgün deyil';
                return null;
              },
            ),
            _buildTextField(
              label: "Şifrə",
              hint: "Ən azı 8 simvol",
              obscure: true,
              onChanged: (v) => setState(() => password = v),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Şifrə boş ola bilməz';
                if (v.length < 8) return 'Şifrə ən azı 8 simvol olmalıdır';
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) =>
                            setState(() => rememberMe = value ?? false),
                      ),
                      const Text('Yadda saxla'),
                    ],
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Şifrəni unutmusunuz?',
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Qeydiyyatdan keç"),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.withAlpha(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.transparent),
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

  Widget _buildDatePickerField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000, 1, 1),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              setState(() {
                birthday = (
                  year: picked.year,
                  month: picked.month,
                  day: picked.day,
                );
              });
            }
          },
          child: InputDecorator(
            decoration: _inputDecoration("Doğum tarixi seçin"),
            child: Text(
              birthday != null
                  ? "${birthday!.year}-${birthday!.month}-${birthday!.day}"
                  : "Seçilməyib",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextFormField(
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: _inputDecoration(hint),
          validator: validator,
          onChanged: onChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
