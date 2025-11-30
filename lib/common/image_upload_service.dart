import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class ImageUploadService {
  static final ImageUploadService _instance = ImageUploadService._internal();
  factory ImageUploadService() => _instance;
  ImageUploadService._internal();

  final Dio _dio = Dio();

  // Configuration
  String imgbbApiKey = '85719aefcab7c40a7eaed3b06784898a'; 
  
  // WebDAV Config
  String webdavUrl = '';
  String webdavUsername = '';
  String webdavPassword = '';
  String webdavPublicUrl = '';
  String webdavUploadPath = '/images';

  Future<String?> uploadImage(File file, {String method = 'imgbb'}) async {
    if (method == 'imgbb') {
      return _uploadToImgBB(file);
    } else if (method == 'webdav') {
      return _uploadToWebDAV(file);
    }
    throw Exception('Unknown upload method: $method');
  }

  Future<String?> _uploadToImgBB(File file) async {
    try {
      if (imgbbApiKey.isEmpty) {
        throw Exception('ImgBB API Key is not configured. Please configure it in ImageUploadService.');
      }
      
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(file.path),
        'key': imgbbApiKey,
      });

      final response = await _dio.post(
        'https://api.imgbb.com/1/upload',
        data: formData,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['url'];
      }
      throw Exception('ImgBB Upload Failed: ${response.data}');
    } catch (e) {
      print('ImgBB Upload Error: $e');
      rethrow;
    }
  }

  Future<String?> _uploadToWebDAV(File file) async {
    try {
      if (webdavUrl.isEmpty || webdavUsername.isEmpty || webdavPassword.isEmpty) {
        throw Exception('WebDAV configuration is incomplete.');
      }

      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}';
      final uploadUrl = '$webdavUrl$webdavUploadPath/$fileName';
      
      final bytes = await file.readAsBytes();
      
      final response = await _dio.put(
        uploadUrl,
        data: Stream.fromIterable([bytes]),
        options: Options(
          headers: {
            HttpHeaders.contentLengthHeader: bytes.length,
            HttpHeaders.authorizationHeader: 'Basic ' + 
                base64Encode(utf8.encode('$webdavUsername:$webdavPassword')),
          },
        ),
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return '$webdavPublicUrl/$fileName';
      }
      throw Exception('WebDAV Upload Failed: ${response.statusCode}');
    } catch (e) {
      print('WebDAV Upload Error: $e');
      rethrow;
    }
  }
  
  String base64Encode(List<int> bytes) {
    return  base64.encode(bytes);
  }
}
