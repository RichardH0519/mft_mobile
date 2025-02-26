import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/block/block_api.dart';
import 'package:mft_customer_side/model/block/block.dart';
import 'package:mft_customer_side/model/block/blocked_list.dart';

class BlockRepo {
  final BlockAPI apiClient;

  BlockRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<bool> block(String username, String blocked) {
    return apiClient.block(
      Block(
        username: username,
        blocked: blocked,
      ),
    );
  }

  Future<BlockedList> getBlockedList(String username) {
    return apiClient.getBlockedList(username);
  }

  Future<bool> unblock(int id) {
    return apiClient.unblock(id);
  }
}
