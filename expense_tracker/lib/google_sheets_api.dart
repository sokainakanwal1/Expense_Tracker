import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  //create credentials
  static const _credentials = r'''
{
   "type": "service_account",
  "project_id": "flutter-expense-tracker-413505",
  "private_key_id": "8757e4bdb8279d2a3b103cb3010431343631ddc2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCs2uCseyrkYK/9\n58O0+TWmwv4kqjqVKZ0QrlpRXiHOhQdOAUiN7YSZy+eZDoLNBBrmemvwmOabpheG\nH0g2t9tWNvqyrGhk9ks4gHX4OEShQp4WTt6iVMLgmA5TxYk26lIeaiRJbxrF7IaG\n+Mk6ypSFvjvu64pC0KI6hPIrsa7um2oYHcI786CnaeKBd82IGYsOP7kKXQqi0ygr\nmHf/4fiyaS2H673meOMj5wfqAGW03Yj3T9CtLUrlgX9Xmnzxr7+UFrhDeDWCKJld\nKebcrZRLylEP++haPIFPM+19nWqHaN4ZoJTwb0uXARdDk3gvr4ZDGgH8wOY/PjcI\n4NHmaendAgMBAAECggEANZRxITXakUkBNJCTQvUess7tjTrxBsyL4aBR4bfufcAR\niBXwwgG2YR/p7bEoTVlw5zFaZQ1YKjYdQ5dNwJxUElDfe+PiRi1sGpsDNkpmx5/J\nNfwDmcjxUUIA6umnw0x14PSgw9x7LY/IEW1rntwtlpllpYUAaf6W0tHj6TReF5q1\nCv8O3+BhysEVa9EiXgXrci5QqJ9T0QroOmqYF45RLbRchppKSBvQePJGBcSrjujK\n/HUUhppLkhnVu/a9xruuIS8oE+mX2AkXToiGzc/50H6bUPupwv7rW74YPvok1Qco\nYm8OYYeslyg264LiE2RUbYRirbJyWNUjUWKAUR9AFwKBgQDn7+fmFwhrHc2WZXsX\nOwmMen7V7uzOri7e+fzVh61CMHPm3IjvJMxVPvdF08ouqLESEoUkHgcvsFQiv5ex\nIdyfqGYyXAcbXQQL4M9kYbFdGAx3ZYXM/uOuM2qRDf5tX06PUvgEOKUaQj2bt0ah\nWQV5ziy6EhbpTgVnVdxVjFTV8wKBgQC+yco0PpXi4v2ZpLQq1aM3PXPqye4O2Vfl\nfx/DyXN6zmGmIPt5Wux7fGuNfHXtASSFMZLno/z9mD9qeJA3m7XaM+T7MEDIkMNm\nm4a7SQPx/KW59v4Ys78fM+NfFN0wCmtVE2XpBJWvhY90eCImPtuAIyF2cQxlLl9d\nYAll3mAk7wKBgDl/oRbKiPy9I7VwLQbCTQi1aXIxzCUky1vdz49EFnC9QE5wR8Y5\nciqD9Jsr+Qh+K3+WdclRZGivJvyCUOHJyj8OaV98rwpakeE7904kZer1RknnMjdy\nzRDnkDirpnKI2Rnw8KljPZL37vwGgI0JW7Epqq7qQyHNhMtsXrYalwF/AoGBAK6J\nxn1DIDYfeOd9QQHKzfU0N/58W1ekSAAA61teyVF4yuaDV+uuXZeevHoEeZGnsPRU\n5NMbN8/731AVGcJ1pckIHpwZibqyjMAq2fguFPjlK+vT5KNOlTMDcifC25MehRCg\nnWOuOQ4I/rMLUBpy+LXh7bQAOdm6sa2ntRFHfedrAoGAOGgdQcomTh+B+2lINozV\nUduen67d3sDVKQ4cgNYOivaLzRM48EzPTQsRX3i9K9M3RnlKJ7Q0fq6mkpUYzsLH\nJ8VIHucaqlICpb6uf7hbenphbDI6oo4PE+vJu88l9y2jJ2Xt/IEJIwMhn/aislPC\nDoLcbwFEMj7wyR6o4dYI1t8=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-expense-tracker@flutter-expense-tracker-413505.iam.gserviceaccount.com",
  "client_id": "108230281737826379273",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-expense-tracker%40flutter-expense-tracker-413505.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"

}
''';

  ///Set up and connect to the spreadsheets
  static final _spreadsheetsId = '1cN5hWUKP0voMogk2M728K0-WtF-jCRnAgE4x8BRZVQ0';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

//some variables to keep track of..
  static int numberOfTransationcs = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  //initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetsId);
    _worksheet = ss.worksheetByTitle('worksheet1');
  }

  //count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransationcs + 1)) !=
        '') {
      numberOfTransationcs++;
    }
    //now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (_worksheet == null) return;
    for (int i = 1; i < numberOfTransationcs; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransationcs) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    //this will stop the circular loading indicator
    loading = false;
  }
}
