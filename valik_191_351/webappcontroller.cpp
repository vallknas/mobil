#include "webappcontroller.h"
#include <QNetworkRequest>
#include <QSslSocket>
#include <QNetworkReply>
#include <QEventLoop>
#include <QtWidgets/QTableView>



webappcontroller::webappcontroller(QObject *QMLObject) : showHttp(QMLObject)
{
    nam = new QNetworkAccessManager(this); // создаем менеджер
    connect(nam, &QNetworkAccessManager::finished, this, &webappcontroller::onNetworkValue);

}

void webappcontroller::getNetworkValue()
{ // запрос к сайту
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.cbr.ru/"));
    qDebug() << request.url();
    nam->get(request);
}

void webappcontroller::onNetworkValue(QNetworkReply *reply)
{ // парсинг сайта
     QString str = reply->readAll(); // записывем в str  сайт
     QObject* curdate = showHttp->findChild<QObject*>("curdate");
     QObject* textField = showHttp->findChild<QObject*>("textField"); // ищем элемент textField, куда буем записывать
     QObject* textFieldDate = showHttp->findChild<QObject*>("textFieldDate");
     QObject* textArea = showHttp->findChild<QObject*>("textArea"); // ищем элемент textArea, откуда будем брать
     textArea->setProperty("text", str);
     int j = 0;
      if((j = str.indexOf("main-indicator_rates-head", j)) != -1) // ищем индекс этого тега
      {
         curdate->setProperty("text", str.mid(j+399,10));
         textField->setProperty("text", str.mid( j + 523,3));
         textFieldDate->setProperty("text", str.mid( j + 589,9));
      }
}

QString webappcontroller::success (QString add){ // функия для вывода access_token

    qDebug() <<"get success"<< add;
    if (add.indexOf("access_token=") != -1) // условие если он найден то записать в переменну
      {
           actoken = add.split("access_token=")[1].split("&")[0]; //запись в переменную токена
           qDebug() << "token: " << actoken;
           return actoken;
      }
    else{
          qDebug() << "Ошибка";
      }
    QString str = " ";
    return str;
}

bool webappcontroller::fail (QString add){

    qDebug() << "failed";
    if(add.indexOf("st._hi=") != -1)
    {
        QString var;
        var = add.split("st._hi=")[1].split(" ")[0];
          return 1;
    }
    else {
          return 0;
    }
     return 0;
}


