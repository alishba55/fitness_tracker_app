import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workoutName;
  final String duration;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutName,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {
        "name": "Jumping Jacks",
        "sets": "3 sets",
        "reps": "30 seconds",
      },
      {
        "name": "Squats",
        "sets": "3 sets",
        "reps": "12 reps",
      },
      {
        "name": "Push Ups",
        "sets": "3 sets",
        "reps": "10 reps",
      },
      {
        "name": "Plank",
        "sets": "3 sets",
        "reps": "30 seconds",
      },
      {
        "name": "Lunges",
        "sets": "3 sets",
        "reps": "12 reps",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.fitness_center,
                  size: 70,
                  color: Colors.white,
                ),

                const SizedBox(height: 12),

                Text(
                  workoutName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  duration,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    WorkoutInfoItem(
                      icon: Icons.timer,
                      title: "20 min",
                      subtitle: "Duration",
                    ),
                    WorkoutInfoItem(
                      icon: Icons.local_fire_department,
                      title: "150 kcal",
                      subtitle: "Burn",
                    ),
                    WorkoutInfoItem(
                      icon: Icons.fitness_center,
                      title: "5",
                      subtitle: "Exercises",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Exercises",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...exercises.map(
                (exercise) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, color: Colors.white),
                ),
                title: Text(
                  exercise["name"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${exercise["sets"]} • ${exercise["reps"]}",
                ),
                trailing: const Icon(Icons.play_circle, color: Colors.green),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$workoutName started"),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text(
              "Start Workout",
              style: TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$workoutName completed"),
                ),
              );
            },
            icon: const Icon(Icons.check_circle),
            label: const Text(
              "Mark as Completed",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const WorkoutInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}