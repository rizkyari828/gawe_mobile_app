import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/controllers/mediaController.dart';
import 'package:gaweid2/routes/routes_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsNew extends GetView<MediaController> {
  final String userId;
  NewsNew({this.userId});

  @override
  Widget build(BuildContext context) {
    Get.put(MediaController());
    return Scaffold(
      body: controller.obx((state) => ListView.separated(
        padding: EdgeInsets.only(top: 8),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.toNamed(RouteName.detailMedia, arguments: state[index]);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => NewsDetail(
                //           title:
                //           state[index].title == null ? "" : state[index].title,
                //           foto: state[index].foto == null ? "" : state[index].foto,
                //           desc: state[index].desc == null ? "" : state[index].desc,
                //         )));
              },
              child: ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      state[index].foto,
                      height: MediaQuery.of(context).size.height / 12,
                      width: MediaQuery.of(context).size.width / 5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(state[index].title),
                subtitle: Text(DateFormat.yMMMd().format(state[index].dateCreated).toString()),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.white24,
            );
          },
          physics: BouncingScrollPhysics(),
          itemCount: state.length),
          onLoading: CircularProgressIndicator(),
        onError: (error) => Center(child: Text(error.toString()))
      ),
    );
  }
}
