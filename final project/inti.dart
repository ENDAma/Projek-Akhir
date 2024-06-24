import 'dart:io';

class Queue<T> {
  List<T?> _elements = [];
  int _front = 0;
  int _rear = -1;
  int _maxQueue = 0;

  Queue(int max) {
    _elements = List<T?>.generate(max, (index) => null);
    _maxQueue = max - 1;
  }

  bool isEmpty() {
    return _rear == -1;
  }

  bool isFull() {
    return _rear == _maxQueue;
  }

  void enqueue(T data) {
    if (isFull()) {
      print("Queue Overflow, tidak dapat mengisi data lagi");
    } else {
      _rear += 1;
      _elements[_rear] = data;
    }
  }

  T? dequeue() {
    if (isEmpty()) {
      print("Queue Underflow");
      return null;
    } else {
      T? data = _elements[_front];
      for (int i = 0; i < _rear; i++) {
        _elements[i] = _elements[i + 1];
      }
      _elements[_rear] = null;
      _rear -= 1;
      return data;
    }
  }

  void printQueue() {
    if (!isEmpty()) {
      print("Menampilkan urutan dari posisi tertinggi");
      for (int i = _rear; i >= 0; i--) {
        print("Elemen ke-$i = ${_elements[i]}");
      }
    } else {
      print("Queue masih kosong");
    }
  }

  int get rear => _rear; 
  T? elementAt(int index) => _elements[index]; 
  void removeAt(int index) {
    for (int i = index; i < _rear; i++) {
      _elements[i] = _elements[i + 1];
    }
    _elements[_rear] = null;
    _rear -= 1;
  }
}

class ItemStack {
  Queue<String> _stack = Queue<String>(100);
  List<String> _soldItems = [];

  void addItem(String itemName) {
    _stack.enqueue(itemName);
    print('Barang $itemName ditambahkan ke dalam tumpukan.');
  }

  void sellItem() {
    if (!_stack.isEmpty()) {
      displayStack();
      stdout.write('Pilih nomor barang yang ingin dijual: ');
      String? choice = stdin.readLineSync();

      if (choice != null && int.tryParse(choice) != null) {
        int index = int.parse(choice) - 1;
        if (index >= 0 && index <= _stack.rear) {
          var item = _stack.elementAt(index);
          _stack.removeAt(index);
          if (item != null) {
            _soldItems.add(item);
            print('Barang $item telah terjual.');
          }
        } else {
          print('Pilihan tidak valid.');
        }
      } else {
        print('Input tidak valid.');
      }
    } else {
      print('Tumpukan barang kosong.');
    }
  }

  void displayStack() {
    if (_stack.isEmpty()) {
      print('Tumpukan barang kosong.');
    } else {
      print('Barang dalam tumpukan:');
      for (int i = 0; i <= _stack.rear; i++) {
        print('${i + 1}. ${_stack.elementAt(i)}');
      }
    }
  }

  void displaySoldItems() {
    if (_soldItems.isEmpty) {
      print('Belum ada barang yang terjual.');
    } else {
      print('Barang yang telah terjual:');
      for (var item in _soldItems) {
        print('- $item');
      }
    }
  }
}

void main() {
  ItemStack itemStack = ItemStack();
  bool running = true;

  while (running) {
    print('***Sistem Antrian Tumpukan Barang***');
    print('1. Tambah Barang ke Tumpukan');
    print('2. Jual Barang');
    print('3. Tampilkan Barang dalam Tumpukan');
    print('4. Tampilkan Barang yang Telah Terjual');
    print('5. Keluar');
    stdout.write('Pilih opsi (1-5): ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Masukkan Nama Barang: ');
        String? itemName = stdin.readLineSync();

        if (itemName != null && itemName.isNotEmpty) {
          itemStack.addItem(itemName);
        } else {
          print('Nama barang tidak valid.');
        }
        break;
      case '2':
        itemStack.sellItem();
        break;
      case '3':
        itemStack.displayStack();
        break;
      case '4':
        itemStack.displaySoldItems();
        break;
      case '5':
        running = false;
        print('Sistem antrian tumpukan barang ditutup.');
        break;
      default:
        print('Opsi tidak valid. Silakan pilih antara 1 hingga 5.');
    }
  }
}
