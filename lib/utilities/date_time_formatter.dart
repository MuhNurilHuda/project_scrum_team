abstract class DateTimeFormatter{
  static String toDMY(DateTime data , {String separator = "-"}){
    return "${data.day}$separator"
            "${data.month}$separator"
            "${data.year}";
  }
}