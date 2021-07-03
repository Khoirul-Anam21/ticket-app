
class EventModel {
  final String? eventName;
  final String? mainImage;
  final String? eventDescription;
  final String? eventAddress;
  final String? eventCategory;
  int? popularity;
  final String? eventDate;
  final String? eventTime;
  int? ticketStock;
  final int? ticketPrice;
  final List<String>? imageURLs; //slider gambar
  bool? isTheEventLiked;
  bool? isFavouriteEvent;


  EventModel(
      {this.eventName,
      this.eventDescription,
      this.eventAddress,
      this.eventCategory,
      this.popularity,
      this.mainImage,
      this.eventDate,
      this.eventTime,
      this.imageURLs,
      this.ticketStock,
      this.isTheEventLiked = false,
      this.ticketPrice,
      this.isFavouriteEvent = false,
      });
}

class CategoryModel {
  bool? isHovered;
  final String? value;
  final String? logoSource;

  CategoryModel({this.value, this.isHovered, this.logoSource});
}
