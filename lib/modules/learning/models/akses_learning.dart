class Akses_learning {
  String pretest;
  String materi;
  String posttest;
  String pre_tes_block;
  String pos_tes_block;


  Akses_learning({
    this.pretest,
    this.materi,
    this.posttest,
    this.pre_tes_block,
    this.pos_tes_block

  });
  @override
  String toString() {
    return 'Sample{name: $materi, age: $materi}';
  }

  factory Akses_learning.fromJson(Map<String, dynamic> json) {
    return Akses_learning(
      pretest: json["pretest"],
      materi: json["materi"],
      posttest: json["posttest"],
      pre_tes_block: json["pretest_block"],
      pos_tes_block: json["posttest_block"],
    );
  }
}
