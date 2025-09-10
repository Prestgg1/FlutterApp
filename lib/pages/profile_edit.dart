import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:safatapp/services/api.dart';
import 'package:openapi/openapi.dart' as backend;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool isLoading = false;
  XFile? _pickedImage;
  String? _uploadedImageUrl;
  final ImagePicker _picker = ImagePicker();
  backend.Profile? user;
  late backend.UserBase user_state;

  final api = ApiService().api;

  // Controllers
  final _phoneController = TextEditingController();

  final _cityController = TextEditingController();
  final _regionController = TextEditingController();
  final _streetController = TextEditingController();
  final _addressController = TextEditingController();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated && authState.user != null) {
      user_state = authState.user!;
    }
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    user = ProfileCache.profile;
    if (user != null) {
      _fillControllers();
      return;
    }
    try {
      final response = await api.getUserApi().getProfileApiUserProfileGet();
      setState(() {
        user = response.data;
        _fillControllers();
      });
    } catch (e) {
      debugPrint("Profil məlumatları alınmadı: $e");
    }
  }

  void _fillControllers() {
    _phoneController.text = user?.details.phone ?? "";
    _cityController.text = user?.details.city ?? "";
    _regionController.text = user?.details.region ?? "";
    _streetController.text = user?.details.street ?? "";
    _addressController.text = user?.details.address ?? "";
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _cityController.dispose();
    _regionController.dispose();
    _streetController.dispose();
    _addressController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    try {
      // Qaləridən seç
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        _pickedImage = image;
      });

      // Cloudinary yükləmə
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/djfeqtwjx/image/upload'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      request.fields['upload_preset'] = 'learnteach'; // Cloudinary preset

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _uploadedImageUrl = data['secure_url'];
        });
        debugPrint("Uploaded image URL: $_uploadedImageUrl");
      } else {
        debugPrint("Upload error: ${response.body}");
      }
    } catch (e) {
      debugPrint("Image pick/upload error: $e");
    }
  }

  Future<void> _updateProfile() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final oldPass = _oldPasswordController.text;
    final newPass = _newPasswordController.text;

    // form yoxlama
    if (_phoneController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _regionController.text.isEmpty ||
        _streetController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Zəhmət olmasa bütün xanaları doldurun")),
      );
      return;
    }

    // burada API update logic yazılacaq
    debugPrint("Phone: ${_phoneController.text}");
    debugPrint("City: ${_cityController.text}");
    debugPrint("Region: ${_regionController.text}");
    debugPrint("Street: ${_streetController.text}");
    debugPrint("Address: ${_addressController.text}");
    debugPrint("OldPass: $oldPass, NewPass: $newPass");
    try {
      final response = await api
          .getUserApi()
          .updateUserProfileApiUserProfilePut(
            fastApiProjectRoutersUserUserUpdateUserRequest:
                backend.FastApiProjectRoutersUserUserUpdateUserRequest(
                  (b) => b
                    ..phone = _phoneController.text
                    ..city = _cityController.text
                    ..region = _regionController.text
                    ..street = _streetController.text
                    ..address = _addressController.text
                    ..image = _uploadedImageUrl ?? user?.user.image ?? ''
                    ..password = oldPass
                    ..newPassword = newPass,
                ),
          );

      if (response.statusCode == 200) {
        if (_uploadedImageUrl != null) {
          context.read<AuthBloc>().add(AuthUpdateUserImage(_uploadedImageUrl!));
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil uğurla yeniləndi")),
        );
        context.pop();
      } else {
        debugPrint("Xəta: ${response.data?.email}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xəta baş verdi: ${response.statusCode}")),
        );
      }
    } catch (e) {
      debugPrint("Xəta: $e");
    }
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profil uğurla yeniləndi")));

    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF248C76)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Redaktə"),
        backgroundColor: const Color(0xFF248C76),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),

            // Profil şəkli
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                    child: _pickedImage != null
                        ? Image.file(
                            File(_pickedImage!.path),
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            user?.user.image ?? '',
                            width: 130,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickAndUploadImage, // 🔹 şəkil seçmə funksiyası
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF248C76),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            _buildInput("Telefon", _phoneController),
            const SizedBox(height: 20),
            _buildInput("Şəhər", _cityController),
            const SizedBox(height: 20),
            _buildInput("Rayon", _regionController),
            const SizedBox(height: 20),
            _buildInput("Küçə", _streetController),
            const SizedBox(height: 20),
            _buildInput("Ünvan", _addressController),

            const SizedBox(height: 30),

            // Köhnə şifrə
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Köhnə şifrə",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Yeni şifrə
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Yeni şifrə",
                labelStyle: GoogleFonts.poppins(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isLoading ? null : _updateProfile, // loadingdə disable
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF248C76),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      "Təsdiqlə",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
