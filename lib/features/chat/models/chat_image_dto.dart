class ChatImageDto {
  final List<String> images;

  ChatImageDto({
    required this.images,
  });

  ChatImageDto.fromImagesList(List<String> image) : images = image;
}
