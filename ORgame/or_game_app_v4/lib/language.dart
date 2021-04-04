class Language{
  List values = ['French', 'English'];
  String lang;

  Language()
  {
    this.lang = 'English';
  }

  String getLanguage()
  {
    return this.lang;
  }

  void setLanguage(String t) {
    if (values.contains(t))
      this.lang = t;
    else
      this.lang = 'English';
  }

  String getHomePageTitle()
  {
    if(this.lang=="English")
      return 'Welcome to playing OR';
    else if(this.lang=="French")
      return 'Jouons à la RO';
    else
      return "ERROR";
  }
}