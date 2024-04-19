import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klimo/components/user/cubit/user_cubit.dart';
import 'package:klimo_datamodels/util.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../../config/firebase.dart';

part 'image_upload_state.dart';

class ImageUploadCubit extends Cubit<ImageUploadState> with ErrorHandling {
  UserCubit userCubit;

  ImageUploadCubit(this.userCubit) : super(ImageUploadInitial());

  uploadImage(XFile file) async {
    if (state is ImageUploadLoading) return;
    emit(ImageUploadLoading(file: file));
    try {
      await _deleteImages();
      if (userCubit.userRef != null) {
        final String userId = userCubit.userRef!.ref.id;

        final Reference storageRef = storage.ref();
        final String modifiedFilePath =
            const Uuid().v4() + extension(file.path);
        final Reference storagePath =
            storageRef.child("users/$userId/public/$modifiedFilePath");

        final TaskSnapshot snapshot =
            await storagePath.putFile(File(file.path));

        final String downloadUrl = await snapshot.ref.getDownloadURL();

        emit(ImageUploadCompleted(
            image: ImageModel((b) => b
              ..downloadUrl = downloadUrl
              ..storagePath = storagePath.fullPath)));
      }
    } on FirebaseException catch (error) {
      debugPrint(error.toString());
      emit(ImageUploadError());

      return null;
    } catch (e) {
      debugPrint(e.toString());
      emit(ImageUploadError());
    }
  }

  _deleteImages() async {
    if (userCubit.userRef != null) {
      final String userId = userCubit.userRef!.ref.id;
      final Reference storageRef = storage.ref();

      for (var file
          in (await storageRef.child("users/$userId/public/").list()).items) {
        try {
          await file.delete();
        } on FirebaseException catch (error) {
          debugPrint(error.toString());
          emit(ImageUploadError());
        } catch (e) {
          debugPrint(e.toString());
          emit(ImageUploadError());
        }
      }
    }
  }

  deleteImage() async {
    emit(const ImageUploadLoading());
    await _deleteImages();
    try {
      await firestore.userCollection
          .userDoc()!
          .update({'profile.image': FieldValue.delete()});
      emit(const ImageUploadCompleted());
    } catch (error) {
      debugPrint(error.toString());
      emit(ImageUploadError());
    }
  }
}
