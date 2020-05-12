//Just getting the necessary info for the project.

class Unsplash {
  List<Results> results;

  Unsplash.fromJson(Map<String, dynamic> json) {
    this.results = json['results'].map(
        (result) => Results.fromJson(result)
    ).toList().cast<Results>();
  }
}



class Results {
  Map<String, dynamic> urls;


  Results.fromJson(Map<String, dynamic> json) {
    this.urls = json['urls'];
  }
}
