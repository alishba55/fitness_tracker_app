import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int waterGlasses = 0;
  int waterGoal = 8;
  int calories = 0;
  int caloriesGoal = 2000;
  int steps = 0;
  int stepsGoal = 10000;
  int workoutStreak = 0;

  double currentWeight = 60;
  double goalWeight = 55;

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      waterGlasses = prefs.getInt('waterGlasses') ?? 0;
      waterGoal = prefs.getInt('waterGoal') ?? 8;
      calories = prefs.getInt('calories') ?? 0;
      caloriesGoal = prefs.getInt('caloriesGoal') ?? 2000;
      steps = prefs.getInt('steps') ?? 0;
      stepsGoal = prefs.getInt('stepsGoal') ?? 10000;
      workoutStreak = prefs.getInt('workoutStreak') ?? 0;
      currentWeight = prefs.getDouble('currentWeight') ?? 60;
      goalWeight = prefs.getDouble('goalWeight') ?? 55;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fitness Dashboard"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: loadDashboardData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello, Alishba 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Here is your fitness progress today",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: "Water",
                      value: "$waterGlasses / $waterGoal",
                      icon: Icons.water_drop,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardCard(
                      title: "Calories",
                      value: "$calories / $caloriesGoal",
                      icon: Icons.local_fire_department,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: "Steps",
                      value: "$steps / $stepsGoal",
                      icon: Icons.directions_walk,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardCard(
                      title: "Streak",
                      value: "$workoutStreak days",
                      icon: Icons.bolt,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: "Weight",
                      value: "${currentWeight.toStringAsFixed(1)} kg",
                      icon: Icons.monitor_weight,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardCard(
                      title: "Goal",
                      value: "${goalWeight.toStringAsFixed(1)} kg",
                      icon: Icons.flag,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tip of the Day",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Small daily progress becomes big results over time.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}