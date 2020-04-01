class EventClass {
  final int result;
  final String coordinate;
  final String creator;
  final String desc;
  final int id_event;
  final String name;
  final String place;
  final DateTime date;
  final String photo;
  final List<Tag> tags;

  EventClass({this.result, this.name, this.place, this.date,this.photo,this.coordinate,this.creator,this.desc,this.id_event,this.tags});

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