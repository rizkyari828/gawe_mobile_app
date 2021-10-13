import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/controllers/mediaController.dart';
import 'package:gaweid2/modules/media/controllers/tipsController.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:gaweid2/modules/user/authController.dart';
import 'package:gaweid2/routes/routes_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TipsNew extends StatelessWidget {
  final authC = Get.put(AuthController());
  final tipsC = Get.put(TipsController());

  @override
  Widget build(BuildContext context) {
    Get.put(MediaController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (tipsC.isDataProcessing.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: tipsC.tips.isEmpty
                  ? Center(
                      child: Text("Belum ada data"),
                    )
                  : ListView.builder(
                      itemCount: tipsC.tips.length,
                      itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.detailMedia, arguments: tipsC.tips[i]);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => NewsDetail(
                          //           title:
                          //           tipsC.tips[i].title == null ? "" : tipsC.tips[i].title,
                          //           foto: tipsC.tips[i].foto == null ? "" : tipsC.tips[i].foto,
                          //           desc: tipsC.tips[i].desc == null ? "" : tipsC.tips[i].desc,
                          //         )));
                        },
                        child: ListTile(
                              leading: Container(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    tipsC.tips[i].foto,
                                    height: MediaQuery.of(context).size.height / 12,
                                    width: MediaQuery.of(context).size.width / 5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(tipsC.tips[i].title),
                              subtitle:
                              Text(DateFormat.yMMMd().format(tipsC.tips[i].dateCreated).toString())
                            ),
                      )),
            );
          }
        }),
      ),
    );
  }
}

