import 'package:flutter/material.dart';
import 'bienvenida.dart';

class QuejasPage extends StatefulWidget {
  @override
  _QuejasPageState createState() => _QuejasPageState();
}

class _QuejasPageState extends State<QuejasPage> {
  final TextEditingController _aliasController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _quejaController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedLugar;

  final List<String> _lugares = [
    'La Paz - Murillo',
    'Cochabamba - Cercado',
    'Santa Cruz - Andrés Ibáñez',
    // Añade más opciones según sea necesario
  ];

  void _mostrarConfirmacion(BuildContext context) {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Queja Registrada'),
          content: Text('Su queja ha sido registrada exitosamente'),
          actions: <Widget> [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
                _limpiarFormulario();
              }
            )
          ],
        );
      } 
    );
  }

  void _limpiarFormulario() {
    _aliasController.clear();
    _emailController.clear();
    _quejaController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedLugar = null;
    });
  }

  void _enviarQueja(BuildContext context) {
    String alias = _aliasController.text;
    String email = _emailController.text;
    String queja = _quejaController.text;

    if (alias.isNotEmpty && queja.isNotEmpty && email.isNotEmpty && _selectedLugar != null) {
      // Aquí podrías procesar la queja (por ejemplo, enviarla a un servidor)
      _mostrarConfirmacion(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Quejas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _aliasController,
              decoration: InputDecoration(
                labelText: 'Alias',
                hintText: 'Ingrese su Alias',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Ingrese su Email',
              ),
            ),
            SizedBox(height: 12.0),
            ListTile(
              title: Text("Fecha del hecho"),
              subtitle: Text("${_selectedDate.toLocal()}".split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 12.0),
            DropdownButtonFormField<String>(
              value: _selectedLugar,
              decoration: InputDecoration(
                labelText: 'Departamento y Provincia',
              ),
              items: _lugares.map((String lugar) {
                return DropdownMenuItem<String>(
                  value: lugar,
                  child: Text(lugar),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLugar = newValue;
                });
              },
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _quejaController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Queja',
                hintText: 'Describa su queja aquí',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Enviar Queja'),
              onPressed: () => _enviarQueja(context),
            ),
          ],
        ),
      ),
    );
  }
}