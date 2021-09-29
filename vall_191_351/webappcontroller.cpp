#include "webappcontroller.h"
#include <QNetworkRequest>
#include <QSslSocket>
#include <QNetworkReply>
#include <QEventLoop>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QUrl>
#include <models.h>
#include <QtWidgets/QTableView>


webappcontroller::webappcontroller(QObject *QMLObject) : showHttp(QMLObject)
{
    nam = new QNetworkAccessManager(this); // создаем менеджер
    connect(nam, &QNetworkAccessManager::finished, this, &webappcontroller::onNetworkValue);
    //connect(nam, &QNetworkAccessManager::finished, this, &webappcontroller::restReply);
    model = new FriendsModel();
}

void webappcontroller::getNetworkValue()
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.cbr.ru/"));
    qDebug() << request.url();
    nam->get(request);
}

void webappcontroller::onNetworkValue(QNetworkReply *reply)
{
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

void webappcontroller::restRequest(){
    delete nam;
    nam = new QNetworkAccessManager(this);
    connect(nam, &QNetworkAccessManager::finished, this, &webappcontroller::restReply);
    QNetworkRequest request;
    request.setUrl(QUrl("https://api.vk.com/method/friends.get?v=5.52&fields=photo_100,city,status,domain,sex"
                        "&access_token="+ actoken));
    qDebug() << request.url();
    nam->get(request);//metod http
}
void webappcontroller::restReply(QNetworkReply *reply){
    // вся строка JSON с сервера грузится в QJsonDocument
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
    QJsonObject root = document.object();
    QJsonValue itog = root.value("response");
    QJsonObject news = itog.toObject();
    QJsonArray array = news["items"].toArray();
    qDebug() <<"Friends"<< array.count();

    for(int i = 0; i < array.count(); i++){
        QJsonObject value = array.at(i).toObject();

        QString domain = value.value("domain").toString();
        qDebug() << domain;

        QString name = value.value("first_name").toString();
        qDebug() << name;

        QString surname = value.value("last_name").toString();
        qDebug() << surname;

        QUrl photo = value.value("photo_100").toString();
        qDebug() << photo;

        //постароение модели
        model->addItem(FriendsItem(domain, photo, name, surname ));
        qDebug() << model->MailDomain;
        qDebug() << model->MailPhoto;
        qDebug() << model->MailName;
        qDebug() << model->MailSurname;
    }

}
