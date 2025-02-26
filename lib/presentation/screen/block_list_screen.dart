import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mft_customer_side/common/style/colors.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/block/block_bloc.dart';
import 'package:mft_customer_side/logic/bloc/block/block_event.dart';
import 'package:mft_customer_side/logic/bloc/block/block_state.dart';
import 'package:mft_customer_side/model/block/blocked_info.dart';

class BlockListScreen extends StatefulWidget {
  @override
  _BlockListScreenState createState() => _BlockListScreenState();
}

class _BlockListScreenState extends BaseState<BlockListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteSmoke,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size35,
              left: Dimens.size15,
            ),
            child: Text(
              translator.text("block_list"),
              style: TextStyle(
                fontSize: Dimens.size18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimens.size20,
                left: Dimens.size10,
                right: Dimens.size10,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<BlockBloc, BlockState>(
                  builder: (context, state) {
                    if (state is BlockedListLoaded) {
                      return Column(
                        children: [
                          for (var blocked in state.blockedList.result)
                            _blockedOverview(blocked),
                        ],
                      );
                    }

                    if (state is BlockedListEmpty) {
                      return Center(
                        child: Text(
                          translator.text(
                            "list_empty",
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blockedOverview(BlockedInfo blocked) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimens.size10,
      ),
      child: Material(
        elevation: Dimens.cardElevation,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(width: Dimens.thick02),
            borderRadius: BorderRadius.circular(
              Dimens.size5,
            ),
          ),
          padding: const EdgeInsets.all(
            Dimens.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                blocked.fullname, //treeCode
                style: TextStyle(
                  fontSize: Dimens.size18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<BlockBloc>(context).add(
                    Unblock(
                      id: blocked.b.id,
                    ),
                  );

                  BlocProvider.of<BlockBloc>(context).add(
                    GetBlockedList(
                      username: blocked.b.username,
                    ),
                  );
                },
                child: Text(
                  translator.text("unblock"),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
