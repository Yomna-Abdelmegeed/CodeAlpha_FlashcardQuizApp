class FlashcardModel {
  final String id;
  final String question;
  final String answer;

  const FlashcardModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
    );
  }
}
