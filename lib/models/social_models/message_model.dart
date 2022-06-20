class SocialMessageModel
{
   String? senderId;
   String? reseiverId;
   var dateTime;
   String? text;
  SocialMessageModel(
  {  this.senderId,
    this.reseiverId,
    this.dateTime,
    this.text,

    }
  );
SocialMessageModel.fromjson(Map<String, dynamic> json)
{
  senderId = json['senderId'];
  reseiverId = json['reseiverId'];
  dateTime = json['dateTime'];
  text = json['text'];
}

Map<String, dynamic> toMap()
{
  return {
   'senderId': senderId,
   'reseiverId': reseiverId,
   'dateTime': dateTime,
   'text': text,
  };
}
}