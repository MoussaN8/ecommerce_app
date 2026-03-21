import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract interface class ProfilPictureRemoteDataSource {
  Future<String> uploadProfilPicture({
    required String uid,
    required File image,
  });

  Future<void> updateProfilPicture({required String uid, required String url});
  Future<void> removeProfilPicture({required String uid});
}

class ProfilPictureRemoteDataSourceImpl
    implements ProfilPictureRemoteDataSource {
  final FirebaseFirestore firestore;

  // Paramètres Cloudinary
  final String cloudName = "dnlkucykk";
  final String uploadPreset = "flutter_unsigned";

  ProfilPictureRemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> uploadProfilPicture({
    required String uid,
    required File image,
  }) async {
    try {
      print("LOG: Début upload Cloudinary pour $uid"); // Debug
      final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      );

      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
        ..fields['public_id'] = uid
        ..fields['folder'] = 'profiles_images'
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      // On ajoute un timeout de 15 secondes pour ne pas freezer l'app
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );

      print("LOG: Réponse reçue du serveur, lecture du flux...");
      final response = await http.Response.fromStream(streamedResponse);

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("LOG: Upload réussi ! URL: ${jsonData['secure_url']}");
        return jsonData['secure_url'];
      } else {
        // Si Cloudinary refuse, on extrait le message d'erreur précis
        final errorMsg = jsonData['error']?['message'] ?? "Erreur inconnue";
        print("LOG: Erreur Cloudinary: $errorMsg");
        throw Exception(errorMsg);
      }
    } on SocketException {
      print("LOG: Erreur de connexion (Vérifie ton internet)");
      throw Exception("Pas de connexion internet");
    } catch (e) {
      print("LOG: Exception capturée: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateProfilPicture({
    required String uid,
    required String url, // Cette URL viendra de Cloudinary
  }) async {
    try {
      // On met à jour le champ 'profilePic' dans le document de l'utilisateur
      await firestore.collection('users').doc(uid).set({
        'profilePic': url,
      }, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeProfilPicture({required String uid}) async {
    try {
      // On ne touche pas à l'API Cloudinary (trop risqué sans backend)
      // On se contente de supprimer le champ dans Firestore
      await firestore.collection('users').doc(uid).update({
        'profilePic': FieldValue.delete(),
      });
    } catch (e) {
      rethrow;
    }
  }
}
