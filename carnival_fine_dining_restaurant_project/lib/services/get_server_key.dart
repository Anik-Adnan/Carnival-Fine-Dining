
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey{

  Future<String> getServerKeyToken() async{
    try{
     final scopes = [
       'https://www.googleapis.com/auth/userinfo.email',
       'https://www.googleapis.com/auth/firebase.database',
       'https://www.googleapis.com/auth/firebase.messaging',
     ];
     final client = await clientViaServiceAccount(
         ServiceAccountCredentials.fromJson(
             {
               "type": "service_account",
               "project_id": "carnival-finedining-restaurant",
               "private_key_id": "84c128fdeae2d25319e52df6bf347b2ac09fb1aa",
               "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDIRwo8s7VH5Vi8\nruOtb3PWK/J96U9EZe7lsJTNpND+KTewKiy7YplaxViWzA0Y1MdS/LJ0LnQeqT+E\nP2/HzldfTcQOWa3qavmg+gVzeyiKgmOaeMIjLWegpIMZFGNNZWF7yjFCFdlEJNWr\nQovvtwQO+mjjKT9F9UjBXtmhUutrXZAOlmmZCl12aSvpTPVjeynA8h3caH3SRV4d\naCC83zrbwyORss0bopziszCu1gC7WT8RxACfOLT71ykxKmBr5ACizsG/7j1oY3JP\nege5slipUU65FQ9fdnThAhh9I5WuULmdQn0R2b2gw+VYiUuvBKrpOadjnVYW7M3f\nJHWIz8hpAgMBAAECggEAFUflKNOQnunaDryHoUlvNdH4I5RrsZEiPCJSAXLyqRsQ\nmYW1uJiOwoQnOGjIuHt9jY4f2TQJbyudPexusHy2sIAHJd42GmtRCJ+gfieXRHZ7\n5nFP8aR0ty9b5cmSjqoH3Hs81jCTpEfEs3yv+WIJSp0lkYOzvzeDylZNijSRIth/\nRGJPjcBeZC8xrGM0CGLzSMI1oX2z3KC2qz9Oe6JTD8/yiv577pcuMcZXAcpA0Rng\nhrz3hjz8Ljxlhw2NY65nPY/nK2olKQO6VJIreeSpBU+ssq3auMnFHSYwGkzG8PT7\nFNIE15BZvUImwdx0EHRXUiRVmyUEoMcPBJlgHg8FgQKBgQDzRPaIArXSXZThkk4x\nWEgpgnxcas6lt0Tq2jKirHP0RXPrlR4RZiKTrYnA3TQKWajds1yoMwuTr6kbdcnU\nvg7BvZwarsZFItMTHaNNlOFwbufjtENVEyKqU0MlNYCxWPOZK1PiA41yNaWWZXYH\nxgiNxkwCkw9eI8dhSgfW/QxuKQKBgQDSwh9Mxe4xeEJ/kWL7PQC9xV3pFYAZEd90\nbmCdYNCjoquWikdCrVzKD80p2zx+9QE5W8aFcGT0sof2nFHVdehT86+Y8q/5/mD7\nfrB3Lgwki9BJUqReB6zJNKbaVl99TyBW9f7Bq8wAzmzbzUkbDYCAVrqqGZYlsGFA\nl1b9NcNQQQKBgCzG8dXhIdSB0yieBHSCum2hjgB4zGamUDImTZGxynoY2phvTySG\ntzCVjbiJPs306Oc93306QBREDg125dqZzR+OJhCnQOly2oU3PFrIX6KRV2+LO6WK\nKyRMxRwxN+ns5JG57uu4Ga3+/+ap8ErIAcUOzejfZsG+NjHLLZw94a7ZAoGBAJcE\nYkkwyqzH715ZXwOHgrB4bAJIVbGhDOzw6mnapaWbOjh0fPtaHdLr36bOYVrXVDk1\nedrD3pM4GhSrjjfWdNMzGfAOdeo8TGHpNakwZaMKTAU+Imj+NuE1yRlKKsIvoIyv\nWAyOfW9WespFHs0zr5BGlRqtmtkGuaj+yGZHz9wBAoGAGv+xYH8J/kXDWEdEx6fy\no38Pr/QMBD9Omj1n6WpeUFM2GQJX4/Q65J2EmGp/ysN28ZxkqjZ7oA6yOpiYjvQZ\neJEh71RFgx/WtCheOssMGMUK2fJeYTrHfKNBxSWsv0hLDd5NEuHctNVVt6x18Zuq\n7uxzwi2u0juJko5L7CmuxRY=\n-----END PRIVATE KEY-----\n",
               "client_email": "firebase-adminsdk-jj7ea@carnival-finedining-restaurant.iam.gserviceaccount.com",
               "client_id": "107340923993284856120",
               "auth_uri": "https://accounts.google.com/o/oauth2/auth",
               "token_uri": "https://oauth2.googleapis.com/token",
               "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
               "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-jj7ea%40carnival-finedining-restaurant.iam.gserviceaccount.com",
               "universe_domain": "googleapis.com"
             }
         ),
         scopes);
     final accessServerKey = client.credentials.accessToken.data;

     // client.close();
     return accessServerKey;


   }catch(e){
     print(e);
   }


    return '';
  }
}