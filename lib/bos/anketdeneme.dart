import 'package:flutter/material.dart';

class CustomSurveyOption {
  final String title;
  final String? imageUrl;

  CustomSurveyOption({required this.title, this.imageUrl});
}

class CustomSurveyWidget extends StatelessWidget {
  final List<CustomSurveyOption> options;

  const CustomSurveyWidget({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (BuildContext context, int index) {
        var option = options[index];
        return Card(
          child: ListTile(
            leading: option.imageUrl != null 
              ? CircleAvatar(
                  backgroundImage: NetworkImage(option.imageUrl!),
                )
              : null,
            title: Text('${index + 1}. ${option.title}'),
            // Additional styling and behavior goes here
          ),
        );
      },
    );
  }
}

// Usage
var surveyOptions = [
  CustomSurveyOption(title: 'Cumhuriyet Halk Partisi', imageUrl: 'https://parsefiles.back4app.com/WRA6Rjonj88lwnpOJU1jTLt7pZXl0dFRNVIyMCqH/38ad3f5f15b76a523155dd8edef5ad22_1000000034.png'),
  CustomSurveyOption(title: 'Adalet ve Kalkınma Partisi', imageUrl: 'https://parsefiles.back4app.com/WRA6Rjonj88lwnpOJU1jTLt7pZXl0dFRNVIyMCqH/38ad3f5f15b76a523155dd8edef5ad22_1000000034.png'),
  // Add more options as needed
];

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Anket'),
      ),
      body: CustomSurveyWidget(options: surveyOptions),
    ),
  ),
);
