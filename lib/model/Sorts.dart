enum Sorts {
  advanceRate,
  curation,
  openingDat
}

class SortHelper {

  static String getValue(Sorts sort) {
    switch(sort) {
      case Sorts.advanceRate:
        return '예매율';
      case Sorts.curation:
        return '큐레이션';
      case Sorts.openingDat:
        return '개봉일';
    }
  }

  static String getTitle(int index) {
    switch(index) {
      case 0:
        return '예매율';
      case 1:
        return '큐레이션';
      case 2:
        return '개봉일';
    }
  }
}