import 'package:windenergy/features/domain/entities/entities.dart';

class UtilisateurModel extends Utilisateur {
  const UtilisateurModel({
    super.authId,
    super.idUtilisateur,
    super.email,
    super.nom,
    super.prenom,
  });

  UtilisateurModel.fromJSON(Map<String, Object> json)
    : super(
        authId: json["authId"]! as String,
        idUtilisateur: json["idUtilisateur"]! as int,
        email: json["email"]! as String,
        nom: json["nom"]! as String,
        prenom: json["prenom"]! as String,
      );

  Map<String, Object> toJSON() {
    var ret = <String, Object>{};
    ret["authId"] = authId;
    ret["idUtilisateur"] = idUtilisateur;
    ret["email"] = email;
    ret["nom"] = nom;
    ret["prenom"] = prenom;
    return ret;
  }
}

class EolienneModel extends Eolienne {}
