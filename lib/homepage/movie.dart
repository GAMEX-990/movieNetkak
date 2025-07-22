import 'package:flutter/material.dart';

class Movie {
  final String imagePath;
  final String title;
  final String description;
  final Alignment imageAlignment;
  final String videoUrl; 
  

  Movie({
    required this.imagePath,
    required this.title,
    required this.description,
     this.imageAlignment = Alignment.center,
     required this.videoUrl, 
  });
}
