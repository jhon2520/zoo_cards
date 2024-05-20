import 'dart:convert';

class LogTimerModel {
    final List<ListElement>? list;

    LogTimerModel({
        this.list,
    });

    LogTimerModel copyWith({
        List<ListElement>? list,
    }) => 
        LogTimerModel(
            list: list ?? this.list,
        );

    factory LogTimerModel.fromRawJson(String str) => LogTimerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LogTimerModel.fromJson(Map<String, dynamic> json) => LogTimerModel(
        list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    };
}

class ListElement {
    final DateTime? dateTime;
    final String? timer;

    ListElement({
        this.dateTime,
        this.timer,
    });

    ListElement copyWith({
        DateTime? dateTime,
        String? timer,
    }) => 
        ListElement(
            dateTime: dateTime ?? this.dateTime,
            timer: timer ?? this.timer,
        );

    factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        timer: json["timer"],
    );

    Map<String, dynamic> toJson() => {
        "dateTime": dateTime?.toIso8601String(),
        "timer": timer,
    };
}
