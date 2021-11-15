import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fast_immutable_collections/src/ilist/list_extension.dart';

import 'agenda.dart';

void main() {
  print('+++++++++++');
  Agenda agenda1 = Agenda(
      date: '2f',
      atividades: ['a', 'b'].lock.withConfig(ConfigList(cacheHashCode: false)));
  Agenda agenda2 = Agenda(
      date: '3f',
      atividades: ['d', 'c'].lock.withConfig(ConfigList(cacheHashCode: false)));
  print('agenda1.hashCode: ${agenda1.hashCode}');
  print('agenda2.hashCode: ${agenda2.hashCode}');
  print('agenda1 == agenda2: ${agenda1 == agenda2}');
  Agenda agenda3 = agenda2.copyWith();
  print(
      'agenda3 = agenda2.copyWith() -> agenda3.hashCode: ${agenda3.hashCode}');
  print('agenda2 == agenda3: ${agenda2 == agenda3}');
  Agenda agenda4 = agenda2.copy();
  print('agenda4 = agenda2.copy() -> agenda4.hashCode: ${agenda4.hashCode}');
  print('agenda2 == agenda4: ${agenda2 == agenda4}');
  // final IList<Agenda> compromissos = [
  //   agenda1,
  //   agenda2,
  // ].lock;
  // Agenda agenda = compromissos.firstWhere((element) => element.date == '2f');
  // print(agenda);
  // agenda = agenda.copyWith(atividades: ['4f']);
  // print(agenda);
  // print(compromissos);
  print('+++++++++++');
}
