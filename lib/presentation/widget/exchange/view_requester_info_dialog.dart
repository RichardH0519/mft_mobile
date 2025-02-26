import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/block/block_bloc.dart';
import 'package:mft_customer_side/logic/bloc/block/block_event.dart';
import 'package:mft_customer_side/logic/bloc/block/block_state.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/model/block/block.dart';
import 'package:mft_customer_side/model/user/user.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class RequesterInfoDialog extends StatefulWidget {
  final String username;

  RequesterInfoDialog({@required this.username});

  @override
  _RequesterInfoDialogState createState() => _RequesterInfoDialogState(
        username: username,
      );
}

class _RequesterInfoDialogState extends BaseState<RequesterInfoDialog> {
  final String username;

  _RequesterInfoDialogState({@required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockBloc, BlockState>(
      listener: (listenerContext, state) {
        if (state is BlockFail) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(translator.text("block_fail")),
              ),
            );

          Navigator.pop(context);
        }

        if (state is BlockSuccess) {
          ScaffoldMessenger.of(listenerContext)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(translator.text("block_success")),
              ),
            );

          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              translator.text(
                "requester_info",
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
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoaded) {
                return Column(
                  children: [
                    _detailColumn(state.user),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _detailColumn(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("fullname"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.fullname,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("phone"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.phone,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size5,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Dimens.size10,
                ),
                child: Text(
                  translator.text("email"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    fontSize: Dimens.size14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  user.email == null ? "" : user.email,
                  style: TextStyle(
                    fontSize: Dimens.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: Dimens.size20,
          ),
          child: BorderButton(
            title: translator.text("block"),
            color: Colors.red,
            function: () {
              BlocProvider.of<BlockBloc>(context).add(
                BlockPressed(
                  username: username,
                  blocked: user.username,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
