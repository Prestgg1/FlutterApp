import 'dart:convert';
import 'package:http/http.dart' as http;

class FileUploadService {
  final String cloudinaryUrl =
      "https://api.cloudinary.com/v1_1/djfeqtwjx/image/upload";
  final String uploadPreset = "learnteach"; // Cloudinary preset

  Future<String?> uploadFile(String filePath) async {
    try {
      final request = http.MultipartRequest("POST", Uri.parse(cloudinaryUrl));
      request.files.add(await http.MultipartFile.fromPath("file", filePath));
      request.fields["upload_preset"] = uploadPreset;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["secure_url"];
      } else {
        print("❌ Upload error: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Exception during upload: $e");
      return null;
    }
  }
}
