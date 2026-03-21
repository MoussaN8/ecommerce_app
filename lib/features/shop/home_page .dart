import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/category/Presentation/bloc/category_bloc.dart';
import 'package:ecommerce_app/features/category/Presentation/widgets/categoryListWidget.dart';
import 'package:ecommerce_app/features/profilPicture/presentation/cubit/profil_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Optimise l'URL Cloudinary pour le mobile (redimensionnement et compression)
  String _getOptimizedUrl(String url) {
    if (!url.contains('cloudinary.com')) return url;
    // On demande une image de 200x200, centrée sur le visage, format et qualité auto
    return url.replaceFirst(
      '/upload/',
      '/upload/w_200,h_200,c_fill,g_face,f_auto,q_auto/',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon App"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: BlocConsumer<ProfilImageCubit, ProfilImageState>(
            listener: (context, state) {
              if (state is ProfilImageError) {
                showSnackBar(context, state.message);
              }
              if (state is ProfilImageSuccess) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              // Gestion de l'état de chargement (upload en cours)
              if (state is ProfilImageLoading) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              // Récupération de l'URL selon l'état
              String? imageUrl;
              if (state is ProfilImageLoaded) {
                imageUrl = state.profilImage;
              }

              return GestureDetector(
                onTap: () => _showProfilOptions(context, imageUrl != null),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[200],
                  child: imageUrl != null && imageUrl.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                            key: ValueKey(imageUrl),

                            imageUrl: _getOptimizedUrl(imageUrl),
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 1),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error_outline, size: 20),
                          ),
                        )
                      : const Icon(Icons.person, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Rechercher",
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 30),
            CategoryListwidget(),
          ],
        ),
      ),
    );
  }

  void _showProfilOptions(BuildContext context, bool hasProfileImage) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              // Option : Changer / Ajouter la photo
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  hasProfileImage ? "Changer la photo" : "Ajouter une photo",
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  final authState = context.read<AuthBloc>().state;
                  if (authState is AuthAuthenticated) {
                    context.read<ProfilImageCubit>().pickAndUploadImage(
                      authState.user.uid,
                    );
                  }
                },
              ),
              // Option : Supprimer la photo (visible uniquement si une photo existe)
              if (hasProfileImage)
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    "Supprimer la photo",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    final authState = context.read<AuthBloc>().state;
                    if (authState is AuthAuthenticated) {
                      context.read<ProfilImageCubit>().removeProfilImage(
                        uid: authState.user.uid,
                      );
                    }
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
