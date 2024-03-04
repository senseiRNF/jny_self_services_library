class HomeMenuJson {
  String? menuTitle;
  String? menuIcon;
  Function? onPressed;

  HomeMenuJson({
    this.menuTitle,
    this.menuIcon,
    this.onPressed,
  });

  HomeMenuJson.fromJson(Map<String, dynamic> json) {
    menuTitle = json['menu_title'];
    menuIcon = json['menu_icon'];
    onPressed = json['on_pressed'];
  }

  Map<String, dynamic> toJson(HomeMenuJson value) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['menu_title'] = menuTitle;
    data['menu_icon'] = menuIcon;
    data['on_pressed'] = onPressed;

    return data;
  }
}