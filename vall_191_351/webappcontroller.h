#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <models.h>
#include <cryptocontroller.h>

class webappcontroller : public QObject
{       Q_OBJECT
    public:
        explicit webappcontroller(QObject *parent = nullptr);
        QNetworkAccessManager * nam;
            QString actoken; // полученный access_token
                QString secretkey;
                    FriendsModel * model;//создание модели 5 laba

    public slots:
                    void onNetworkValue(QNetworkReply *reply);
                        void getNetworkValue();
                            QString success (QString add);
                                bool fail (QString add);
                                    void restRequest();//5
                                    void restReply(QNetworkReply *reply);//5
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
