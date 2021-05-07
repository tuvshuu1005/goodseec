class ListCountry {
  final int value;
  final String name;

  ListCountry(this.value, this.name);

  ListCountry.fromJson(Map<String, dynamic> json)
      : value = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': value,
        'name': name,
      };
}
