class FGameObject extends FBox {
  final int L = -1;
  final int R = 1;

  FGameObject() {
    super(gridSize, gridSize);
  }

  FGameObject(int x, int y) {
    super(x, y);
  }

  boolean isTouching(String n) {

    ArrayList <FContact> contacts = getContacts();
    for (int i =0; i< contacts.size(); i++) {
      FContact contact = contacts.get(i);
      if (contact.contains(n)&&counter<0) {

        return true;
      }
    }
    return false;
  }
  void act() {
  }
}
