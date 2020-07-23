class EventClass {
  final int result;
  final String creator;
  final int id_event;
  final EventFollowList followList;

  final String coordinate;
  final String desc;
  final String name;
  final String place;
  final Address address;
  final DateTime startDate;
  final DateTime endDate;
  final String photo;
  final String link;
  final double price;
  final List<Tag> tags;
  final bool trusted;

  EventClass( {this.trusted = false, this.link, this.price, this.result, this.name, this.place, this.address, this.startDate, this.endDate, this.photo,this.coordinate,this.creator,this.desc,this.id_event,this.tags, this.followList});

}

class EventFollowList{
  final List<String> displaiedAccount;
  final int numberofFollow;

  EventFollowList(this.displaiedAccount, this.numberofFollow);

}

class Address {
  final String number;
  final String address;

  Address({this.number="snc", this.address});
}

class Tag {
  final String tag;

  Tag({this.tag});
}

String toShortMonth(int number){
  switch (number) {
    case 1:
      return "Gen";
      break;
    case 2:
      return "Feb";
      break;
    case 3:
      return "Mar";
      break;
    case 4:
      return "Apr";
      break;
    case 5:
      return "Mag";
      break;
    case 6:
      return "Giu";
      break;
    case 7:
      return "Lug";
      break;
    case 8:
      return "Ago";
      break;
    case 9:
      return "Set";
      break;
    case 10:
      return "Ott";
      break;
    case 11:
      return "Nov";
      break;
    case 12:
      return "Dic";
      break;
    default:
      return "Mese";
  }
}

String toLongMonth(int number){
  switch (number) {
    case 1:
      return "Gennaio";
      break;
    case 2:
      return "Febbraio";
      break;
    case 3:
      return "Marzo";
      break;
    case 4:
      return "Aprile";
      break;
    case 5:
      return "Maggio";
      break;
    case 6:
      return "Giugno";
      break;
    case 7:
      return "Luglio";
      break;
    case 8:
      return "Agosto";
      break;
    case 9:
      return "Settembre";
      break;
    case 10:
      return "Ottobre";
      break;
    case 11:
      return "Novembre";
      break;
    case 12:
      return "Dicembre";
      break;
    default:
      return "Mese";
  }
}