import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windenergy/core/resultat/resultat.dart';
import 'package:windenergy/features/domain/repositories/eolienne_repository.dart';
import 'package:windenergy/features/domain/usecases/consulter_liste_eoliennes.dart';

class MockEolienneRepository extends Mock implements EolienneRepository {}

void main() {
  late MockEolienneRepository repository;
  late ConsulterListeEoliennes consulterListeEoliennes;

  setUp(() {
    repository = MockEolienneRepository();
    consulterListeEoliennes = ConsulterListeEoliennes(repository: repository);
  });

  test("devrait appeler [EolienneRepository.consulterListeElionnes]", () async {
    when(
      () => repository.consulterListeEoliennes(),
    ).thenAnswer((_) async => Succes(true));
    await consulterListeEoliennes();

    verify(() => repository.consulterListeEoliennes());
  });
}
