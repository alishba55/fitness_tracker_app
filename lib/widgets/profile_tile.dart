import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfileTile({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.15),
          child: const Icon(Icons.check, color: Colors.green),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}