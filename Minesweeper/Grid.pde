import java.lang.reflect.Array;
import java.util.Iterator;

class Grid<T> implements Iterable<T> {
  private T[][] values;

  Grid(Class<T> type, int xCapacity, int yCapacity) {
    values=(T[][]) Array.newInstance(type, xCapacity, yCapacity);
  }
  public Iterator<T> iterator() {
    return new Iterator<T>() {
      int[] cursor=new int[]{0, 0};
      public boolean hasNext() {
        return cursor[0]<xSize()?true:cursor[1]+1<ySize();
      }
      public T next() {
        if (cursor[0]==xSize()) {
          cursor[0]=0;
          cursor[1]++;
        }
        return values[cursor[0]++][cursor[1]];
      }
    };
  }

  T get(int[] coordinates) {
    return values[coordinates[0]][coordinates[1]];
  }
  void store(int[] coordinates, T value) {
    values[coordinates[0]][coordinates[1]]=value;
  }
  int xSize() {
    return values.length;
  }
  int ySize() {
    return values[0].length;
  }
}
