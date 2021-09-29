#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>

class webappcontroller : public QObject
{       Q_OBJECT
    public:
        explicit webappcontroller(QObject *parent = nullptr);
        QNetworkAccessManager * nam;
    public slots:
        void onNetworkValue(QNetworkReply *reply);
        void getNetworkValue();
        //  void SlotFinished(QNetworkReply *reply);

    //    void enterSuccess(QString pop);
    //    void noSuccess(QNetworkReply *reply);

    protected:
        QObject *showHttp;
};

#endif // WEBAPPCONTROLLER_H


 // WEBAPPCONTROLLER_H
/* Директива #ifndef проверяет, определено ли имя WEBAPPCONTROLLER_H, если нет, то управление передаётся директиве #define
 * и определяется интерфейс класса. Если же имя WEBAPPCONTROLLER_H уже определено,
 * управление передаётся директиве #endif. Таким образом, исключается возможность многократного определения класса WEBAPPCONTROLLER_H.
 *
 */
