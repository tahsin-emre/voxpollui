import 'package:flutter/material.dart';

class PollOption {
  final String title;
  final int votes;
  final int index;

  PollOption({required this.title, required this.votes, required this.index});
}

class PollWidget extends StatefulWidget {
  final List<PollOption> pollOptions;
  final int totalVotes;

  const PollWidget(
      {super.key, required this.pollOptions, required this.totalVotes});

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  int? selectedOptionIndex;
  bool hasVoted = false;
  double votePercentage = 0.0; // Animasyon için başlangıç değeri

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.pollOptions.length,
      itemBuilder: (context, index) {
        final option = widget.pollOptions[index];
        final isSelected = selectedOptionIndex == index;

        return GestureDetector(
          onTap: () {
            if (!hasVoted) {
              setState(() {
                selectedOptionIndex = index;
                hasVoted = true; // Kullanıcı oyunu kullandı
                votePercentage = option.votes / widget.totalVotes;
              });
            }
          },
          child: Stack(
            children: [
              // Arka plan mavi bar (oy oranına göre genişleyen)
              AnimatedContainer(
                duration: const Duration(seconds: 2), // Yavaş yavaş ilerlesin
                curve: Curves.easeInOut,
                width: hasVoted
                    ? MediaQuery.of(context).size.width * votePercentage
                    : 0,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100, // Mavi arka plan rengi
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Anket seçeneği içeriği
              Container(
                height: 50,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent, // Bar ile kaplanacağı için şeffaf
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${option.index}.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (isSelected) ...[
                              const Icon(Icons.check,
                                  color: Colors.blue, size: 18),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              option.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        if (hasVoted && isSelected)
                          Row(
                            children: [
                              Text(
                                '${option.votes.toString()} Oy',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${(votePercentage * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Anket')),
      body: PollWidget(
        pollOptions: [
          PollOption(title: 'Cumhuriyet Halk Partisi', votes: 683944, index: 1),
          PollOption(
              title: 'Adalet ve Kalkınma Partisi', votes: 586512, index: 2),
          PollOption(title: 'İYİ Parti', votes: 224298, index: 3),
          PollOption(
              title: 'Milliyetçi Hareket Partisi', votes: 197535, index: 4),
          PollOption(title: 'Memleket Partisi', votes: 35964, index: 5),
          PollOption(title: 'Zafer Partisi', votes: 13592, index: 6),
        ],
        totalVotes: 1784845, // Toplam oy sayısı
      ),
    ),
  ));
}
