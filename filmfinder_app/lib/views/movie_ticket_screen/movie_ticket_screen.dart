import 'package:flutter/material.dart';

class MovieTicketScreen extends StatefulWidget {
  const MovieTicketScreen({super.key});

  @override
  State<MovieTicketScreen> createState() => _MovieTicketScreenState();
}

class _MovieTicketScreenState extends State<MovieTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text("Movie Ticket Screen - it is not yet implemented"),
        ),
      ),
    );
  }
}
