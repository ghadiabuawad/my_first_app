// ignore_for_file: avoid_print
// תחנה 5 — מחלקות
// הרצה: dart run bin/station5_classes.dart

class BankAccount {
  // static — שייך למחלקה עצמה, לא לחשבון ספציפי
  static int accountsOpened = 0;

  final String owner;
  // שדה פרטי: קו תחתון בתחילת השם = נגיש רק מתוך הקובץ הזה
  double _balance;

  // בנאי
  BankAccount(this.owner, [this._balance = 0]) {
    accountsOpened++;
  }

  // getter — קריאה בלבד מבחוץ
  double get balance => _balance;

  // setter — שינוי עם בדיקה
  set balance(double value) {
    if (value < 0) throw ArgumentError('Balance cannot be negative');
    _balance = value;
  }

  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError('Deposit must be positive');
    _balance += amount;
  }

  // אי אפשר למשוך יותר ממה שיש
  bool withdraw(double amount) {
    if (amount > _balance) {
      print('$owner: cannot withdraw $amount, only $_balance available');
      return false;
    }
    _balance -= amount;
    return true;
  }

  @override
  String toString() => '$owner: $_balance';
}

// ירושה — SavingsAccount הוא BankAccount + ריבית
class SavingsAccount extends BankAccount {
  final double interestRate;

  SavingsAccount(super.owner, super.balance, this.interestRate);

  void addInterest() => deposit(balance * interestRate);
}

void main() {
  final dana = BankAccount('Dana', 100);
  dana.deposit(50);
  dana.withdraw(500); // נכשל — אין מספיק כסף
  dana.withdraw(30);
  print(dana); // Dana: 120.0

  final noa = SavingsAccount('Noa', 1000, 0.05);
  noa.addInterest();
  print(noa); // Noa: 1050.0

  print('Accounts opened: ${BankAccount.accountsOpened}');
}
