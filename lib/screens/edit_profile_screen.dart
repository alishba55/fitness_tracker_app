import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString('userName') ?? "Alishba";
      ageController.text = prefs.getString('userAge') ?? "24";
      heightController.text = prefs.getString('userHeight') ?? "5.4 ft";
      weightController.text = prefs.getString('userWeight') ?? "60 kg";
      goalController.text = prefs.getString('userGoal') ?? "Lose Weight";
    });
  }

  Future<void> saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', nameController.text);
    await prefs.setString('userAge', ageController.text);
    await prefs.setString('userHeight', heightController.text);
    await prefs.setString('userWeight', weightController.text);
    await prefs.setString('userGoal', goalController.text);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    goalController.dispose();
    super.dispose();
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 65, color: Colors.white),
            ),

            const SizedBox(height: 25),

            buildTextField(
              label: "Name",
              icon: Icons.person,
              controller: nameController,
            ),

            buildTextField(
              label: "Age",
              icon: Icons.cake,
              controller: ageController,
            ),

            buildTextField(
              label: "Height",
              icon: Icons.height,
              controller: heightController,
            ),

            buildTextField(
              label: "Weight",
              icon: Icons.monitor_weight,
              controller: weightController,
            ),

            buildTextField(
              label: "Fitness Goal",
              icon: Icons.flag,
              controller: goalController,
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: saveProfileData,
              icon: const Icon(Icons.save),
              label: const Text(
                "Save Profile",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}