import 'package:flutter/material.dart';
import 'bienvenida.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  void _intentarLogin(BuildContext context) {
    String usuario = _usuarioController.text;
    String contrasena = _contrasenaController.text;

    if (usuario == 'teddy@gmail.com' && contrasena == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BienvenidoPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _contrasenaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Ingresar'),
              onPressed: () => _intentarLogin(context),
            ),
          ],
        ),
      ),
    );
  }
}