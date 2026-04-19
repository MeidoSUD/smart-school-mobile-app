import 'dart:io';

import 'package:geniuses_school/data/models/user_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final UserModel? user;
  final File? pickedImage;
  final Function(ImageSource) onPickImage;

  const ProfileImagePicker({
    super.key,
    required this.user,
    this.pickedImage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildProfileImage(),
        Positioned(
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: Text(l10n.gallery),
                      onTap: () {
                        Navigator.pop(context);
                        onPickImage(ImageSource.gallery);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: Text(l10n.camera),
                      onTap: () {
                        Navigator.pop(context);
                        onPickImage(ImageSource.camera);
                      },
                    ),
                  ],
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: theme.primaryColor,
              child: const Icon(Icons.edit, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    if (pickedImage != null) {
      return CircleAvatar(radius: 50, backgroundImage: FileImage(pickedImage!));
    }

    if (user?.profile?.profile_photo != null) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user!.profile!.profile_photo!),
      );
    }

    return const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 40));
  }
}
