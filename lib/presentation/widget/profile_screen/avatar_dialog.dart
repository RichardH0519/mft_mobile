import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_event.dart';
import 'package:mft_customer_side/logic/bloc/user/avatar/avatar_state.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class AvatarDialog extends StatefulWidget {
  final String username;
  final String avatar;

  AvatarDialog({@required this.username, @required this.avatar});

  @override
  _AvatarDialogState createState() => _AvatarDialogState(
        username: username,
        avatar: avatar,
      );
}

class _AvatarDialogState extends BaseState<AvatarDialog> {
  final String username;
  final String avatar;

  _AvatarDialogState({@required this.username, @required this.avatar});

  File _imageFile;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AvatarBloc, AvatarState>(
      listener: (listenerContext, state) {
        if (state is RemoveAvatarSuccess) {
          Navigator.pop(context);
        }

        if (state is UpdateAvatarSuccess) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translator.text(
                "avatar_update",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _openGallery();
                },
                child: (_imageFile == null)
                    ? Text(
                        translator.text(
                          "choose_avatar",
                        ),
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      )
                    : Image.file(
                        File(_imageFile.path),
                      ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: avatar != null
                    ? () {
                        BlocProvider.of<AvatarBloc>(context).add(
                          RemoveAvatar(
                            username: username,
                          ),
                        );
                      }
                    : null,
                child: Text(
                  translator.text(
                    "remove",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: _imageFile != null
                    ? () {
                        BlocProvider.of<AvatarBloc>(context).add(
                          UploadUserAvatar(
                            username: username,
                            image: _imageFile,
                          ),
                        );
                      }
                    : null,
                child: Text(
                  translator.text(
                    "update",
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _openGallery() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}
