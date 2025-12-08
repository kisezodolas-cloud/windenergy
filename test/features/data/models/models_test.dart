import 'package:flutter_test/flutter_test.dart';
import 'package:windenergy/features/data/models/models.dart';
import 'package:windenergy/features/domain/entities/entities.dart';

void main() {
  group("test de conversion pour [UtilisateurModel]", () {
    test("devrait convertir un JSON en objet [UtilisateurModel]", () {
      final expected = UtilisateurModel(
        authId: "0",
        email: "test@test.com",
        idUtilisateur: 1,
        nom: "nom util",
        prenom: "prenom util",
      );

      final actual = UtilisateurModel.fromJSON({
        "authId": "0",
        "email": "test@test.com",
        "idUtilisateur": 1,
        "nom": "nom util",
        "prenom": "prenom util",
      });

      expect(actual.authId, expected.authId);
      expect(actual.idUtilisateur, expected.idUtilisateur);
      expect(actual.email, expected.email);
      expect(actual.nom, expected.nom);
      expect(actual.prenom, expected.prenom);
    });

    test("devrait convertir un [Map<String,Object>] en JSON", () {
      final expected = {
        "authId": "0",
        "email": "test@test.com",
        "idUtilisateur": 1,
        "nom": "nom util",
        "prenom": "prenom util",
      };

      final utilsateur = UtilisateurModel(
        authId: "0",
        email: "test@test.com",
        idUtilisateur: 1,
        nom: "nom util",
        prenom: "prenom util",
      );

      final actual = utilsateur.toJSON();

      expect(actual, expected);
    });
  });
}
