import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int waterGlasses = 0;
  int waterGoal = 8;
  int calories = 0;
  int caloriesGoal = 2000;
  int steps = 0;
  int stepsGoal = 10000;
  int workoutStreak = 0;

  double bmi = 0;
  double currentWeight = 60;
  double goalWeight = 55;

  final TextEditingController waterGoalController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController caloriesGoalController = TextEditingController();
  final TextEditingController stepsGoalController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController goalWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('waterGlasses', waterGlasses);
    await prefs.setInt('waterGoal', waterGoal);
    await prefs.setInt('calories', calories);
    await prefs.setInt('caloriesGoal', caloriesGoal);
    await prefs.setInt('steps', steps);
    await prefs.setInt('stepsGoal', stepsGoal);
    await prefs.setInt('workoutStreak', workoutStreak);
    await prefs.setDouble('currentWeight', currentWeight);
    await prefs.setDouble('goalWeight', goalWeight);
  }

  Future<void> loadData() async {
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

  void updateWaterGoal() {
    if (waterGoalController.text.isNotEmpty) {
      setState(() {
        waterGoal = int.parse(waterGoalController.text);
        waterGoalController.clear();
      });

      saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Water goal updated")),
      );
    }
  }

  void addCalories() {
    if (caloriesController.text.isNotEmpty) {
      setState(() {
        calories += int.parse(caloriesController.text);
        caloriesController.clear();
      });

      saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Calories added successfully")),
      );
    }
  }

  void updateCaloriesGoal() {
    if (caloriesGoalController.text.isNotEmpty) {
      setState(() {
        caloriesGoal = int.parse(caloriesGoalController.text);
        caloriesGoalController.clear();
      });

      saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Calories goal updated")),
      );
    }
  }

  void updateStepsGoal() {
    if (stepsGoalController.text.isNotEmpty) {
      setState(() {
        stepsGoal = int.parse(stepsGoalController.text);
        stepsGoalController.clear();
      });

      saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Steps goal updated")),
      );
    }
  }

  void calculateBMI() {
    if (weightController.text.isNotEmpty && heightController.text.isNotEmpty) {
      double weight = double.parse(weightController.text);
      double heightCm = double.parse(heightController.text);
      double heightM = heightCm / 100;

      setState(() {
        bmi = weight / (heightM * heightM);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("BMI calculated successfully")),
      );
    }
  }

  void updateGoalWeight() {
    if (goalWeightController.text.isNotEmpty) {
      setState(() {
        goalWeight = double.parse(goalWeightController.text);
        goalWeightController.clear();
      });

      saveData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Goal weight updated")),
      );
    }
  }

  void completeWorkout() {
    setState(() {
      workoutStreak++;
    });

    saveData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Workout completed! Streak updated")),
    );
  }

  @override
  void dispose() {
    waterGoalController.dispose();
    caloriesController.dispose();
    caloriesGoalController.dispose();
    stepsGoalController.dispose();
    weightController.dispose();
    heightController.dispose();
    goalWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double waterProgress = waterGlasses / waterGoal;
    if (waterProgress > 1) waterProgress = 1;

    double stepProgress = steps / stepsGoal;
    if (stepProgress > 1) stepProgress = 1;

    double calorieProgress = calories / caloriesGoal;
    if (calorieProgress > 1) calorieProgress = 1;

    double weightProgress = (60 - currentWeight) / (60 - goalWeight);
    if (weightProgress < 0) weightProgress = 0;
    if (weightProgress > 1) weightProgress = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Tracker"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Water Intake",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$waterGlasses / $waterGoal glasses",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: waterProgress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    Text("${(waterProgress * 100).toInt()}% completed"),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          waterGlasses++;
                        });
                        saveData();
                      },
                      icon: const Icon(Icons.water_drop),
                      label: const Text("Add Water"),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: waterGoalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Set water goal",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: updateWaterGoal,
                      child: const Text("Update Water Goal"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Step Counter",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$steps / $stepsGoal steps",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: stepProgress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 8),
                    Text("${(stepProgress * 100).toInt()}% completed"),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          steps += 500;
                        });
                        saveData();
                      },
                      icon: const Icon(Icons.directions_walk),
                      label: const Text("Add 500 Steps"),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: stepsGoalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Set steps goal",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: updateStepsGoal,
                      child: const Text("Update Steps Goal"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.deepOrange,
                      size: 45,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Workout Streak",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "$workoutStreak days",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: completeWorkout,
                      icon: const Icon(Icons.check),
                      label: const Text("Complete Today's Workout"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Calories Tracker",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$calories / $caloriesGoal kcal",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: calorieProgress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 8),
                    Text("${(calorieProgress * 100).toInt()}% completed"),
                    const SizedBox(height: 15),
                    TextField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter calories",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: addCalories,
                      child: const Text("Add Calories"),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: caloriesGoalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Set calories goal",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: updateCaloriesGoal,
                      child: const Text("Update Calories Goal"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "BMI Calculator",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Weight (kg)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Height (cm)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: calculateBMI,
                      child: const Text("Calculate BMI"),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Your BMI: ${bmi.toStringAsFixed(1)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Weight Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Current",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${currentWeight.toStringAsFixed(1)} kg",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Goal",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "${goalWeight.toStringAsFixed(1)} kg",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: weightProgress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Text("${(weightProgress * 100).toInt()}% goal completed"),
                    const SizedBox(height: 15),
                    TextField(
                      controller: goalWeightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Set goal weight",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: updateGoalWeight,
                      child: const Text("Update Goal Weight"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (currentWeight > goalWeight) {
                            currentWeight -= 0.5;
                          }
                        });

                        saveData();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Weight progress updated"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text("Update Progress"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                setState(() {
                  waterGlasses = 0;
                  waterGoal = 8;
                  calories = 0;
                  caloriesGoal = 2000;
                  steps = 0;
                  stepsGoal = 10000;
                  workoutStreak = 0;
                  bmi = 0;
                  currentWeight = 60;
                  goalWeight = 55;
                });

                saveData();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tracker reset successfully")),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Reset Tracker"),
            ),
          ],
        ),
      ),
    );
  }
}