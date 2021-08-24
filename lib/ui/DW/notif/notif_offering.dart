import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/models/Model_Profile2.dart';
import 'package:gaweid2/model/dw/model_terms.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/notif/ttd.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class notif_ofer extends StatefulWidget {
  @override
  _notif_oferState createState() => _notif_oferState();
}

class _notif_oferState extends State<notif_ofer> {
  BaseEndPoint network = NetworkProvider();

  String no_hp,
      tgl_lahir,
      universitas,
      picture,
      profile_power,
      tahun_keluar,
      ipk,
      tahun_masuk,
      kota,
      provinsi,
      nik,
      nohp,
      no_wa,
      mingaji,
      maxgaji,
      alamatktp,
      alamatdomisli,
      jurusan,
      tgl_lahir2,
      nama,
      agama,
      kodepos,
      kepemilikan_kendaraan,
      kepemilikan_sim,
      pendidikan,
      fb,
      instagram,
      twitter,
      sumber,
      linkedin,
      hubungan_keluarga,
      nama_keluarga,
      no_hp_keluarga,
      gender,
      kk,
      bk,
      ktp,
      cv,
      ijazah,
      tmplahir,
      kepemilikanhp,
      os,
      jobParent,
      jobChild,
      no_rek,
      id_dw_kontrak,
      nama_bank,
      joborder,
      upah,
      mulai_kerja,
      selesai_kerja,ttd,client,penempatan,hariini,hariini2,
      status_perkawinan,tanggal_gajian,lokasi_penempatan;

  var loading = false;

  Future getProfile(employee_id) async {
    loading = false;
    final jsonString =
        await http.post(NetworkConfig().baseUrl + "apps/profile", body: {
      'employee_id': employee_id,
    });
    final jsonData = jsonDecode(jsonString.body);
    Sample sample = Sample.fromJson(jsonData[0]);
    setState(() {
      loading = true;

      no_rek = sample.no_rek.toString();
      nama_bank = sample.nama_bank.toString();

      os = sample.os.toString();
      kk = sample.file_kk.toString();
      cv = sample.file_cv.toString();
      ktp = sample.file_ktp.toString();
      ijazah = sample.file_ijazah.toString();
      bk = sample.file_bk.toString();

      fb = sample.facebook.toString();
      instagram = sample.instagram.toString();
      linkedin = sample.linkedin.toString();
      instagram = sample.instagram.toString();
      twitter = sample.twitter.toString();
      sumber = sample.sumber.toString();

      jobParent = sample.jobParent.toString();
      jobChild = sample.jobChild.toString();

      sumber = sample.sumber.toString();

      hubungan_keluarga = sample.hubungan_keluarga.toString();
      nama_keluarga = sample.nama_keluarga.toString();
      no_hp_keluarga = sample.no_hp_keluarga.toString();

      kepemilikan_kendaraan = sample.kendaraan.toString();
      kepemilikan_sim = sample.sim.toString();
      provinsi = sample.provinceId.toString();

      provinsi = sample.provinceId.toString();
      gender = sample.gender.toString();
      status_perkawinan = sample.statusPerkawinan.toString();
      agama = sample.agama.toString();
      kodepos = sample.kodepos.toString();

      kepemilikanhp = sample.kepemilikanHp.toString();

      nik = sample.nik.toString();
      nama = sample.nama.toString();
      nohp = sample.hp.toString();
      no_wa = sample.nomorTelepon.toString();
      mingaji = sample.minGaji.toString();
      maxgaji = sample.maxGaji.toString();
      alamatktp = sample.alamatKtp.toString();
      alamatdomisli = sample.alamatDomisili.toString();
      jurusan = sample.jurusanId.toString();
      pendidikan = sample.pendidikanId.toString();

      kota = sample.cityId.toString();
      tmplahir = sample.tmpLahir.toString();
      tgl_lahir =
          sample.tglLahir.toString() == null ? "" : sample.tglLahir.toString();
      tgl_lahir2 = sample.tglLahir2.toString() == null
          ? ""
          : sample.tglLahir2.toString();
      universitas = sample.universitas.toString() == null
          ? ""
          : sample.universitas.toString();
      ipk = sample.ipk.toString() == null ? "" : sample.ipk.toString();
      tahun_masuk =
          sample.thnMasuk.toString() == null ? "" : sample.thnMasuk.toString();
      tahun_keluar =
          sample.thnLulus.toString() == null ? "" : sample.thnLulus.toString();
      picture = sample.picture.toString();
      profile_power = sample.profilePower.toString() == null
          ? ""
          : sample.profilePower.toString();
    });
  }

  Future getTerms(employee_id) async {
    loading = false;
    final jsonString =
        await http.post(NetworkConfig().baseUrl + "apps/dw_term", body: {
      'id_employee': employee_id.toString(),
    });
    final jsonData = jsonDecode(jsonString.body);
    Terms terms = Terms.fromJson(jsonData[0]);
    setState(() {
      id_dw_kontrak = terms.id.toString();
      joborder = terms.job_order.toString();
      upah = terms.upah.toString();
      mulai_kerja = terms.mulai_kerja.toString();
      selesai_kerja = terms.selesai_kerja.toString();
      ttd = terms.ttd.toString();
      client = terms.client.toString();
      penempatan = terms.penempatan.toString();
      hariini = terms.hariiini.toString();
      hariini2 = terms.hariini2.toString();
      tanggal_gajian = terms.tanggal_gajian.toString();
      lokasi_penempatan = terms.lokasi_penempatan_client.toString();

    });
  }

  bool status_check = false;
  void check_ttd() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/validasi_ttd_dw", body: {
      'id_dw_active': id_dw_kontrak.toString(),
    });
    ModelCheck listData = modelCheckFromJson(response.body);

    print("printlistdata${listData}");

    if (listData.status == 200) {
      print('Sudah TTD');
      setState(() {
        status_check = false;
      });
    } else {
      print('Belum TTD');
      setState(() {
        status_check = true;
      });
    }
  }

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;

  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        globalLevel = sessionManager.level;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile(globalid_employee);
    getPreferences();
    getTerms(globalid_employee);
    //check_ttd();
  }

  @override
  Widget build(BuildContext context) {
    getProfile(globalid_employee);
    getTerms(globalid_employee);
    check_ttd();
    print("status_check ${status_check}");
    print(globalid_employee);

    // print("joborder${joborder}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id ${id_dw_kontrak}"),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PT. SWAKARYA INSAN MANDIRI",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "PERJANJIAN KERJA HARIAN LEPAS",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "No. : ${joborder == null ? "" : joborder}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Perjanjian Kerja Harian Lepas ini  (selanjutnya disebut “PERJANJIAN”) dibuat dan ditandatangani pada hari ini (${hariini2}) oleh dan di antara :"),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "I. PUTU ERMAN SUGIANTO, dalam hal ini bertindak selaku GENERAL MANAGER,"
                      "oleh karena itu sah bertindak untuk dan atas nama PT SWAKARYA INSAN MANDIRI "
                      "berkedudukan di Jakarta Selatan dan beralamat di GEDUNG 18 OFFICE PARK "
                      "LANTAI 17 UNIT 17 F2. JL TB SIMATUPANG NO.18 KEL. \n"
                      "KEBAGUSAN KEC.PASAR MINGGU - Jakarta Selatan 12520 Indonesia ."),
                ),
                SizedBox(height: 16),
                Text("Untuk selanjutnya disebut sebagai “Perusahaan” ."),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Nama"),
                      Text(":"),
                      Text(
                        nama == null ? "" : nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Jenis Kelamin"),
                      Text(":"),
                      Text(
                        gender == null ? "" : gender,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("TTL"),
                      Text(":"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            tmplahir == null ? "" : tmplahir,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text(" "),
                          Text(tgl_lahir == null ? "" : tgl_lahir),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Nik"),
                      Text(":"),
                      Text(
                        nik == null ? "" : nik,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Alamat Domisili"),
                      Text(":"),
                      Expanded(
                        flex: 1,
                        child: Text(
                          alamatdomisli == null ? "" : alamatdomisli,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Dalam hal ini bertindak untuk dan atas nama pribadi, selanjutnya dalam perjanjian ini disebut sebagai KARYAWAN."),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Perusahaan menerima Karyawan sebagai pekerja harian lepas yang akan ditempatkan pada perusahaan ${client} \n "
                      "(Mitra) dan mengenai hal itu para pihak setuju membuat perjanjian dengan syarat-syarat sebagai berikut"),
                ),
                Text(
                  "PASAL 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Karyawan akan bekerja untuk Perusahaan mulai tanggal ${mulai_kerja == null ? "" : mulai_kerja} dan berakhir pada tanggal  ${selesai_kerja == null ? "" : selesai_kerja}"),
                ),
                Text(
                  "PASAL 2",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "1. Perusahaan akan memberikan upah kepada Karyawan setiap hari kerja Perusahaan masuk kerja sebesar :"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Uang Pokok"),
                      Text(":"),
                      Text(
                        "Rp  ${upah == null ? "" : upah}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      Text("II"),
                      Text("Lembur"),
                      Text(":"),
                      Text("Ada"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "2.Perusahaan melakukan pembayaran Upah pada tanggal ${tanggal_gajian}  setiap bulannya setelah KARYAWAN memberikan hasil pekerjaannya, jika tanggal pada hari tersebut hari libur maka pembayaran dilakukan setelah tanggal tersebut."),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Upah Pihak Kedua diperhitungkan berdasarkan kehadiran setiap harinya pada hari kerja.."),
                ),
                Text(
                  "PASAL 3",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "1.Karyawan akan bekerja tidak lebih dari 20 hari kerja setiap bulan. Waktu kerja Karyawan ditentukan oleh Perusahaan dan Mitra, dengan mengacu pada ketentuan yang diatur dalam Pasal 77 ayat (2) Undang-Undang No.13 Tahun 2003."),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "2.Perusahaan menerapkan kebijakan Transfer Of Undertaking Protection Of Employment"),
                ),
                Text(
                  "PASAL 4",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "1. Perjanjian ini dapat berakhir apabila terdapat pelanggaran dari ketentuan peraturan perusahaan dari Perusahaan dan berakhirnya kerjasama Perusahaan dengan Mitra"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "2. Sehubungan dengan pengakhiran Perjanjian Kerja antara Perusahaan dan Karyawan, maka segala hutang Karyawan maupun kerugian yang disebabkan oleh Karyawan kepada Perusahaan dengan bukti yang sah akan diperhitungkan pelunasannya sekaligus dari hak-hak maupun sumber dana lain atas nama Karyawan"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Demikian perjanjian ini dibuat  tanpa materai sesuai dengan peraturan yang berlaku dan mempunyai kekuatan hukum yang sama"),
                ),
                Visibility(
                  visible: status_check,
                  child: Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.lightBlueAccent,
                          child: Text("TTD"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                          id: id_dw_kontrak == null
                                              ? ""
                                              : id_dw_kontrak,

                                          hariini: hariini == null
                                          ? ""
                                          : hariini,

                                          lokasi_penempatan: lokasi_penempatan == null
                                          ? ""
                                          : lokasi_penempatan,

                                        )));
                          },
                        ),
                        FlatButton(
                          color: Colors.grey,
                          child: Text("Tidak Setuju"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
