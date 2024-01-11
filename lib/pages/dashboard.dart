import 'package:flutter/material.dart';
import 'package:modernlogintute/pages/login_page.dart';
import 'package:modernlogintute/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<double> transactions = [
    100.000
  ]; // List untuk menyimpan riwayat transaksi
  TextEditingController _saldoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Wallet'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Aplikasi by Agif',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                }),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Implement logout logic here
                // For now, just pop to the login page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Colors.blue,
                ),
                SizedBox(height: 20),
                Text(
                  'Saldo: \Rp${_calculateSaldo()}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text(
                  'Informasi Transaksi:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _buildTransactionInfo(),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showTopUpDialog();
            },
            child: Text('Top Up'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showWithdrawDialog();
            },
            child: Text('Withdraw'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showAddTransactionDialog();
            },
            child: Text('Tambah Transaksi'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showEditTransactionDialog();
            },
            child: Text('Edit Transaksi'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showDeleteTransactionDialog();
            },
            child: Text('Hapus Transaksi'),
          ),
        ],
      ),
    );
  }

  double _calculateSaldo() {
    return transactions.reduce((value, element) => value + element);
  }

  Widget _buildTransactionInfo() {
    return Column(
      children: transactions.map((transaction) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            transaction > 0
                ? 'Top Up: \Rp$transaction'
                : 'Withdrawal: \Rp${-transaction}',
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _showTopUpDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Top Up'),
          content: Column(
            children: [
              Text('Masukkan jumlah top up:'),
              TextField(
                controller: _saldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _topUp();
                Navigator.of(context).pop();
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWithdrawDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Withdraw'),
          content: Column(
            children: [
              Text('Masukkan jumlah withdrawal:'),
              TextField(
                controller: _saldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _withdraw();
                Navigator.of(context).pop();
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddTransactionDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Transaksi'),
          content: Column(
            children: [
              Text('Masukkan jumlah transaksi:'),
              TextField(
                controller: _saldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _addTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTransactionDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Transaksi'),
          content: Column(
            children: [
              Text('Masukkan jumlah baru:'),
              TextField(
                controller: _saldoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _editTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteTransactionDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Transaksi'),
          content: Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Konfirmasi'),
            ),
          ],
        );
      },
    );
  }

  void _topUp() {
    double topUpAmount = double.tryParse(_saldoController.text) ?? 0.0;
    setState(() {
      transactions.add(topUpAmount);
    });
  }

  void _withdraw() {
    double withdrawAmount = double.tryParse(_saldoController.text) ?? 0.0;
    setState(() {
      if (_calculateSaldo() >= withdrawAmount) {
        transactions.add(-withdrawAmount);
      } else {
        // Handling insufficient balance
        print('Insufficient balance');
      }
    });
  }

  void _addTransaction() {
    double transactionAmount = double.tryParse(_saldoController.text) ?? 0.0;
    setState(() {
      transactions.add(transactionAmount);
    });
  }

  void _editTransaction() {
    double newAmount = double.tryParse(_saldoController.text) ?? 0.0;
    setState(() {
      if (transactions.isNotEmpty) {
        transactions[transactions.length - 1] = newAmount;
      }
    });
  }

  void _deleteTransaction() {
    setState(() {
      if (transactions.isNotEmpty) {
        transactions.removeAt(transactions.length - 1);
      }
    });
  }
}
