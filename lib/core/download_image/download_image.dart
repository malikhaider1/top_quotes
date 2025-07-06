import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_quotes/core/scaffold_messenger/scaffold_messenger.dart';

Future<void> downloadAndSaveImageToGallery(String imageUrl) async {
  if (await requestPermission()) {
    try {
      // Download image
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      // Save to gallery
      final result = await FlutterImageGallerySaver.saveFile(file.path).then((result) {
        CustomScaffoldMessenger.showSuccess(message: "Image saved to gallery");
      }).catchError((error) {
        CustomScaffoldMessenger.showError(
            error: "Failed to save image to gallery");
      });
    } catch (e) {
      CustomScaffoldMessenger.showError(error: "Error downloading image: $e");
    }
  }
}

Future<bool> requestPermission() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;
    // Check Android version and request appropriate permissions
    if (sdkInt >= 33) {
      // Android 13+ (API 33+): Use scoped media permissions
      final photosPermission = await Permission.photos.request();
      if (photosPermission.isGranted) return true;

      if (photosPermission.isPermanentlyDenied) {
        await openAppSettings();
      }

      return false;
    } else if (sdkInt >= 30) {
      // Android 11–12 (API 30–32)
      final managePermission = await Permission.manageExternalStorage.request();
      if (managePermission.isGranted) return true;

      if (managePermission.isPermanentlyDenied) {
        await openAppSettings();
      }

      return false;
    } else {
      // Android 10 or below
      final storagePermission = await Permission.storage.request();
      if (storagePermission.isGranted) return true;

      if (storagePermission.isPermanentlyDenied) {
        await openAppSettings();
      }

      return false;
    }
  } else {
    // iOS
    final status = await Permission.photos.request();
    return status.isGranted;
  }
}
