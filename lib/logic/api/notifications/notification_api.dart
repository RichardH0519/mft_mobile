import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mft_customer_side/model/notifications/add_notification.dart';
import 'package:mft_customer_side/model/notifications/add_notification_customer.dart';
import 'package:mft_customer_side/model/notifications/customer_notification.dart';

class NotificationAPI {
  final databaseRef =
      FirebaseDatabase.instance.reference().child("notification");

  final customerDatabaseRef =
      FirebaseDatabase.instance.reference().child("notificationApp");

  //add rent notification
  Future<void> addRentNotification(AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  //delete pending and waiting contract notification
  Future<void> deleteContractNotification(AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  //accept contract notification
  Future<void> acceptContractNotification(AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  //cancel contract notification
  Future<void> cancelContractNotification(AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  //choose delivery date notification
  Future<void> chooseDeliveryDateNotification(
      AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  //book garden visit notification
  Future<void> bookVisitNotification(AddNotification notification) async {
    databaseRef.push().set(notification.toJson());
  }

  // response to request notification
  Future<void> sendResponseNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  // accept response notification
  Future<void> acceptResponseNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //reject response notification
  Future<void> rejectResponseNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //response cancel exchange
  Future<void> responseCancelNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //response confirm cancel exchange
  Future<void> responseConfirmCancelNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //request cancel exchange
  Future<void> requestCancelNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //request confirm cancel exchange
  Future<void> requestConfirmCancelNotification(
      AddNotificationCustomer notification) async {
    customerDatabaseRef.push().set(notification.toJson());
  }

  //get custoner notification
  Future<List<CustomerNotification>> getNotifications(String username) async {
    List<CustomerNotification> list = [];
    DataSnapshot snapshot = await customerDatabaseRef.once();

    var keys = snapshot.value.keys;
    var value = snapshot.value;

    for (var key in keys) {
      if (value[key]['customer'] == username) {
        CustomerNotification notification = CustomerNotification(
          created: DateTime.parse(value[key]['created']),
          customer: value[key]['customer'],
          isSeen: value[key]['isSeen'],
          title: value[key]['title'],
          type: value[key]['type'],
        );

        list.add(notification);
      }
    }

    list.sort((a, b) => a.created.compareTo(b.created));

    return list;
  }

  //update notification
  Future<void> updateNotification(String username) async {
    DataSnapshot snapshot = await customerDatabaseRef.once();

    var keys = snapshot.value.keys;
    var value = snapshot.value;

    for (var key in keys) {
      if (value[key]['customer'] == username) {
        if (value[key]['isSeen'] == false) {
          customerDatabaseRef.child(key).update({'isSeen': true});
        }
      }
    }
  }
}
