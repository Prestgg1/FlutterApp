import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:dio/dio.dart';
import 'package:safatapp/services/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/appointment/appointment_bloc.dart';
import 'custom_widgets.dart';

class AppointmentFormFields extends StatefulWidget {
  const AppointmentFormFields({super.key, required this.modelId});

  final int modelId;

  @override
  State<AppointmentFormFields> createState() => _AppointmentFormFieldsState();
}

class _AppointmentFormFieldsState extends State<AppointmentFormFields> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _finController = TextEditingController();
  final _complaintController = TextEditingController();
  final api = ApiService().api;

  bool isLoading = false; // 🔹 Yüklənmə statusu

  Future<void> submitForm() async {
    final selectedDate = context.read<AppointmentBloc>().state.selectedDate;
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true); // 🔹 Start loading
      try {
        final response = await api
            .getAppointmentApi()
            .createAppointmentApiAppointmentModelTypeModelIdPost(
              modelType: backend.ModelType.doctor,
              modelId: widget.modelId,
              appointmentCreate: backend.AppointmentCreate(
                (b) => b
                  ..fullName = _nameController.text
                  ..phone = _phoneController.text
                  ..date = selectedDate
                  ..finCode = _finController.text
                  ..complaint = _complaintController.text,
              ),
            );
        if (response.statusCode == 200) {
          context.go('/successfull-rezervation');
        }
      } catch (e) {
        if (e is DioException) {
          final errorData = e.response?.data;
          final message = (errorData is Map && errorData['detail'] != null)
              ? errorData['detail']
              : 'Server xətası baş verdi';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Naməlum xəta: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) setState(() => isLoading = false); // 🔹 Stop loading
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _finController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Ad Soyad
          const CustomLabel(text: 'Ad Soyad'),
          CustomInput(
            controller: _nameController,
            hint: 'Ad soyad',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Ad soyad daxil edin";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Mobil nömrə
          const CustomLabel(text: 'Mobil nömrə'),
          CustomInput(
            controller: _phoneController,
            hint: 'Mobil nömrə',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mobil nömrə daxil edin";
              }
              if (value.length < 10) {
                return "Mobil nömrə ən az 10 rəqəm olmalıdır";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Fin kod
          const CustomLabel(text: 'Fin kod'),
          CustomInput(
            controller: _finController,
            hint: 'Fin kod',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Fin kod daxil edin";
              }
              if (value.length != 7) {
                return "Fin kod 7 simvol olmalıdır";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Şikayət
          const CustomLabel(text: 'Şikayətinizi qeyd edin'),
          CustomInput(
            controller: _complaintController,
            hint: 'Şikayətinizi qeyd edin',
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Şikayət yazmalısınız";
              }
              return null;
            },
          ),
          const SizedBox(height: 50),

          // Button
          SizedBox(
            width: 183,
            height: 42,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF226C63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        submitForm();
                      }
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFDEE9E8),
                        ),
                      ),
                    )
                  : Text(
                      'Dəvam et',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFDEE9E8),
                        fontSize: 15,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
