import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windenergy/core/resultat/resultat.dart';
import 'package:windenergy/features/domain/repositories/eolienne_repository.dart';
import 'package:windenergy/features/domain/usecases/authentification.dart';

class MockEolienneRepository extends Mock implements EolienneRepository {}

void main() {
  late MockEolienneRepository repository;
  late Authentifier authentifier;
  late Enregistrer enregistrer;

  setUp(() {
    repository = MockEolienneRepository();
    authentifier = Authentifier(repository: repository);
    enregistrer = Enregistrer(repository: repository);
  });

  test("devrait appeler [EolienneRepository.authentifier]", () async {
    final email = "";
    final motDePasse = "";
    when(() => repository.authentifier(email, motDePasse)).thenAnswer(
      (_) async => Succes(true),
    ); // Definition du comportement simuler de EolienneRepository.authentifier

    await authentifier(email, motDePasse);

    verify(() => repository.authentifier(email, motDePasse));
  });

  test("devrait appeler [EolienneRepository.enregistrer]", () async {
    final email = "";
    final nom = "";
    final prenom = "";
    final motDePasse = "";
    when(
      () => repository.enregistrer(email, nom, prenom, motDePasse),
    ).thenAnswer(
      (_) async => Succes(true),
    ); // Definition du comportement simuler de EolienneRepository.authentifier

    await enregistrer(email, nom, prenom, motDePasse);

    verify(() => repository.enregistrer(email, nom, prenom, motDePasse));
  });
}
