import 'package:equatable/equatable.dart';

class FlipCardModel extends Equatable {
  final String? id;
  final String? name;
  final bool? isFront;
  final bool? isEnable;
  final bool? isVisible;
  final String? path;

  const FlipCardModel({this.id, this.name, this.isFront, this.isEnable, this.isVisible, this.path});

  FlipCardModel copyWith({
    String? id,
    String? name,
    bool? isFront,
    bool? isEnable,
    bool? isVisible,
    String? path,
  }) {
    return FlipCardModel(
        id: id ?? this.id,
        name: name ?? this.name,
        isFront: isFront ?? this.isFront,
        isEnable: isEnable ?? this.isEnable,
        isVisible: isVisible ?? this.isVisible,
        path: path ?? this.path
        );
  }

  static List<FlipCardModel> getCards() {
    final List<FlipCardModel>  list = [
      const FlipCardModel(id: "1", name: "atenea", isFront: false, isEnable: true,isVisible: true,path: "assets/atenea.jpeg"),
      const FlipCardModel(id: "2", name: "atenea", isFront: false, isEnable: true,isVisible: true,path: "assets/atenea.jpeg"),
      const FlipCardModel(id: "3", name: "creta", isFront: false, isEnable: true,isVisible: true,path: "assets/creta.jpeg"),
      const FlipCardModel(id: "4", name: "creta", isFront: false, isEnable: true,isVisible: true,path: "assets/creta.jpeg"),
      // const FlipCardModel(id: "5", name: "darwin", isFront: false, isEnable: true,isVisible: true,path: "assets/darwin.jpeg"),
      // const FlipCardModel(id: "6", name: "darwin", isFront: false, isEnable: true,isVisible: true,path: "assets/darwin.jpeg"),
      // const FlipCardModel(id: "7", name: "flor", isFront: false, isEnable: true,isVisible: true,path: "assets/flor.jpeg"),
      // const FlipCardModel(id: "8", name: "flor", isFront: false, isEnable: true,isVisible: true,path: "assets/flor.jpeg"),
      // const FlipCardModel(id: "9", name: "frodo", isFront: false, isEnable: true,isVisible: true,path: "assets/frodo.jpeg"),
      // const FlipCardModel(id: "10", name: "frodo", isFront: false, isEnable: true,isVisible: true,path: "assets/frodo.jpeg"),
      // const FlipCardModel(id: "11", name: "gaia", isFront: false, isEnable: true,isVisible: true,path: "assets/gaia.jpeg"),
      // const FlipCardModel(id: "12", name: "gaia", isFront: false, isEnable: true,isVisible: true,path: "assets/gaia.jpeg"),
      // const FlipCardModel(id: "13", name: "galilea", isFront: false, isEnable: true,isVisible: true,path: "assets/galilea.jpeg"),
      // const FlipCardModel(id: "14", name: "galilea", isFront: false, isEnable: true,isVisible: true,path: "assets/galilea.jpeg"),
      // const FlipCardModel(id: "15", name: "gorda", isFront: false, isEnable: true,isVisible: true,path: "assets/gorda.jpeg"),
      // const FlipCardModel(id: "16", name: "gorda", isFront: false, isEnable: true,isVisible: true,path: "assets/gorda.jpeg"),
      // const FlipCardModel(id: "17", name: "koda", isFront: false, isEnable: true,isVisible: true,path: "assets/koda.jpeg"),
      // const FlipCardModel(id: "18", name: "koda", isFront: false, isEnable: true,isVisible: true,path: "assets/koda.jpeg"),
      // const FlipCardModel(id: "19", name: "lucky", isFront: false, isEnable: true,isVisible: true,path: "assets/lucky.jpeg"),
      // const FlipCardModel(id: "20", name: "lucky", isFront: false, isEnable: true,isVisible: true,path: "assets/lucky.jpeg"),
      // const FlipCardModel(id: "21", name: "matilda", isFront: false, isEnable: true,isVisible: true,path: "assets/matilda.jpeg"),
      // const FlipCardModel(id: "22", name: "matilda", isFront: false, isEnable: true,isVisible: true,path: "assets/matilda.jpeg"),
      // const FlipCardModel(id: "23", name: "negra", isFront: false, isEnable: true,isVisible: true,path: "assets/negrita2.jpeg"),
      // const FlipCardModel(id: "24", name: "negra", isFront: false, isEnable: true,isVisible: true,path: "assets/negrita2.jpeg"),
      // const FlipCardModel(id: "25", name: "rocky", isFront: false, isEnable: true,isVisible: true,path: "assets/rocky.jpeg"),
      // const FlipCardModel(id: "26", name: "rocky", isFront: false, isEnable: true,isVisible: true,path: "assets/rocky.jpeg"),
      // const FlipCardModel(id: "27", name: "trementina", isFront: false, isEnable: true,isVisible: true,path: "assets/trementina.jpeg"),
      // const FlipCardModel(id: "28", name: "trementina", isFront: false, isEnable: true,isVisible: true,path: "assets/trementina.jpeg"),
      // const FlipCardModel(id: "29", name: "vangogh", isFront: false, isEnable: true,isVisible: true,path: "assets/vangogh.jpeg"),
      // const FlipCardModel(id: "30", name: "vangogh", isFront: false, isEnable: true,isVisible: true,path: "assets/vangogh.jpeg"),
      // const FlipCardModel(id: "31", name: "cuchara", isFront: false, isEnable: true,isVisible: true,path: "assets/cuchara.jpeg"),
      // const FlipCardModel(id: "32", name: "cuchara", isFront: false, isEnable: true,isVisible: true,path: "assets/cuchara.jpeg"),

    ];
    list.shuffle();
    return list;
  }

  @override
  String toString() {
    return "id:$id  name:$name isFront:$isFront isEnable:$isEnable isVisible:$isVisible";
  }

  @override
  List<Object?> get props => [
        id,
        name,
        isFront,
        isEnable,
        isVisible
      ];
}
