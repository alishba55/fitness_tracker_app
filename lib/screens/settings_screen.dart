import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool waterReminder = true;
  bool workoutReminder = false;
  bool darkModeInfo = true;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      waterReminder = prefs.getBool('waterReminder') ?? true;
      workoutReminder = prefs.getBool('workoutReminder') ?? false;
      darkModeInfo = prefs.getBool('darkModeInfo') ?? true;
    });
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('waterReminder', waterReminder);
    await prefs.setBool('workoutReminder', workoutReminder);
    await prefs.setBool('darkModeInfo', darkModeInfo);
  }

  void showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$feature feature coming soon")),
    );
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All app data cleared")),
    );
  }

  void confirmClearData() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Clear all data?"),
          content: const Text(
            "This will reset your tracker, profile, goals and settings.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                clearAllData();
              },
              child: const Text("Clear"),
            ),
          ],
        );
      },
    );
  }

  Widget settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = Colors.green,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Preferences",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: waterReminder,
                  title: const Text("Water Reminder"),
                  subtitle: const Text("Daily reminder for water intake"),
                  secondary: const Icon(Icons.water_drop, color: Colors.blue),
                  onChanged: (value) {
                    setState(() {
                      waterReminder = value;
                    });
                    saveSettings();
                  },
                ),
                SwitchListTile(
                  value: workoutReminder,
                  title: const Text("Workout Reminder"),
                  subtitle: const Text("Daily reminder for workout"),
                  secondary: const Icon(
                    Icons.fitness_center,
                    color: Colors.green,
                  ),
                  onChanged: (value) {
                    setState(() {
                      workoutReminder = value;
                    });
                    saveSettings();
                  },
                ),
                SwitchListTile(
                  value: darkModeInfo,
                  title: const Text("System Dark Mode"),
                  subtitle: const Text("App follows your phone theme"),
                  secondary: const Icon(Icons.dark_mode, color: Colors.purple),
                  onChanged: (value) {
                    setState(() {
                      darkModeInfo = value;
                    });
                    saveSettings();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "App",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          settingsTile(
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            subtitle: "Read privacy information",
            onTap: () => showComingSoon("Privacy Policy"),
          ),

          settingsTile(
            icon: Icons.help,
            title: "Help & Support",
            subtitle: "Contact support",
            onTap: () => showComingSoon("Help & Support"),
          ),

          settingsTile(
            icon: Icons.info,
            title: "About App",
            subtitle: "Fitness Tracker version 1.0.0",
            onTap: () => showComingSoon("About App"),
          ),

          const SizedBox(height: 20),

          const Text(
            "Danger Zone",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 10),

          settingsTile(
            icon: Icons.delete_forever,
            title: "Clear All Data",
            subtitle: "Reset profile, tracker and goals",
            iconColor: Colors.red,
            onTap: confirmClearData,
          ),
        ],
      ),
    );
  }
}