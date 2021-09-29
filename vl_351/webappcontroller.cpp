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
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://www.cbr.ru/"));
    qDebug() << request.url();
    QNetworkReply * reply;
    QEventLoop evntLoop;
    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);
    reply = nam->get(request);
    evntLoop.exec();
    QString replyString = reply->readAll();
    // emit signalSendToQML(QString(replyString));
}


void webappcontroller::onNetworkValue(QNetworkReply *reply)
{ // парсинг сайта
     QString str = reply->readAll(); // записывем в str  сайт
     QObject* curdate = showHttp->findChild<QObject*>("curdate");
     QObject* textField = showHttp->findChild<QObject*>("textField"); // ищем элемент, куда буем записывать
     QObject* textFieldDate = showHttp->findChild<QObject*>("textFieldDate");
     QObject* textArea = showHttp->findChild<QObject*>("textArea");
     textArea->setProperty("text", str);
      // задаем параметр "текст" для textArea из qml
     int j = 0;
      if((j = str.indexOf("main-indicator_rates-head", j)) != -1) // ищем индекс этого тега
      {
         curdate->setProperty("text", str.mid(j+399,10));
         textField->setProperty("text", str.mid( j + 523,3));
         textFieldDate->setProperty("text", str.mid( j + 589,9));
      }
}
