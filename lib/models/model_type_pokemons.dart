class ModelTypePokemons {
    int count;
    String next;
    dynamic previous;
    List<Result> results;

    ModelTypePokemons({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory ModelTypePokemons.fromJson(Map<String, dynamic> json) => ModelTypePokemons(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String name;
    String url;

    Result({
        required this.name,
        required this.url,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}
