#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "webappcontroller.h"
#include <QQmlContext>
#include <QQuickView>
#include <QtWebView>
#include "models.h"
#include "cryptocontroller.h"


int main(int argc, char *argv[])
{
    //в составе класса QCoreApplication (без создания экземпляров класса)
    //просто настройка масштабирования экрана.
     QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
     QGuiApplication app(argc, argv);

     webappcontroller Webappcontroller;
     CryptoController cryptocontroller;

      //Создание браузерного движка
     QQmlApplicationEngine engine;

      QQmlContext *context = engine.rootContext();
     //Перемещаемая модель, которой присваиваем имя
     context->setContextProperty("webappcontroller", &Webappcontroller);
     context->setContextProperty("app_model", Webappcontroller.model);//публикация модели в область видимости
     context -> setContextProperty("cryptocontroller", &cryptocontroller);

     //подлючение слота, срабатывающего после создания objectCreated
     engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
     if (engine.rootObjects().isEmpty())
         return -1;

     QObject::connect(engine.rootObjects().first(), SIGNAL(restRequest()),
     &Webappcontroller, SLOT(restRequest()));//5 laba

     QObject::connect(engine.rootObjects().first(), SIGNAL(failed(QString)),
     &Webappcontroller, SLOT(failed(QString)));//4 laba

     QObject::connect(engine.rootObjects().first(), SIGNAL(success(QString)),
     &Webappcontroller, SLOT(success(QString)));//4 laba

     QObject* main = engine.rootObjects()[0];
      webappcontroller sendtoqml(main);
     engine.rootContext()->setContextProperty("_send", &sendtoqml);

     return app.exec();//запуск бесконечного цикла обработки сообщений и слотов/сигналов
}
