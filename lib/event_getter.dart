

class Event {
  final String name;
  final String address;
  final String date;
  final String starttime;
  final String endtime;
  final String description;
  final String type;
  final String promocionar;
  final String promotora;
  final String buyLink;
  final String mage;
  final String fage;
  late String promotoraId;
  final String picture;
  late double lati;
  late double longi;
  late double dis;



  Event({required this.name, required this.address, required this.date,required this.starttime,required this.endtime, required this.description, required this.type,required this.promocionar,required this.promotora,required this.buyLink,required this.mage,required this.fage, required this.picture  });

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    return Event(
      name: json['name'],
      address: json['address'],
      date: json['date'],
      starttime: json['start_time'],
      endtime: json['end_time'],
      description: json['description'],
      type: json['type'], 
      promocionar: json['promocionar'],
      promotora: json['promotora'],
      buyLink: json['buylink'],
      mage: json['male_age'],
      fage: json['fem_age'],
      picture: json['picture'],


    );
  }}
