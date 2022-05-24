class Comics {
  Comics(
      {this.number,
      this.day,
      this.month,
      this.year,
      this.link,
      this.news,
      this.safeTitle,
      this.transcript,
      this.img,
      this.title});

  int? number;
  String? month;
  String? day;
  String? year;
  String? link;
  String? news;
  String? safeTitle;
  String? transcript;
  String? img;
  String? title;

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
        number: json['num'] ??= null,
        month: json['month'] ??= null,
        day: json['day'] ??= null,
        year: json['year'] ??= null,
        link: json['link'] ??= null,
        news: json['news'] ??= null,
        safeTitle: json['safe_title'] ??= null,
        transcript: json['transcript'] ??= null,
        img: json['img'] ??= null,
        title: json['title'] ??= null,
      );

  Map<String, dynamic> toJson() => {
        "num": number ??= null,
        'month': month ??= null,
        'day': day ??= null,
        'year': year ??= null,
        'link': link ??= null,
        'news': news ??= null,
        "safe_title": safeTitle ??= null,
        'transcript': transcript ??= null,
        'img': img ??= null,
        'title': title ??= null,
      };
}
