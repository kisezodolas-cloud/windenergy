import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windenergy/core/exceptions/exceptions.dart';
import 'package:windenergy/core/resultat/resultat.dart';
import 'package:windenergy/features/data/datasources/datasources.dart';
import 'package:windenergy/features/data/repositories/eolienne_repository_impl.dart';

class DatabaseDatasourceMock extends Mock implements DatabaseDatasource {}

void main() {
  late EolienneRepositoryImpl repositoryImpl;
  late DatabaseDatasourceMock databaseDatasource;

  setUp(() {
    databaseDatasource = DatabaseDatasourceMock();
    repositoryImpl = EolienneRepositoryImpl(databaseDatasource);
  });

  group("test de [ajouterEolienne]", () {
    test("devrait retourner [Succes]", () async {
      final String numeroSerie = "";
      when(
        () => databaseDatasource.ajouterEolienne(numeroSerie),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.ajouterEolienne(numeroSerie);

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      final String numeroSerie = "";
      when(
        () => databaseDatasource.ajouterEolienne(numeroSerie),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.ajouterEolienne(numeroSerie);

      expect(actual, Echec(message: ""));
    });
  });

  group("test s'authentifier]", () {
    test("devrait retourner [athetification reussie aec succes]", () async {
      final String email = "";
      final String motDePasse = "";
      when(
        () => databaseDatasource.authentifier(email, motDePasse),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.authentifier(email, motDePasse);

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      final String email = "";
      final String motDePasse = "";
      when(
        () => databaseDatasource.authentifier(email, motDePasse),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.authentifier(email, motDePasse);

      expect(actual, Echec(message: ""));
    });
  });
  group("cosulter etat eolienne", () {
    test("devrait consulter eolienne", () async {
      final int idEolienne = 0;
      when(
        () => databaseDatasource.consulterEtatEolienne(idEolienne),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.consulterEtatEolienne(idEolienne);

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      final int idEolienne = 0;
      when(
        () => databaseDatasource.consulterEtatEolienne(idEolienne),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.consulterEtatEolienne(idEolienne);

      expect(actual, Echec(message: ""));
    });
  });
  group("liste eolienne", () {
    test("devrait retouner la liste eolienne", () async {
      when(
        () => databaseDatasource.consulterListeEoliennes(),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.consulterListeEoliennes();

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      when(
        () => databaseDatasource.consulterListeEoliennes(),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.consulterListeEoliennes();

      expect(actual, Echec(message: ""));
    });
  });
  group("enregistrer eolienne", () {
    test("devrait enregistrer eolienne", () async {
      final String email = "";
      final String nom = "";
      final String prenom = "";
      final String motDePasse = "";
      when(
        () => databaseDatasource.enregistrer(email, nom, prenom, motDePasse),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.enregistrer(
        email,
        nom,
        prenom,
        motDePasse,
      );

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      final String email = "";
      final String nom = "";
      final String prenom = "";
      final String motDePasse = "";
      when(
        () => databaseDatasource.enregistrer(email, nom, prenom, motDePasse),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.enregistrer(
        email,
        nom,
        prenom,
        motDePasse,
      );

      expect(actual, Echec(message: ""));
    });
  });
  group("supprimer eolienne", () {
    test("devrait supprimer eolienne", () async {
      final int idEolienne = 0;
      when(
        () => databaseDatasource.supprimerEolienne(idEolienne),
      ).thenAnswer((_) async => Succes(true));

      final actual = await repositoryImpl.supprimerEolienne(idEolienne);

      expect(actual, Succes(true));
    });
    test("devrait retourner un [Echec]", () async {
      final int idEolienne = 0;
      when(
        () => databaseDatasource.supprimerEolienne(idEolienne),
      ).thenThrow(ServerException(message: ""));

      final actual = await repositoryImpl.supprimerEolienne(idEolienne);

      expect(actual, Echec(message: ""));
    });
  });
}
