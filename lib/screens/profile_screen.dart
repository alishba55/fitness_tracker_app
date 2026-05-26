import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/profile_tile.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Alishba";
  String age = "24";
  String height = "5.4 ft";
  String weight = "60 kg";
  String goal = "Lose Weight";

  bool waterReminder = true;
  bool workoutReminder = false;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('userName') ?? "Alishba";
      age = prefs.getString('userAge') ?? "24";
      height = prefs.getString('userHeight') ?? "5.4 ft";
      weight = prefs.getString('userWeight') ?? "60 kg";
      goal = prefs.getString('userGoal') ?? "Lose Weight";

      waterReminder = prefs.getBool('waterReminder') ?? true;
      workoutReminder = prefs.getBool('workoutReminder') ?? false;
    });
  }

  Future<void> saveReminderSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('waterReminder', waterReminder);
    await prefs.setBool('workoutReminder', workoutReminder);
  }

  Future<void> openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );

    if (result == true) {
      loadProfileData();
    }
  }

  void openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: loadProfileData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, size: 65, color: Colors.white),
              ),

              const SizedBox(height: 15),

              Text(
                name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Beginner Fitness Journey",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Fitness Goal",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      goal,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ProfileTile(title: "Age", value: age),
              ProfileTile(title: "Height", value: height),
              ProfileTile(title: "Weight", value: weight),
              const ProfileTile(
                title: "Fitness Level",
                value: "Beginner",
              ),
              ProfileTile(title: "Goal", value: goal),

              const SizedBox(height: 20),

              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      value: waterReminder,
                      title: const Text("Water Reminder"),
                      subtitle: const Text(
                        "Get daily water reminders",
                      ),
                      secondary: const Icon(
                        Icons.water_drop,
                        color: Colors.blue,
                      ),
                      onChanged: (value) {
                        setState(() {
                          waterReminder = value;
                        });

                        saveReminderSettings();
                      },
                    ),

                    SwitchListTile(
                      value: workoutReminder,
                      title: const Text("Workout Reminder"),
                      subtitle: const Text(
                        "Get workout notifications",
                      ),
                      secondary: const Icon(
                        Icons.fitness_center,
                        color: Colors.green,
                      ),
                      onChanged: (value) {
                        setState(() {
                          workoutReminder = value;
                        });

                        saveReminderSettings();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                  title: const Text("Edit Profile"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: openEditProfile,
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                  title: const Text("Settings"),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: openSettings,
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.green,
                  ),
                  title: const Text("App Version"),
                  trailing: const Text(
                    "1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}