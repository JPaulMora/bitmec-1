import 'package:json_annotation/json_annotation.dart';

part 'symptom.g.dart';

@JsonSerializable()
class Symptom {
  int id;
  int type;
  int location;
  int severity;
  String onset;
  String reported;
  String timestamp;
  int consultation;

  Symptom({
    this.id,
    this.type,
    this.location,
    this.severity,
    this.onset,
    this.reported,
    this.timestamp,
    this.consultation
  });

  factory Symptom.fromJson(json) => _$SymptomFromJson(json);

  Map toJson() => _$SymptomToJson(this);

  String formattedType() {
    switch (type) {
      case 1: return 'Ardor';
      case 2: return 'Cansancio';
      case 3: return 'Dolor';
      case 4: return 'Dormido';
      case 5: return 'Hormigueo';
      case 6: return 'Inflamación';
      case 7: return 'Nausea';
      case 8: return 'Palpitaciones';
      default: return 'No existe este tipo';
    }
  }

  String formattedLocation() {
    switch (location) {
      case 1:  return 'Cabeza';
      case 2:  return 'Frente';
      case 3:  return 'Constado de la Cabeza';
      case 4:  return 'Cuello';
      case 5:  return 'Pecho Izquierdo';
      case 6:  return 'Pecho Derecho';
      case 7:  return 'Costillas del lado Izquierdo';
      case 8:  return 'Epigastrium';
      case 9:  return 'Costillas del lado Derecho';
      case 10: return 'Abdomen Izquierdo';
      case 11: return 'Abdomen Central';
      case 12: return 'Abdomen Derecho';
      case 13: return 'Cadera Izquierda';
      case 14: return 'Área Púbica';
      case 15: return 'Cadera Derecha';
      case 16: return 'Genitales';
      case 17: return 'Hombro Izquierdo';
      case 18: return 'Hombro Derecho';
      case 19: return 'Antebrazo Izquierdo';
      case 20: return 'Antebrazo Derecho';
      case 21: return 'Codo Izquierdo';
      case 22: return 'Codo Derecho';
      case 23: return 'Brazo Izquierdo';
      case 24: return 'Brazo Derecho';
      case 25: return 'Muñeca Izquierda';
      case 26: return 'Muñeca Derecha';
      case 26: return 'Mano Izquierda';
      case 27: return 'Mano Derecha';
      case 28: return 'Muslo Izquierdo';
      case 29: return 'Muslo Derecho';
      case 30: return 'Rodilla Izquierda';
      case 31: return 'Rodilla Derecha';
      case 32: return 'Espinilla Izquierda';
      case 33: return 'Espinilla Derecha';
      case 34: return 'Patorrila Izquierda';
      case 35: return 'Patorrila Derecha';
      case 36: return 'Tobillo Izquierdo';
      case 37: return 'Tobillo Derecho';
      case 38: return 'Pie Izquierdo';
      case 39: return 'Pie Derecho';
      case 40: return 'Parte Trasera de la Cabeza';
      case 41: return 'Vértebras Cervicales';
      case 42: return 'Vértebras Tóricas';
      case 43: return 'Vértebras Lumbrares';
      case 44: return 'Nalga Izquierda';
      case 45: return 'Nalga Derecha';
      default: return 'No sea a encontrado esta parte';
    }
  }
}
