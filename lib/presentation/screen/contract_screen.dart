import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mft_customer_side/common/style/dimens.dart';
import 'package:mft_customer_side/common/widget/base_widget.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_event.dart';
import 'package:mft_customer_side/logic/bloc/contract/contract_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/farmer_info/farmer_info_state.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/contract/tree_info/tree_info_state.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_bloc.dart';
import 'package:mft_customer_side/logic/bloc/notifications/notification_event.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_bloc.dart';
import 'package:mft_customer_side/logic/bloc/user/user_info/user_info_state.dart';
import 'package:mft_customer_side/model/tree/tree.dart';
import 'package:mft_customer_side/presentation/screen/home.dart';
import 'package:mft_customer_side/presentation/widget/common/border_button.dart';

class ContractScreen extends StatefulWidget {
  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends BaseState<ContractScreen> {
  bool _isChecked = false;
  bool _isAgreed = false;
  var treeID;
  var contractID;
  var user;

  var acceptedContractNumber;
  var farmerUsername;

  final moneyFormat = NumberFormat.currency(locale: "vi", symbol: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<ContractBloc, ContractState>(
        listener: (listenerContext, state) {
          if (state is ContractAcceptFail) {
            ScaffoldMessenger.of(listenerContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(translator.text("accept_contract_fail")),
                ),
              );
          }

          if (state is ContractAcceptSuccess) {
            ScaffoldMessenger.of(listenerContext)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(translator.text("accept_contract_success")),
                ),
              );

            BlocProvider.of<NotificationBloc>(context).add(
              AcceptContractNotification(
                farmerUsername: farmerUsername,
                contractNumber: acceptedContractNumber,
              ),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builderContext) => Home(
                  user: user,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: _contractForm(),
      ),
    );
  }

  Widget _contractForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size35,
            ),
            child: Align(
              alignment: FractionalOffset.center,
              child: Text(
                "HỢP ĐỒNG THUÊ CÂY",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.size25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          BlocBuilder<ContractBloc, ContractState>(
            builder: (builderContext, state) {
              if (state is ContractLoaded) {
                treeID = state.contract.treeID;
                contractID = state.contract.contractID;

                acceptedContractNumber = state.contract.contractNumber;
                
                return Column(
                  children: [
                    _contractRow(
                      title: "Số hợp đồng:",
                      content: state.contract.contractNumber.toString(),
                    ),
                    _contractRow(
                      title: "Ngày tạo hợp đồng:",
                      content:
                          DateFormat("dd-MM-yyyy").format(state.contract.date),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          _textRow("Bên nông dân (sau đây gọi tắt là bên A)"),
          BlocBuilder<FarmerInfoBloc, FarmerInfoState>(
            builder: (builderContext, state) {
              if (state is FarmerInfoLoaded) {
                farmerUsername = state.user.username;

                return Column(
                  children: [
                    _contractRow(
                        title: "Họ và tên:", content: state.user.fullname),
                    _contractRow(
                      title: "Ngày tháng năm sinh:",
                      content: DateFormat("dd-MM-yyyy")
                          .format(state.user.dateOfBirth),
                    ),
                    _contractRow(
                        title: "Địa chỉ:",
                        content:
                            "${state.user.address}, ${state.user.wardName}, ${state.user.districtName}, ${state.user.cityName}"),
                    _contractRow(
                        title: "Số điện thoại:", content: state.user.phone),
                    _contractRow(title: "Email:", content: state.user.email),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          _textRow("Bên thuê cây (sau đây gọi tắt là bên B)"),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (builderContext, state) {
              if (state is UserInfoLoaded) {
                user = state.user;
                return Column(
                  children: [
                    _contractRow(
                        title: "Họ và tên:", content: state.user.fullname),
                    _contractRow(
                      title: "Ngày tháng năm sinh:",
                      content: DateFormat("dd-MM-yyyy")
                          .format(state.user.dateOfBirth),
                    ),
                    _contractRow(
                        title: "Địa chỉ:",
                        content:
                            "${state.user.address}, ${state.user.wardName}, ${state.user.districtName}, ${state.user.cityName}"),
                    _contractRow(
                        title: "Số điện thoại:", content: state.user.phone),
                    _contractRow(
                      title: "Email:",
                      content: state.user.email,
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.size10,
              right: Dimens.size10,
              top: Dimens.size30,
            ),
            child: Text(
              "Hai bên thỏa thuận và đồng ý ký kết hợp đồng thuê cây với các điều khoản như sau",
              style: TextStyle(
                fontSize: Dimens.size17,
                color: Colors.black,
              ),
            ),
          ),
          _textRow("Thông tin cây của hợp đồng"),
          BlocBuilder<TreeInfoBloc, TreeInfoState>(
            builder: (builderContext, state) {
              if (state is TreeInfoLoaded) {
                return Column(
                  children: [
                    _contractRow(
                        title: "Mã cây:", content: state.tree.treeCode),
                    _contractRow(
                        title: "Chủng loại cây:",
                        content: state.tree.plantTypeName),
                    _contractRow(
                        title: "Số mùa vụ trong 1 năm:",
                        content: "${state.tree.crops} vụ"),
                    _contractRow(
                        title: "Vói sản lượng bình quân 1 vụ:",
                        content: "${state.tree.yield} kg"),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          BlocBuilder<ContractBloc, ContractState>(
            builder: (builderContext, state) {
              if (state is ContractLoaded) {
                return Column(
                  children: [
                    _contractRow(
                        title: "Thời hạn thuê cây tại Điều 1 hợp đồng này là:",
                        content: "${state.contract.numOfYear} năm"),
                    _contractRow(
                      title: "Kể từ ngày:",
                      content:
                          DateFormat("dd-MM-yyyy").format(state.contract.date),
                    ),
                    _contractRow(
                        title: "Giá của cây thuê trong 1 năm là:",
                        content:
                            "${moneyFormat.format(state.contract.treePrice)} VND"),
                    _contractRow(
                        title: "Giá tiền vận chuyển cho bên B là:",
                        content:
                            "${moneyFormat.format(state.contract.shipFee)} VND"),
                    _contractRow(
                        title: "Tổng giá trị của hợp đồng này là:",
                        content:
                            "${moneyFormat.format(state.contract.totalPrice)} VND"),
                    _contractRow(title: "Phương thức thanh toán: Tiền mặt"),
                    _contractRow(
                        title: "Số mùa vụ được hưởng của bên B:",
                        content: "${state.contract.totalCrop} vụ"),
                    _contractRow(
                        title: "Số sản lượng ước tính bên B hưởng:",
                        content: "${state.contract.totalYield} kg"),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          _textRow("Quyền, nghĩa vụ của các bên"),
          _rightsAndObligationsPart(),
          _textRow("Trách nhiệm do vi phạm hợp đồng"),
          _breachOfContract(),
          _textRow("Chi phí khác"),
          _otherCost(),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimens.size20,
              left: Dimens.size10,
              right: Dimens.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                      _isAgreed = value;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                ),
                Text(
                  "Tôi đã đọc và đồng ý với những điều khoản trên",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Dimens.size20,
            ),
            child: BorderButton(
              title: translator.text("approved"),
              color: _isAgreed ? Theme.of(context).primaryColor : Colors.grey,
              function: _isAgreed
                  ? () {
                      //call function add contract here
                      BlocProvider.of<ContractBloc>(context).add(
                        AcceptContract(
                          treeID: treeID,
                          contractID: contractID,
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size10,
        top: Dimens.size30,
        right: Dimens.size10,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: Dimens.size17,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _contractRow({String title, String content}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size10,
        top: Dimens.size10,
        right: Dimens.size10,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: Dimens.size10,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: Dimens.size15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content ??= "",
              style: TextStyle(
                fontSize: Dimens.size17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightsAndObligationsPart() {
    final String raoFormat = """1. Quyền, nghĩa vụ của bên A:

Giao trái cây thu hoạch được cho bên B đúng số lượng, chất lượng, chủng loại, thời điểm, địa điểm như đã thỏa thuận tại hợp đồng này.

Chăm sóc, bảo quản cây do bên A chịu trách nhiệm, bên A có trách nhiệm cập nhật tiến độ của cây cho bên B theo dõi.

Bảo đảm đúng số mùa vụ và số lượng trái cây thu hoạch cho bên B.
    
Trong trường hợp cây được bên B thuê bị ảnh hưởng bởi thời tiết, thiên tai thì bên A có thể hủy hợp đồng.

2. Quyền, nghĩa vụ của bên B:

Đơn phương chấm dứt thực hiện hợp đồng khi số lượng, chất lượng sản phẩm thu hoạch không đúng thông tin.""";

    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size10,
        right: Dimens.size10,
        top: Dimens.size10,
      ),
      child: Text(
        raoFormat,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _breachOfContract() {
    final String bocFormat = """Bồi thường thiệt hại: 

Bên vi phạm nghĩa vụ phải bồi thường thiệt hại theo 10 phần trăm theo giá trị hợp đồng đã thỏa thuận.

Trong đó phải trừ hao những mùa vụ đã giao cho bên B, chỉ hoàn trả lại giá tiền tình theo số mùa vụ chưa giao cho bên B.""";

    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size10,
        right: Dimens.size10,
        top: Dimens.size10,
      ),
      child: Text(
        bocFormat,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _otherCost() {
    final String ocFormat =
        """Trong trường hợp có trao đổi sản phẩm giữa bên B với bên thứ 3 thì bên B sẽ chịu mọi phí phát sinh thêm.""";

    return Padding(
      padding: const EdgeInsets.only(
        left: Dimens.size10,
        right: Dimens.size10,
        top: Dimens.size10,
      ),
      child: Text(
        ocFormat,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
