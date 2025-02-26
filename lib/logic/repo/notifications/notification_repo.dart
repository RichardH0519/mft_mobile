import 'package:flutter/material.dart';
import 'package:mft_customer_side/logic/api/notifications/notification_api.dart';
import 'package:mft_customer_side/model/notifications/add_notification.dart';
import 'package:mft_customer_side/model/notifications/add_notification_customer.dart';
import 'package:mft_customer_side/model/notifications/customer_notification.dart';

class NotificationRepo {
  final NotificationAPI apiClient;

  NotificationRepo({@required this.apiClient}) : assert(apiClient != null);

  Future<void> addRentNotification(String farmerUsername, String userFullname) {
    return apiClient.addRentNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "$userFullname muốn thuê cây của bạn.",
        type: "contract",
      ),
    );
  }

  Future<void> deleteContractNotification(
      String farmerUsername, int contractNumber) {
    return apiClient.deleteContractNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "Hợp đồng $contractNumber đã bị khách hàng hủy",
        type: "contract",
      ),
    );
  }

  Future<void> acceptContractNotification(
      String farmerUsername, int contractNumber) {
    return apiClient.acceptContractNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "Khách hàng đã xác nhận hợp đồng $contractNumber",
        type: "contract",
      ),
    );
  }

  Future<void> cancelContractNotification(
      String farmerUsername, int contractNumber) {
    return apiClient.cancelContractNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "Khách hàng muốn hủy hợp đồng $contractNumber",
        type: "contract",
      ),
    );
  }

  Future<void> confirmCancelContractNotification(
      String farmerUsername, int contractNumber) {
    return apiClient.cancelContractNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "Khách hàng đã xác nhận hủy hợp đồng $contractNumber",
        type: "contract",
      ),
    );
  }

  Future<void> chooseDeliveryDateNotification(
      String farmerUsername, int contractNumber) {
    return apiClient.chooseDeliveryDateNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "Khách hàng đã chọn ngày giao cho hợp đồng $contractNumber",
        type: "contract",
      ),
    );
  }

  Future<void> bookVisitNotification(
      String farmerUsername, String customerFullname, String gardenName) {
    return apiClient.bookVisitNotification(
      AddNotification(
        created: DateTime.now(),
        farmer: farmerUsername,
        isSeen: false,
        title: "$customerFullname muốn đến thăm $gardenName",
        type: "visit",
      ),
    );
  }

  Future<void> sendResponseNotification(
      String requestUsername, String plantTypename) {
    return apiClient.sendResponseNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: requestUsername,
        isSeen: false,
        title: "Có người muốn trao đổi với yêu cầu đổi $plantTypename của bạn",
        type: "exchange",
      ),
    );
  }

  Future<void> acceptResponseNotification(
      String responseUsername, String plantTypename) {
    return apiClient.acceptResponseNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: responseUsername,
        isSeen: false,
        title: "Yêu cầu trao đổi với loại cây $plantTypename đã được chấp nhận",
        type: "accept",
      ),
    );
  }

  Future<void> rejectResponseNotification(
      String responseUsername, String plantTypename) {
    return apiClient.rejectResponseNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: responseUsername,
        isSeen: false,
        title: "Yêu cầu trao đổi với loại cây $plantTypename đã bị từ chối",
        type: "reject",
      ),
    );
  }

  Future<void> responseCancelNotification(
      String requestUsername, String plantTypename) {
    return apiClient.responseCancelNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: requestUsername,
        isSeen: false,
        title: "Bên trao đổi muốn hủy giao dịch với $plantTypename của bạn",
        type: "exchange",
      ),
    );
  }

  Future<void> responseConfirmCancelNotification(
      String requestUsername, String plantTypename) {
    return apiClient.responseConfirmCancelNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: requestUsername,
        isSeen: false,
        title: "Bên trao đổi đã xác nhận hủy giao dịch với $plantTypename của bạn",
        type: "accept",
      ),
    );
  }

  Future<void> requestCancelNotification(
      String responseUsername, String plantTypename) {
    return apiClient.requestCancelNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: responseUsername,
        isSeen: false,
        title: "Bên trao đổi muốn hủy giao dịch với $plantTypename của bạn",
        type: "exchange",
      ),
    );
  }

  Future<void> requestConfirmCancelNotification(
      String responseUsername, String plantTypename) {
    return apiClient.requestConfirmCancelNotification(
      AddNotificationCustomer(
        created: DateTime.now(),
        customer: responseUsername,
        isSeen: false,
        title: "Bên trao đổi đã xác nhận hủy giao dịch với $plantTypename của bạn",
        type: "accept",
      ),
    );
  }

  Future<List<CustomerNotification>> getNotifications(String username) {
    return apiClient.getNotifications(username);
  }

  Future<void> updateNotification(String username) {
    return apiClient.updateNotification(username);
  }
}
