import 'dart:io';
import 'dart:collection';

class ItemStack {
  Queue<String> _stack = Queue();
  List<String> _soldItems = [];

  void addItem(String itemName) {
    _stack.addLast(itemName);
    print('Barang $itemName ditambahkan ke dalam tumpukan.');
  }

  void sellItem() {
    if (_stack.isNotEmpty) {
      displayStack();
      stdout.write('Pilih nomor barang yang ingin dijual: ');
      String? choice = stdin.readLineSync();

      if (choice != null && int.tryParse(choice) != null) {
        int index = int.parse(choice) - 1;
        if (index >= 0 && index < _stack.length) {
          var item = _stack.elementAt(index);
          _stack.remove(item);
          _soldItems.add(item);
          print('Barang $item telah terjual.');
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
    if (_stack.isEmpty) {
      print('Tumpukan barang kosong.');
    } else {
      print('Barang dalam tumpukan:');
      int i = 1;
      for (var item in _stack) {
        print('$i. $item');
        i++;
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
        print('\nBarang dalam Tumpukan:');
        itemStack.displayStack();
        break;
      case '4':
        print('\nBarang yang Telah Terjual:');
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
