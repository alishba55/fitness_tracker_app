import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workouts = [
      {
        "title": "Full Body Workout",
        "duration": "20 min",
        "level": "Beginner",
        "icon": Icons.fitness_center,
        "color": Colors.green,
      },
      {
        "title": "Abs Workout",
        "duration": "15 min",
        "level": "Intermediate",
        "icon": Icons.sports_gymnastics,
        "color": Colors.orange,
      },
      {
        "title": "Leg Workout",
        "duration": "25 min",
        "level": "Advanced",
        "icon": Icons.directions_run,
        "color": Colors.blue,
      },
      {
        "title": "Yoga",
        "duration": "30 min",
        "level": "Relax",
        "icon": Icons.self_improvement,
        "color": Colors.purple,
      },
      {
        "title": "Cardio",
        "duration": "18 min",
        "level": "Fat Burn",
        "icon": Icons.favorite,
        "color": Colors.red,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 45,
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Challenge",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        "Complete 3 workouts today 🔥",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workoutName: workout["title"] as String,
                            duration:
                            "${workout["duration"]} • ${workout["level"]}",
                          ),
                        ),
                      );
                    },

                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: workout["color"] as Color,
                      child: Icon(
                        workout["icon"] as IconData,
                        color: Colors.white,
                      ),
                    ),

                    title: Text(
                      workout["title"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (workout["color"] as Color)
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              workout["level"] as String,
                              style: TextStyle(
                                color: workout["color"] as Color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            workout["duration"] as String,
                          ),
                        ],
                      ),
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}