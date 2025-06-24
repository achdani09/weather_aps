import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Function(String) onCitySelected; 

  const SettingsPage({Key? key, required this.onCitySelected}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _cityController = TextEditingController();
  String _savedCity = '';

  @override
  void initState() {
    super.initState();
    _loadSavedCity();
  }

  _loadSavedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedCity = prefs.getString('last_city') ?? 'Jakarta';
      _cityController.text = _savedCity;
    });
  }

  _saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_city', city);
    setState(() {
      _savedCity = city;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan & Lokasi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lokasi Tersimpan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _savedCity,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            // Anda bisa menambahkan opsi pengaturan lain di sini,
            // seperti mengubah satuan suhu (Celcius/Fahrenheit)
            // atau preferensi notifikasi.
            const Text(
              'Opsi Lain:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.thermostat_outlined),
              title: const Text('Satuan Suhu'),
              trailing: const Text('°C'), // Atau dropdown untuk °F
              onTap: () {
                // Handle perubahan satuan suhu
              },
            ),
          ],
        ),
      ),
    );
  }
}