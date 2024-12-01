
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
               "project_id": "biswasshoppingbd-5c83b",
               "private_key_id": "4dd90f89165699984845243dbb4c5589d43062f9",
               "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDkHcdmHVT+5eHv\nqcLqUpWi86zxENwf7hguf8cb7577KtcyKbOpIA/fpZz5TyyGzTNu0MLl2ng6/BKm\nFT5sFfGraa8LroAM1/O1CEZRk61WlWqZ/sr/xlrAnFPKH4wDG8zQ8G62IQAa5/q0\nYah6c9T+l5lbv6f2SMR0SMcbUwvNk5mqaWQMG+1A3+wOTonn8n+DkDXh6iXvxyXK\n56ywDA2lPv/jn+8aHkWxsap/Y2JllK1Ik2+6H8QIA+h68H9S5z+doaFFEAgbPkZt\nn4vzYOUzRznHEqGNVOlCZ8/BgfToKIMI2jR4np2EKTYk7jPWosfvLwtYj+gUpNN3\nMIPPXlArAgMBAAECggEAN+zBDNzWEKPFL198JLxYaRm6ZWNPxBg4H3Y+FzA41rTb\nCzZEEIuGuLq+cDSj4ux91oYhsf5MiZFw9PyyUAdVN0PyoTeHtx5eZhyAONGuplJ9\nTwGzPN+hMiVhOWVgiwaOwQ6g5c/TWcVTplNm3ZZ2OnBqLZ8gC3Yti6CoB5/lfeFi\nOgpCsP8cVecFXUBZpG0mHrwAC0FKS9VGkoFVnBxSG9F9f2E/9eZlXld4U7YUPIZL\nxUTnSAtf7kKP6oqnJqCJ9GKaU+pAD1OLce0UD/4Dim2EOKUMcXeRfwH7MkM4OHJF\nbPVGc+x0f1cLi1xSisoDq0fiuRQXas+fT75mgPpeCQKBgQD4p9dMN69HJXhb4kYW\nxKKlv5UDIghoP1PHzpJaGYEOs3tpt9rb2S+IMXTG46PPdGx7cSS9VOLvF+5Dw/MR\nYWipwnJcBZiNt8RK5r7AT62t581uo8y7XQi4LmEHiAqpo3KKFElpltQLfNbAQMN3\nCRroAzUoILQOB+sUZjjhbOoqfwKBgQDq2qJVWBWRdRJEoMPHbbUtdwWGyyQsiP2h\nMhwOe2z1SV8fS3snweQPh5Xt9k5/EEg7WD4DDPDcwD63c2BAqBAcVZNBo4S8JueL\nHC43J/YEB8pPWX1cjHzF2qCRH5FaaQv7fC2yZ8KAYLcQqSLiSsX9wparxV1+Mib3\nj1KkKb/MVQKBgFj8yCIws3vEvyQzAF5ZlNO4kn2Cinu0XildlibEhdlbBkm5UIvp\nWAdnm6EqCo/N3Jz4yusvG9/xMoXx9GU99RT7z617GzNslsUvewib+04HbQ+xcy2C\niAJSJstpNlerdOxRgkxVfCF4VeqLwugwy/5IV5e6zHVRBCJSyvxx3APFAoGAavNX\n28+6Orx6rkAcCDTAvkymeqUF+zYDcqYUOtAgZW+dXu4LzqYwipXvRCfXxWuPyV69\nFryM76qopPhoy+j9NToPTmP97YU2CpaxwTJ0iY9WpV4WhdAAfkW6u3wJwId4CnWZ\nhdZUsAvbMj4kAbOViKNV5DGECxUhw7lEJDhS/OUCgYEAwLwFahQ7pegk8oWeDMP1\nQktqcDgzxbPece8+/Px7vnzCx2vts235SBJ76HZ3CuD/2bylh561/1DsSFDnUYeC\nPiAnuxLdDWFGWc0b0yiAU7HDllq7wAe65TVaVw9gWDiaQOY4hWuMYqQUsFgSuw+S\nij/TWLHoBFSvUbP5q26mUZw=\n-----END PRIVATE KEY-----\n",
               "client_email": "firebase-adminsdk-wnvre@biswasshoppingbd-5c83b.iam.gserviceaccount.com",
               "client_id": "105860321552032464437",
               "auth_uri": "https://accounts.google.com/o/oauth2/auth",
               "token_uri": "https://oauth2.googleapis.com/token",
               "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
               "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wnvre%40biswasshoppingbd-5c83b.iam.gserviceaccount.com",
               "universe_domain": "googleapis.com"
             }),
         scopes);
     final accessServerKey = await client.credentials.accessToken.data;

     // client.close();
     return accessServerKey;


   }catch(e){
     print(e);
   }


    return '';
  }
}