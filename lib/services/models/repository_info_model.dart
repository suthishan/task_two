class RepositoryInfo {
  String name;
  String description;
  int stargazersCount;
  Owner owner;

  RepositoryInfo({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.owner,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['description'] = description;
    data['stargazers_count'] = stargazersCount;
    data['owner'] = owner.toJson();

    return data;
  }

  factory RepositoryInfo.fromJson(Map<String, dynamic> json) {
    return RepositoryInfo(
      name: json['name'] == null ? '' : json['name'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
      stargazersCount: json['stargazers_count'] == null
          ? 0
          : json['stargazers_count'] as int,
      owner: Owner.fromJson(json['owner']),
    );
  }
}

class Owner {
  String avatarUrl;
  String ownerName;
  Owner({
    required this.avatarUrl,
    required this.ownerName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['avatar_url'] = avatarUrl;
    data['login'] = ownerName;
    return data;
  }

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      avatarUrl: json['avatar_url'] == null ? '' : json['avatar_url'] as String,
      ownerName: json['login'] == null ? '' : json['login'] as String,
    );
  }
}
