import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class rekamvideo extends StatefulWidget {
  @override
  _rekamvideoState createState() => _rekamvideoState();
}

class _rekamvideoState extends State<rekamvideo> {

  final ImagePicker _picker = ImagePicker();
  File image, image_save;
  TextEditingController ctitle = new TextEditingController();
  accessVideo() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 900, height: 900, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
    new File("$path/video_${currentTime}.mp4")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img as File;
        image_save = compressImg;
        uploadimg();
        var InSignIn = true;
      });
      Navigator.pop(context);
    }
  }

  BaseEndPoint network = NetworkProvider();

  void uploadimg() {
    network.rekamvideo("zulay@gmail.com", image_save, context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: (){
            accessVideo();
          },
          child: Text("Rekam Video",),
        ),
      ),
    );
  }
}
