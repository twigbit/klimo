import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klimo/common/dialogs/confirmation_dialog.dart';
import 'package:klimo/common/dialogs/permission_dialog.dart';
import 'package:klimo/common/images/storage_image.dart';
import 'package:klimo/components/images/cubit/image_upload_cubit.dart';
import 'package:klimo/utils/localisation.dart';
import 'package:klimo/utils/theme.dart';
import 'package:klimo_datamodels/util.dart';

class ProfileImageComponent extends StatefulWidget {
  final ImageModel? profileImage;
  const ProfileImageComponent({Key? key, this.profileImage}) : super(key: key);

  @override
  State<ProfileImageComponent> createState() => _ProfileImageComponentState();
}

class _ProfileImageComponentState extends State<ProfileImageComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _updateImage(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipOval(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BlocBuilder<ImageUploadCubit, ImageUploadState>(
                    builder: (context, imageUploadState) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              color: Palette.greyLight,
                            ),
                          ),
                          if (imageUploadState is ImageUploadLoading &&
                              imageUploadState.file != null)
                            Positioned.fill(
                              child: Image.file(
                                File(imageUploadState.file!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          else if (widget.profileImage != null)
                            Positioned.fill(
                              child: StorageImage(widget.profileImage!),
                            )
                          else
                            const Center(
                              child: Icon(Icons.person),
                            ),
                          if (imageUploadState is ImageUploadLoading)
                            ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: FloatingActionButton(
                  onPressed: () => _updateImage(context),
                  child: const Icon(Icons.edit, color: Palette.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _updateImage(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext actionContext) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.camera),
                ),
                Text(
                  context.localisation().action_camera,
                  style: context.textTheme().headlineLarge,
                ),
              ],
            ),
            onPressed: () {
              getImage(context, ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.photo),
                ),
                Text(
                  context.localisation().action_gallery,
                  style: context.textTheme().headlineLarge,
                ),
              ],
            ),
            onPressed: () {
              getImage(context, ImageSource.gallery);
            },
          ),
          if (widget.profileImage != null)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              isDefaultAction: false,
              onPressed: () => _deleteImage(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.delete),
                  ),
                  Text(
                    context.localisation().profile_image_delete,
                    style: context.textTheme().headlineLarge,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
    return;
  }

  getImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? file =
          await picker.pickImage(source: source, imageQuality: 80);

      if (file != null) {
        if (!mounted) return;

        context.read<ImageUploadCubit>().uploadImage(file);
        Navigator.pop(context);
      }
    } on PlatformException catch (e) {
      debugPrint(e.code);
      if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
        String message = "";
        if (e.code == 'photo_access_denied') {
          if (!context.mounted) return;
          message = context.localisation().permissions_message_photo;
        }
        if (e.code == 'camera_access_denied') {
          if (!context.mounted) return;
          message = context.localisation().permissions_message_camera;
        }
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) => PermissionDialog(message: message),
        );
      }
    }
  }

  _deleteImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (innerContext) => ConfirmationDialog(
        title: context.localisation().profile_image_delete,
        content: context.localisation().profile_image_delete_message,
        onConfirm: () {
          context.read<ImageUploadCubit>().deleteImage();
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
