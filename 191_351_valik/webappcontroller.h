#ifndef WEBAPPCONTROLLER_H
#define WEBAPPCONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>

class webappcontroller : public QObject
{       Q_OBJECT
    public:
        explicit webappcontroller(QObject *parent = nullptr);
        QNetworkAccessManager * nam;
            QString acctoken; // полученный access_token
                QString secret; //получение переменной, в которую записали токен
    signals:
                    void tokenToQml(QString token);
    public slots:
                        void onNetworkValue(QNetworkReply *reply);
                            void getNetworkValue();
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
