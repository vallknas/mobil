#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "webappcontroller.h"
#include <QQmlContext>
#include <QQuickView>


int main(int argc, char *argv[])
{
    //в составе класса QCoreApplication (без создания экземпляров класса)
    //просто настройка масштабирования экрана.
     QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
     QGuiApplication app(argc, argv);



         webappcontroller Webappcontroller;
      //Создание браузерного движка
     QQmlApplicationEngine engine;

      QQmlContext *context = engine.rootContext();
     //Перемещаемая модель, которой присваиваем имя
     context->setContextProperty("webappcontroller", &Webappcontroller);
        //преобразование пути стартовой страницы из char в Qurl

        //подлючение слота, срабатывающего после создания objectCreated
     engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
     if (engine.rootObjects().isEmpty())
         return -1;

     QObject::connect(engine.rootObjects().first(), SIGNAL(failed(QString)),
     &Webappcontroller, SLOT(failed(QString)));

     QObject::connect(engine.rootObjects().first(), SIGNAL(success(QString)),
     &Webappcontroller, SLOT(success(QString)));

     QObject* main = engine.rootObjects()[0];
      webappcontroller sendtoqml(main);
     engine.rootContext()->setContextProperty("_send", &sendtoqml);

     return app.exec();//запуск бесконечного цикла обработки сообщений и слотов/сигналов

}



