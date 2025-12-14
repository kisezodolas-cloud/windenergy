import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:windenergy/features/presentation/pages/liste_eoliennes.dart';
import 'package:windenergy/features/presentation/widgets/logo.dart';
import 'package:windenergy/features/presentation/widgets/windenergy_button.dart';
import 'package:windenergy/features/presentation/widgets/windenergy_textfield.dart';
import 'package:windenergy/ui/couleurs.dart';

class AuthentificationPage extends StatefulWidget {
  const AuthentificationPage({super.key});

  @override
  State<AuthentificationPage> createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  final supabase = Supabase.instance.client;
  bool _isLogin = true;
  bool _loading = false;

  final _emailController = TextEditingController();
  final _motDePasseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      if (_isLogin) {
        await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _motDePasseController.text,
        );
      } else {
        await supabase.auth.signUp(
          email: _emailController.text,
          password: _motDePasseController.text,
        );
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ListeEoliennesPage()),
        );
      }
    } on AuthApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message), backgroundColor: couleurAlerte),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Une erreur inattendue s'est produite")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(20),
          color: couleurFond,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Logo(),
              SizedBox(height: 50),
              WindenergyTextField(
                controller: _emailController,
                prefixIcon: Icon(Icons.email, color: couleurPrincipale),
                hintText: "Veuillez entrer votre Email",
                labelText: "Email",
              ),
              SizedBox(height: 20),
              WindenergyTextField(
                controller: _motDePasseController,
                prefixIcon: Icon(Icons.lock, color: couleurPrincipale),
                hintText: "Veuillez entrer votre mot de passe",
                labelText: "Mot de Passe",
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _loading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: couleurPrincipale,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _loading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        _isLogin ? "Se Connecter" : "S'Inscrire",
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              SizedBox(height: 20),
              Text(
                "Vous n'avez pas de Compte?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: couleurPrincipale,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              WindenergyButton(
                libelle: "S'Inscrire",
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/enregistrer');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
