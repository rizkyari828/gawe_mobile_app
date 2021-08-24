import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/constant/constant.dart';

// import 'package:gaweid2/model/ModelCheck.dart';
import 'package:gaweid2/modules/user/models/ModelLogin.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/modules/user/models/ModelUser.dart';
import 'package:gaweid2/modules/learning/models/aturanmain_model.dart';
import 'package:gaweid2/modules/learning/models/soal_modul.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/model/user/ModelLowonganDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:async/async.dart';

import 'package:toast/toast.dart';

class NetworkConfig {
  // final baseUrl = "http://192.168.43.215/news_server/index.php/Api/";
  // final baseUrl = "https://testing.gawe.id/api_apps/";
  final baseUrl = "https://gawe.id/api_apps/";
}

abstract class BaseEndPoint {
  Future<List> getProvince();

  Future<List> getSumber();

  Future<List> getCityAll();

  Future<List> getCity(String id_province);

  Future<List> getCity2(String id_province);

//  Future<List> getKecamatan(String id_city);
//  void saveData(String name,String email,String password,String gender,String province,String kota, String Kecamatan,File image);
  Future<ModelUser> loginUser(String email, String password);

  Future login(String email, String password);

  Future register(
      String nama, String email, String password, no_hp, sumber, referal);

  Future edit_datadiri_dw(
    String email,
    String nik,
    String tmp_lahir,
    String tgl_lahir,
    String gender,
    String agama,
    String province_id,
    String city_id,
    String alamat_ktp,
    String alamat_domisili,
    String kodepos,
    String statusperkawinan,
    String namakeluarga,
    String hubungan_keluarga,
    String no_hp_keluarga,
    String namabank,
    String norek,
  );

  Future register_datadiri1(
      String email,
      String nik,
      String kk,
      String tmp_lahir,
      String tgl_lahir,
      String gender,
      String agama,
      String province_id,
      String city_id,
      String alamat_ktp,
      String alamat_domisili,
      String kodepos,
      String statusperkawinan);

  Future register_datadiri2(
    String email,
    String no_tlpn,
    String no_hp,
    String minat_parent,
    String sim,
    String kendaraan,
    String gajimin,
    String gajimax,
    String os,
    String versi,
    String keahlian,
    String minat,
    String facebook,
    String twitter,
    String linkedin,
    String instagram,
    String minatLokasi,
  );

  Future register_datadiri3(
      String email,
      String tingkatpendidikan,
      String universitas,
      String jurusan,
      String ipk,
      String tahunmasuk,
      String tahunlulus,
      String namaorg,
      String jabatan,
      String mulaimenjabat,
      String selesaimenjabat);

  Future register_datadiri4(
      String email,
      String namapekerjaan,
      String industri,
      String kerjaposisi,
      String levelpekerjaan,
      String lokasi,
      String gaji,
      String tanggal_mulai,
      String tanggal_berhenti,
      String masihbekerjadisini,
      String deskripsipekerjaan,
      String fungsikerja,
      String namapelatihan,
      String penyelenggara,
      String tahun,
      String bahasa_title,
      String bahasa_lisan,
      String bahasa_tulisan,
      String bahasa_membaca,
      String keterangan_keahlian_smartphone,
      String title_keterangan_keahlian,
      String keterangan_keahlian,
      String keterangan_office,
      String keterangan_email,
      String keterangan_lainnya,
      String keterangan_komputer_lainnya,
      String pengalaman,
      String namakeluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      File profilepic,
      context);

  Future<List<ModelLowongan2>> getSearch(String keyword);

  Future<ModelLowonganDetail> lowongandetail(int id_lowongan);

  Future<List> listLowongan();

  Future<List> searchLowongan(String posisi);

  Future register_datadiri2_dw(
      String email,
      String namakeluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      String namabank,
      String norek,
      context);

  Future gantidatadiri1(
      String email, String nama, String tmp_lahir, String tgl_lahir, context);

  Future edit_pendidikan(
      String email,
      String universitas,
      String tingkatpendidikan,
      String jurusan,
      String ipk,
      String tahunmasuk,
      String tahunkeluar);

  Future gantipp(String email, File profilepic, context);

  Future pengalamankerja(
      String employee_id,
      String namapekerjaan,
      String industri,
      String kerjaposisi,
      String levelpekerjaan,
      String lokasi,
      String gaji,
      String tanggal_mulai,
      String tanggal_berhenti,
      String masihbekerjadisini,
      String deskripsipekerjaan,
      String fungsikerja);

  Future pengalamanorg(String email, String namaorg, String jabatan,
      String mulaimenjabat, String selesaimenjabat);

  Future gantiktp(String email, File ktp, context);

  Future gantikk(String email, File kk, context);

  Future ganticv(String email, File cv, context);

  Future gantibk(String email, File bk, context);

  Future gantiijazah(String email, File ijazah, context);

  Future ganti_ttd(
      String email, String id_dw_active, String hariini, File ijazah, context);

  Future hapus_pengalaman_kerja(String id);

  Future hapus_pengalaman_org(String id);

  Future edit_pengalaman_org(
      String id, String nama_org, String jabatan, String mulai, String akhir);

  Future edit_pengalaman_kerja(
      String id,
      String namapekerjaan,
      String industri,
      String kerjaposisi,
      String levelpekerjaan,
      String lokasi,
      String gaji,
      String tanggal_mulai,
      String tanggal_berhenti,
      String masihbekerjadisini,
      String deskripsipekerjaan,
      String fungsikerja);

  Future edit_profil_all(
      String email,
      String nik,
      String no_wa,
      String no_hp,
      String gender,
      String agama,
      String provinsi,
      String kota,
      String kodepos,
      String status_perkawinan,
      String job_parent,
      String job_child,
      String kepemilikan_kendaraan,
      String kepemilikan_sim,
      String min_gaji,
      String max_gaji,
      String os,
      String versi,
      String alamat_ktp,
      String alamat_domisili,
      String facebook,
      String instagram,
      String linkedin,
      String twitter,
      String sumber,
      String nama_keluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      String nama_bank,
      String no_rek,
      String no_kk,
      String minat_lokasi);

  Future lupakatasandi(String email);

  Future gantipassword(String email, password_lama, password_baru);

  Future absensi_dw(String id_dw_active, qrcode);

  Future player_id(String email, String player_id);

  Future pulangtelat(String id_dw_active, String alasanpulang);

  Future tariksaldo(String id_employee, String jumlah);

  Future LatLang(String email, double lat, double long);

  Future rekamvideo(String email, File profilepic, context);

  Future pengajuan_lembur(
      String id_employee,
      String tanggal_pengajuan,
      String jam_masuk,
      String menit_masuk,
      String jam_keluar,
      String menit_keluar,
      String id_active,
      File profilepic,
      context);

  Future Jawaban_soal_learning(
      String email,
      String jawaban,
      String id_soal,
      String kunci_jawaban,
      String jenis_status,
      String id_materi,
      String id_jawaban,
      String insert_id);

  Future regist_kode_learning(
      String email, String activasi, String kode_referal);

  Future Katalog(
      String email,
      String kode_referral,
      String level,
      String posisi,
      String penempatan,
      );

  Future reSendOTPCode(
      String email,
      );

  Future aturanmain_learning(String email, String id_jenis, String id_materi);

  Future akses_mater_learning(String email, String id_modul, String id_materi);

  Future overview(String email, String aktivasi, String kode_refferal);

  Future getPost();

  Future saveLocation(
      String email,
      String lat,
      String long,
      );

  Future savePlayerId(
      String email,
      String playerId,
      );
}

class NetworkProvider extends ChangeNotifier implements BaseEndPoint {
  SoalModul _post;

  SoalModul get posts => _post;

  set posts(SoalModul val) {
    _post = val;
    notifyListeners();
  }

  var _id = 1;

  int get idPost => _id;

  set idPost(int val) {
    if (val != 0) {
      _id = val;
    }
    notifyListeners();
  }

//  List<ModelLowongan2> _article;
//  List<ModelLowongan2> get listlowongan21 => _article;
//  set listlowongan2(List<Lowongan>val){
//    _article = val;
//    notifyListeners();
//  }
//
//  List _searchArticle;
//  List get searchArticle => _searchArticle;
//  set searchArticle(List val){
//    _searchArticle = val;
//    notifyListeners();
//  }

  @override
  Future<List> getProvince() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/provinsi");
    List listData = jsonDecode(response.body);
    print(listData);
    return listData;
  }

  @override
  Future<List> getCity(String id_province) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "master_api/city",
        body: {'id': id_province});
    List listData = jsonDecode(response.body);
    //print(listData);
    return listData;
  }

  @override
  Future<List> getCity2(String id_province) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "master_api/city",
        body: {'id': id_province});
    List listData = jsonDecode(response.body);
    return listData;
  }

  @override
  Future<List> getKecamatan(String id_city) async {
    final response = await http.post(NetworkConfig().baseUrl + "getKecamatan",
        body: {'id_city': id_city});
    List listData = jsonDecode(response.body);
    return listData;
  }

  @override
  void saveData(String name, String email, String password, String gender,
      String province, String kota, String Kecamatan) async {
    //open red byte stream
    //var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    //var length = await image.length();

    //url
    var request = http.MultipartRequest(
        'POST', Uri.parse(NetworkConfig().baseUrl + "registerUser1"));

    //var multipart = http.MultipartFile('photo',stream,length,filename:image.path);

    //request.files.add(multipart);
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['gender'] = gender;
    request.fields['id_province'] = province;
    request.fields['id_city'] = kota;
    request.fields['id_kecamatan'] = Kecamatan;
    var response = await request.send();
    if (response.statusCode == 200) {
      print("image berhasil diupload");
    } else {
      print("image gagal diupload");
    }
  }

  @override
  Future<ModelUser> loginUser(String email, String password) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "loginUser", body: {
      'email': email,
      'password': password,
    });

    ModelUser listData = modelUserFromJson(response.body);
    if (listData.status == 200) {
      return listData;
    } else {
      print("gagal");
      return null;
    }
  }

  @override
  Future<List> listLowongan() async {
    final response = await http.get(NetworkConfig().baseUrl + "apps/lowongan");

    List listData = modelLowonganFromJson(response.body);
    // print("listdata");
    return listData;
  }

  @override
  Future login(String email, String password) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/login", body: {
      'email': email,
      'password': password,
    });

    //print("cek login");
    //ModelLogin listData = modalLoginFromJson(response.body);
    final jsondata = jsonDecode(response.body);
    ModelLogin listData = ModelLogin.fromJson(jsondata);

    if (listData.status == 200) {
      print(listData.status);
      return listData;
    } else if (listData.status == 404) {
      print(listData.status);
      print("gagal2");
      // Toast.show("Email/Sandi Salah", null, duration: 5, gravity: Toast.BOTTOM);
      return listData;
    } else if (listData.status == 405) {
      // Toast.show("Email/Sandi Salah", null, duration: 5, gravity: Toast.BOTTOM);
      return listData;
    } else {
      print("gagal");
      return null;
    }
  }

  @override
  Future<ModelLowonganDetail> lowongandetail(int id_lowongan) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/lowongan_detail", body: {
      'id_lowongan': id_lowongan,
    });

    ModelLowonganDetail listData = modelLowonganDetailFromJson(response.body);
    if (listData.status == 200) {
      return listData;
    } else {
      print("gagal");
      return null;
    }
  }

  @override
  Future<List> searchLowongan(String posisi) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/search_lowongan", body: {
      'search': posisi,
    });

    ModelLowongan2 listData = modelLowongan2FromJson(response.body);
    // myData = modelNewsFromJson(response.body);
    return listData.lowongan;
  }

  @override
  Future<List> getSumber() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/get_sumber");
    List listData = jsonDecode(response.body);
    print(listData);
    return listData;
  }

  @override
  Future<List> getCityAll() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/kota");
    List listData = jsonDecode(response.body);
    // print(listData);
    return listData;
  }

  @override
  Future register(String nama, String email, String password, no_hp, sumber,
      referral) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/register", body: {
      'nama': nama,
      'email': email,
      'password': password,
      'no_hp': no_hp,
      'sumber': sumber,
      'referral': referral,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);

    print("registrasi${jsondata}");

    return listData;

//    if(listData.status==200){
//      print(listData.status);
//      return listData;
//    }else if(listData.status==404){
//      print(listData.status);
//      print("gagal2");
//      // Toast.show("Email/Sandi Salah", null, duration: 5, gravity: Toast.BOTTOM);
//      return listData;
//    }
//    else{
//      print("gagal");
//      return null;
//
//    }
  }

  @override
  Future register_datadiri1(
      String email,
      String nik,
      String kk,
      String tmp_lahir,
      String tgl_lahir,
      String gender,
      String agama,
      String province_id,
      String city_id,
      String alamat_ktp,
      String alamat_domisili,
      String kodepos,
      String statusperkawinan) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/datadiri1", body: {
      'email': email,
      'nik': nik,
      'kk': kk,
      'tmp_lahir': tmp_lahir,
      'tgl_lahir': tgl_lahir,
      'gender': gender,
      'agama': agama,
      'province_id': province_id,
      'city_id': city_id,
      'alamat_ktp': alamat_ktp,
      'alamat_domisili': alamat_domisili,
      'kodepos': kodepos,
      'statusperkawinan': statusperkawinan,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future register_datadiri2(
      String email,
      String no_tlpn,
      String no_hp,
      String minat_parent,
      String sim,
      String kendaraan,
      String gajimin,
      String gajimax,
      String os,
      String versi,
      String keahlian,
      String minat,
      String facebook,
      String twitter,
      String linkedin,
      String instagram,
      String minatLokasi) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/datadiri2", body: {
      'email': email,
      'no_tlpn': no_tlpn,
      'no_hp': no_hp,
      'minat_parent': minat_parent,
      'sim': sim,
      'kendaraan': kendaraan,
      'gajimin': gajimin,
      'gajimax': gajimax,
      'os': os,
      'versi': versi,
      'keahlian': "",
      'minat_daerah': minat,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'minat_lokasi': minatLokasi,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future register_datadiri3(
      String email,
      String tingkatpendidikan,
      String universitas,
      String jurusan,
      String ipk,
      String tahunmasuk,
      String tahunlulus,
      String namaorg,
      String jabatan,
      String mulaimenjabat,
      String selesaimenjabat) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/datadiri3", body: {
      'email': email,
      'tingkatpendidikan': tingkatpendidikan,
      'universitas': universitas,
      'jurusan': jurusan,
      'ipk': ipk,
      'tahunmasuk': tahunmasuk,
      'tahunlulus': tahunlulus,
      'namaorg': namaorg,
      'jabatan': jabatan,
      'mulaimenjabat': mulaimenjabat,
      'selesaimenjabat': selesaimenjabat,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future register_datadiri4(
      String email,
      String namapekerjaan, //2
      String industri, //3
      String kerjaposisi, //4
      String levelpekerjaan, //5
      String lokasi, //6
      String gaji, //7
      String tanggal_mulai, //8
      String tanggal_berhenti, //9
      String masihbekerjadisini, //10
      String deskripsipekerjaan, //11
      String fungsikerja, //12
      String namapelatihan, //13
      String penyelenggara, //14
      String tahun, //15
      String bahasa_title, //16
      String bahasa_lisan, //17
      String bahasa_tulisan, //18
      String bahasa_membaca, //19
      String keterangan_keahlian_smartphone, //20
      String title_keterangan_keahlian, //21
      String keterangan_keahlian, //22
      String keterangan_office, //23
      String keterangan_email, //24
      String keterangan_lainnya, //25
      String keterangan_komputer_lainnya, //26
      String pengalaman, //27
      String namakeluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      File profilepic, //28
      context) async {
    //read file image
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();

    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/datadiri4"));

    request.files.add(multipart); //1
    request.fields['email'] = email; //2
    request.fields['namapekerjaan'] = namapekerjaan; //3
    request.fields['industri'] = industri; //4
    request.fields['kerja_posisi'] = kerjaposisi;
    request.fields['levelpekerjaan'] = levelpekerjaan;
    request.fields['lokasi'] = lokasi;
    request.fields['gaji'] = gaji;
    request.fields['tanggal_mulai'] = tanggal_mulai;
    request.fields['tanggal_berhenti'] = tanggal_berhenti;
    request.fields['masihbekerjadisini'] = masihbekerjadisini;
    request.fields['deskripsipekerjaan'] = deskripsipekerjaan;
    request.fields['fungsikerja'] = fungsikerja;
    request.fields['namapelatihan'] = namapelatihan;
    request.fields['penyelenggara'] = penyelenggara;
    request.fields['tahun'] = tahun;
    request.fields['bahasa_title'] = "b.inggris";
    request.fields['bahasa_lisan'] = bahasa_lisan;
    request.fields['bahasa_tulisan'] = bahasa_tulisan;
    request.fields['bahasa_membaca'] = bahasa_membaca;
    request.fields['keterangan_keahlian_smartphone'] =
        keterangan_keahlian_smartphone;
    request.fields['title_keterangan_keahlian'] = title_keterangan_keahlian;
    request.fields['keterangan_keahlian'] = keterangan_keahlian;
    request.fields['keterangan_office'] = keterangan_office;
    request.fields['keterangan_email'] = keterangan_email;
    request.fields['keterangan_lainnya'] = keterangan_lainnya;
    request.fields['keterangan_komputer_lainnya'] = keterangan_komputer_lainnya;
    request.fields['pengalaman'] = pengalaman;

    request.fields['nama_keluarga'] = namakeluarga;
    request.fields['hubungan_keluarga'] = hubungan_keluarga;
    request.fields['no_hp_keluarga'] = no_hp_keluarga;

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");

      Toast.show("Pendaftaran Berhasil !!", context,
          duration: 3, gravity: Toast.BOTTOM);

      //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Login(),));
//      Navigator
//          .of(context)
//          .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Login()));

      Navigator.of(context).pushReplacementNamed(SIGN_IN);
    } else {
      Toast.show("Gagal Upload !!", context,
          duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
      Navigator.pop(context);
    }
    return response.statusCode;
  }

  @override
  Future<List<ModelLowongan2>> getSearch(String keyword) async {
    print("artikel1 : ${keyword}");
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/search_lowongan2",
        body: {'search': keyword});

    //var listData = jsonDecode(response.body);
    ModelLowongan2 myData = modelLowongan2FromJson(response.body);
  }

  //register datadiri1 dw

  @override
  Future register_datadiri2_dw(
      String email,
      String namakeluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      String namabank,
      String norek,
      context) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/datadiri2_dw", body: {
      'email': email,
      'nama_keluarga': namakeluarga,
      'no_hp_keluarga': no_hp_keluarga,
      'hubungan_keluarga': hubungan_keluarga,
      'nama_bank': namabank,
      'no_rek': norek,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;

//    var stream =
//        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
//    //read size image
//    var length = await profilepic.length();
//
//    //multipart
//    var multipart = http.MultipartFile('profilepic', stream, length,
//        filename: profilepic.path);
//
//    //2
//    var stream1 = new http.ByteStream(DelegatingStream.typed(ktp.openRead()));
//    //read size image
//    var length1 = await profilepic.length();
//
//    //multipart
//    var multipart1 =
//        http.MultipartFile('ktp', stream1, length1, filename: ktp.path);
//
//    //3
//    //2
//    var stream2 = new http.ByteStream(DelegatingStream.typed(bk.openRead()));
//    //read size image
//    var length2 = await profilepic.length();
//
//    //multipart
//    var multipart2 =
//        http.MultipartFile('bukutabungan', stream2, length2, filename: bk.path);

//    var request = http.MultipartRequest(
//        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/datadiri2_dw"));
//
////    request.files.add(multipart);
////    request.files.add(multipart1);
////    request.files.add(multipart2); //1
//    request.fields['email'] = email; //2
//    request.fields['nama_keluarga'] = namakeluarga; //3
//    request.fields['no_hp_keluarga'] = no_hp_keluarga; //3
//    request.fields['hubungan_keluarga'] = hubungan_keluarga;
//    request.fields['nama_bank'] = namabank;
//    request.fields['no_rek'] = norek;
//
//    final response = await request.send();
//
//    if (response.statusCode == 200) {
//      print("Image Uploaded");
//
//      Toast.show("Pendaftaran  Berhasil !!", context,
//          duration: 3, gravity: Toast.BOTTOM);
//
//      //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => Login(),));
////      Navigator
////          .of(context)
////          .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => Login()));
//
//      Navigator.of(context).pushReplacementNamed(SIGN_IN);
//    } else {
//      print("Upload Failed");
//    }
//    return response.statusCode;
  }

  @override
  Future edit_pendidikan(
      String email,
      String universitas,
      String tingkatpendidikan,
      String jurusan,
      String ipk,
      String tahunmasuk,
      String tahunkeluar) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/edit_pendidikan", body: {
      'email': email,
      'tingkatpendidikan': tingkatpendidikan,
      'universitas': universitas,
      'jurusan': jurusan,
      'ipk': ipk,
      'tahunmasuk': tahunmasuk,
      'tahunlulus': tahunkeluar,
    });
    // log(jurusan);
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future gantidatadiri1(String email, String nama, String tmp_lahir,
      String tgl_lahir, context) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/edit_datadiriprofil", body: {
      'email': email,
      'nama': nama,
      'tmp_lahir': tmp_lahir,
      'tgl_lahir': tgl_lahir,
    });

    print("${tmp_lahir}");
    print("${email}");
    print("${nama}");
    print("${tgl_lahir}");
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future gantipp(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/gantipp"));
    request.files.add(multipart);
    request.fields['email'] = email; //2

    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(email);
      print(profilepic);
      print("Image Uploaded");
      Toast.show("Success Upload", context, duration: 3, gravity: Toast.BOTTOM);

      //Navigator.pop(context);
    } else {
      print("Upload Failed");
      Toast.show("Gagal Upload", context, duration: 3, gravity: Toast.BOTTOM);
      //Navigator.pop(context);
    }
    return response.statusCode;
  }

  @override
  Future pengalamankerja(
      String employee_id,
      String namapekerjaan,
      String industri,
      String kerjaposisi,
      String levelpekerjaan,
      String lokasi,
      String gaji,
      String tanggal_mulai,
      String tanggal_berhenti,
      String masihbekerjadisini,
      String deskripsipekerjaan,
      String fungsikerja) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/tambah_pengalaman_kerja", body: {
      'employee_id': employee_id,
      'posisi': kerjaposisi,
      'jenjang_career_id': levelpekerjaan,
      'nama_perusahaan': namapekerjaan,
      'industri_id': industri,
      'lokasi': lokasi,
      'masih_bekerja': masihbekerjadisini,
      'tgl_berhenti': tanggal_berhenti,
      'tgl_mulai': tanggal_mulai,
      'fungsi_kerja_id': fungsikerja,
      'gaji': gaji,
      'deskripsi_pekerjaan': deskripsipekerjaan,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future pengalamanorg(String employee_id, String namaorg, String jabatan,
      String mulaimenjabat, String selesaimenjabat) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/tambah_pengalaman_org", body: {
      'employee_id': employee_id,
      'nama_organisasi': namaorg,
      'jabatan': jabatan,
      'mulai': mulaimenjabat,
      'akhir': selesaimenjabat,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future gantibk(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_bk"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future ganticv(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_cv"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future gantiijazah(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_ijazah"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future gantikk(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_kk"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future gantiktp(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_ktp"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future hapus_pengalaman_kerja(String id) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/hapus_pengalaman_kerja", body: {
      'id': id,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    //print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future hapus_pengalaman_org(String id) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/hapus_pengalaman_org", body: {
      'id': id,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    //print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future edit_pengalaman_kerja(
      String id,
      String namapekerjaan,
      String industri,
      String kerjaposisi,
      String levelpekerjaan,
      String lokasi,
      String gaji,
      String tanggal_mulai,
      String tanggal_berhenti,
      String masihbekerjadisini,
      String deskripsipekerjaan,
      String fungsikerja) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/edit_pengalaman_kerja", body: {
      'id': id,
      'posisi': kerjaposisi,
      'jenjang_career_id': levelpekerjaan,
      'nama_perusahaan': namapekerjaan,
      'industri_id': industri,
      'lokasi': lokasi,
      'masih_bekerja': masihbekerjadisini,
      'tgl_berhenti': tanggal_berhenti,
      'tgl_mulai': tanggal_mulai,
      'fungsi_kerja_id': fungsikerja,
      'gaji': gaji,
      'deskripsi_pekerjaan': deskripsipekerjaan,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future edit_pengalaman_org(String id, String nama_org, String jabatan,
      String mulai, String akhir) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/edit_pengalaman_org", body: {
      'id': id,
      'nama_organisasi': nama_org,
      'jabatan': jabatan,
      'mulai': mulai,
      'akhir': akhir,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future edit_profil_all(
      String email,
      String nik,
      String no_wa,
      String no_hp,
      String gender,
      String agama,
      String provinsi,
      String kota,
      String kodepos,
      String status_perkawinan,
      String job_parent,
      String job_child,
      String kepemilikan_kendaraan,
      String kepemilikan_sim,
      String min_gaji,
      String max_gaji,
      String os,
      String versi,
      String alamat_ktp,
      String alamat_domisili,
      String facebook,
      String instagram,
      String linkedin,
      String twitter,
      String sumber,
      String nama_keluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      String nama_bank,
      String no_rek,
      String no_kk,
      String minat_lokasi) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/edit_profil_all", body: {
      'email': email,
      'nik': nik,
      'no_wa': no_wa,
      'no_hp': no_hp,
      'gender': gender,
      'agama': agama,
      'provinsi': provinsi,
      'kota': kota,
      'kodepos': kodepos,
      'status_perkawinan': status_perkawinan,
      'job_parent': job_parent,
      'job_child': job_child,
      'kepemilikan_kendaraan': kepemilikan_kendaraan,
      'kepemilikan_sim': kepemilikan_sim,
      'min_gaji': min_gaji,
      'max_gaji': max_gaji,
      'os': "Android",
      'versi': versi,
      'alamat_ktp': alamat_ktp,
      'alamat_domisili': alamat_domisili,
      'facebook': facebook,
      'instagram': instagram,
      'linkedin': linkedin,
      'twitter': twitter,
      'sumber': sumber,
      'nama_keluarga': nama_keluarga,
      'hubungan_keluarga': hubungan_keluarga,
      'no_hp_keluarga': no_hp_keluarga,
      'nama_bank': nama_bank,
      'no_rek': no_rek,
      'no_kk': no_kk,
      'minat_lokasi': minat_lokasi,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future lupakatasandi(String email) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/lupakatasandi", body: {
      'email': email,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future gantipassword(String email, password_lama, password_baru) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/gantipassword", body: {
      'email': email,
      'password_lama': password_lama,
      'password_baru': password_baru,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }



  @override
  Future ganti_ttd(String email, String id_dw_active, String hariini,
      File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/edit_ttd"));
    request.files.add(multipart);
    request.fields['email'] = email; //2
    request.fields['id_dw_active'] = id_dw_active;
    request.fields['hariini'] = hariini;

    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      print("Upload Failed");
    }
    return response.statusCode;
  }

  @override
  Future absensi_dw(String id_dw_active, qrcode) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/absensi", body: {
      'id': id_dw_active,
      'qr_code': qrcode,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future player_id(String email, String player_id) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/player_id", body: {
      'email': email,
      'player_id': player_id,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future pulangtelat(String id_dw_active, String alasanpulang) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/absen_pulangtelat", body: {
      'id_dw_active': id_dw_active,
      'alasanpulang': alasanpulang,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future tariksaldo(String id_employee, String jumlah) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/tariksaldo", body: {
      'id_employee': id_employee,
      'jumlah': jumlah,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future LatLang(String email, double lat, double long) async {
    ModelRegister listData;

    try {
      final response = await http
          .post(NetworkConfig().baseUrl + "apps/updateLatLong", body: {
        'email': email,
        'lat': '${lat}',
        'long': '${long}',
      });
      final jsondata = jsonDecode(response.body);
      listData = ModelRegister.fromJson(jsondata);
      print("lat lat ling${lat}${long}");
    } catch (e) {}
    return listData;
  }

  @override
  Future rekamvideo(String email, File profilepic, context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/rekamvideo"));
    request.files.add(multipart);
    request.fields['email'] = email; //2

    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
      //Navigator.pop(context);
    } else {
      print("Upload Failed");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      //Navigator.pop(context);
    }
    return response.statusCode;
  }

  @override
  Future pengajuan_lembur(
      String id_employee,
      String tanggal_pengajuan,
      String jam_masuk,
      String menit_masuk,
      String jam_keluar,
      String menit_keluar,
      String id_active,
      File profilepic,
      context) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(profilepic.openRead()));
    //read size image
    var length = await profilepic.length();
    //multipart
    var multipart = http.MultipartFile('profilepic', stream, length,
        filename: profilepic.path);
    var request = http.MultipartRequest(
        'POST', Uri.parse(ConstanUrl().baseUrl + "apps/pengajuan_lembur"));
    request.files.add(multipart);
    request.fields['id_employee'] = id_employee; //2
    request.fields['tanggal'] = tanggal_pengajuan; //2
    request.fields['jam_masuk'] = jam_masuk; //2
    request.fields['menit_masuk'] = menit_masuk; //2
    request.fields['jam_keluar'] = jam_keluar; //2
    request.fields['menit_keluar'] = menit_keluar; //2
    request.fields['id_active'] = id_active; //2

    final response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);

      Navigator.pop(context);
    } else {
      print("Upload Failed");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      //Navigator.pop(context);
    }
    return response.statusCode;
  }

  @override
  Future Jawaban_soal_learning(
      String email,
      String jawaban,
      String id_soal,
      String kunci_jawaban,
      String jenis_status,
      String id_materi,
      String skor,
      String insert_id) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/simpan_jawaban", body: {
      'email': email,
      'jawaban': jawaban,
      'id_soal': id_soal,
      'kunci_jawaban': kunci_jawaban,
      'jenis_status': jenis_status,
      'id_materi': id_materi,
      'skor': skor,
      'insert_id': insert_id,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);

    return listData;
  }

  @override
  Future regist_kode_learning(
      String email, String activasi, String kode_referal) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/kodereferal", body: {
      'email': email,
      'kode_referal': kode_referal,
      'activasi': activasi,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future aturanmain_learning(
      String email, String id_jenis, String id_materi) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps_learning/test", body: {
      'email': email,
      'id_jenis': id_jenis,
      'id_materi': id_materi,
    });
    final jsondata = jsonDecode(response.body);
    AturanmainModel listData = AturanmainModel.fromJson(jsondata);
    print("aturanmain${jsondata}");
    return listData;
  }

  @override
  Future akses_mater_learning(
      String email, String id_modul, String id_materi) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/akses_materi", body: {
      'email': email,
      'id_modul': id_modul,
      'id_materi': id_materi,
    });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future edit_datadiri_dw(
      String email,
      String nik,
      String tmp_lahir,
      String tgl_lahir,
      String gender,
      String agama,
      String province_id,
      String city_id,
      String alamat_ktp,
      String alamat_domisili,
      String kodepos,
      String statusperkawinan,
      String namakeluarga,
      String hubungan_keluarga,
      String no_hp_keluarga,
      String namabank,
      String norek) async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps/edit_data_dw", body: {
      'email': email,
      'nik': nik,
      'tmp_lahir': tmp_lahir,
      'tgl_lahir': tgl_lahir,
      'gender': gender,
      'agama': agama,
      'province_id': province_id,
      'city_id': city_id,
      'alamat_ktp': alamat_ktp,
      'alamat_domisili': alamat_domisili,
      'kodepos': kodepos,
      'statusperkawinan': statusperkawinan,
      'nama_keluarga': namakeluarga,
      'no_hp_keluarga': no_hp_keluarga,
      'hubungan_keluarga': hubungan_keluarga,
      'nama_bank': namabank,
      'no_rek': norek,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future overview(String email, String aktivasi, String kode_refferal) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps_learning/aktifkan_akun_learning",
        body: {
          'email': email,
          'activasi': aktivasi,
          'kode_referal': kode_refferal,
        });
    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future getPost() async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps_learning/learn", body: {
      'jenis_access': "1",
      'id_materi': "37",
      'id1': "1",
      'email': "ajie.darmawan106@gmail.com",
    });

//    final response = await http.get("https://jsonplaceholder.typicode.com/posts/1");
//    posts = SoalModul.fromJson(jsonDecode(response.body));
//    return posts;

    posts = SoalModul.fromJson(jsonDecode(response.body));
    print("registrasi${posts}");
    return posts;
  }

  @override
  Future Katalog(
      String email,
      String kode_referral,
      String level,
      String posisi,
      String penempatan,) async {
    final response =
    await http.post(NetworkConfig().baseUrl + "apps_learning/add_recomendation", body: {
      'email': email,
      'kode_referral': kode_referral,
      'level': level,
      'posisi': posisi,
      'penempatan': penempatan,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future saveLocation(
      String email,
      String lat,
      String long,) async {
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/add_location", body: {
      'email': email,
      'latitude': lat,
      'longitude': long,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future reSendOTPCode(
      String email,) async {
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/resend_otp", body: {
      'email': email,
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }

  @override
  Future savePlayerId(
      String email,String playerId) async {
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/save_playerId", body: {
      'email': email,
      'player_id':playerId
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);
    // print("registrasi${jsondata}");
    return listData;
  }
}
