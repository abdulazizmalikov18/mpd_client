extension ListExt<T> on List<T> {
  int? findIndex(bool Function(T value) find) {
    for(int i = 0; i< length; i++) {
      if(find(this[i])) {
        return i;
      }
    }
    return null;
  }

  bool findExist(bool Function(T value) find) {
    for(int i = 0; i< length; i++) {
      if(find(this[i])) {
        return true;
      }
    }
    return false;
  }



  bool findObject<R>(List<R> secondData,bool Function(T mainData, R secondDtata) find) {
    for(int i = 0; i< length; i++) {
      for(int j = 0; j< secondData.length; j++) {
        if(find(this[i], secondData[j])) {
          return true;
        }
      }
    }
    return false;
  }
  List<T> where2<R>(List<R> secondData,bool Function(T mainData, R secondDtata) find) {
    List<T> result = [];
    for(int i = 0; i< length; i++) {
      for(int j = 0; j< secondData.length; j++) {
        if(find(this[i], secondData[j])) {
          result.add(this[i]);
          break ;
        }
      }
    }
    return result;
  }
}