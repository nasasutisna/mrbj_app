// To parse this JSON data, do
//
//     final scheduleSholatPerDayModel = scheduleSholatPerDayModelFromJson(jsonString);

import 'dart:convert';

ScheduleSholatPerDayModel scheduleSholatPerDayModelFromJson(String str) =>
    ScheduleSholatPerDayModel.fromJson(json.decode(str));

Jadwal jadwalModelFromJson(String str) => Jadwal.fromJson(json.decode(str));

String scheduleSholatPerDayModelToJson(ScheduleSholatPerDayModel data) =>
    json.encode(data.toJson());
String jadwalModelToJson(Jadwal data) => json.encode(data.toJson());

class ScheduleSholatPerDayModel {
  ScheduleSholatPerDayModel({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory ScheduleSholatPerDayModel.fromJson(Map<String, dynamic> json) =>
      ScheduleSholatPerDayModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.koordinat,
    required this.jadwal,
  });

  String id;
  String lokasi;
  String daerah;
  Koordinat koordinat;
  Jadwal jadwal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        lokasi: json["lokasi"],
        daerah: json["daerah"],
        koordinat: Koordinat.fromJson(json["koordinat"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
        "daerah": daerah,
        "koordinat": koordinat.toJson(),
        "jadwal": jadwal.toJson(),
      };
}

class Jadwal {
  Jadwal({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  String tanggal;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;
  DateTime date;

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        tanggal: json["tanggal"],
        imsak: json["imsak"],
        subuh: json["subuh"],
        terbit: json["terbit"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "imsak": imsak,
        "subuh": subuh,
        "terbit": terbit,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class Koordinat {
  Koordinat({
    required this.lat,
    required this.lon,
    required this.lintang,
    required this.bujur,
  });

  double lat;
  double lon;
  String lintang;
  String bujur;

  factory Koordinat.fromJson(Map<String, dynamic> json) => Koordinat(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        lintang: json["lintang"],
        bujur: json["bujur"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "lintang": lintang,
        "bujur": bujur,
      };
}
