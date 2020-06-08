import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/sos_request_model.dart';
import 'package:personal_safety/services/getEvent_service.dart';
import 'package:personal_safety/services/sos_history_service.dart';
import 'package:personal_safety/widgets/drawer.dart';
import 'package:personal_safety/widgets/request_history_item.dart';

class ActiveRequest extends StatefulWidget {
  @override
  _ActiveRequestState createState() => _ActiveRequestState();
}

class _ActiveRequestState extends State<ActiveRequest> {
  SOSHistoryService get sosRequestService =>
      GetIt.instance<SOSHistoryService>();
  List<SOSRequestModel> sosRequestList;
  Future getSOSRequestHistory() async {
    final result = await sosRequestService.getSOSHistory();
    setState(() {
      print('OBTAINED REQUEST HISTORY FROM SERVICE!!!!\n\n');
      List<SOSRequestModel> list = result.result;
      print('OBTAINED REQUEST HISTORY FROM SERVICE!!!!\n\n');

      sosRequestList = list;
    });
  }

  @override
  void initState() {
    getSOSRequestHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        centerTitle: true,
        actions: <Widget>[],
        iconTheme: IconThemeData.lerp(
            IconThemeData(color: Colors.grey), IconThemeData(size: 25), .5),
        title: Text(
          "Your Requests",
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.withOpacity(.1),
      ),
      body: sosRequestList == null
          ? Center(
              child: CustomLoadingIndicator(
              customColor: primaryColor,
            ))
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sosRequestList.length,
                        itemBuilder: (context, index) => SOSRequestItem(
                              sosRequestModel: sosRequestList[index],
                            )),
                  ),
                ],
              ),
            ),
    );
  }
}
