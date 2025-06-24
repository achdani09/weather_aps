import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final Function(String) onCitySelected; // Callback untuk mengubah kota dari drawer

  const HomeDrawer({Key? key, required this.onCitySelected}) : super(key: key);

  // Widget helper untuk item tombol di Drawer
  Widget _buildDrawerItemButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[100],
          foregroundColor: Colors.blueGrey[800],
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Info BMKG\nMulti-Hazard Early Warning System',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Weather'),
            onTap: () { Navigator.pop(context); },
          ),
          ListTile(
            leading: const Icon(Icons.thermostat),
            title: const Text('Climate'),
            onTap: () { Navigator.pop(context); },
          ),
          ListTile(
            leading: const Icon(Icons.warning_amber), // Ganti jika Anda ingin ikon lain
            title: const Text('Earthquake'),
            onTap: () { Navigator.pop(context); },
          ),
          ListTile(
            leading: const Icon(Icons.radar), // Ganti jika Anda ingin ikon lain
            title: const Text('Radar'),
            onTap: () { Navigator.pop(context); },
          ),
          ListTile(
            leading: const Icon(Icons.satellite_alt), // Ganti jika Anda ingin ikon lain
            title: const Text('Satellite'),
            onTap: () { Navigator.pop(context); },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Glosarium'),
            onTap: () { Navigator.pop(context); },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Penting:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildDrawerItemButton('Mount Lewotobi weather', () {
                  Navigator.pop(context);
                  onCitySelected('Mount Lewotobi');
                }),
                _buildDrawerItemButton('Mount Marapi weather', () {
                  Navigator.pop(context);
                  onCitySelected('Mount Marapi');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}