class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final String timestamp;

  Message(
      this.senderID,
      this.senderEmail,
      this.receiverID,
      this.message, {
        required this.timestamp,
      });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
