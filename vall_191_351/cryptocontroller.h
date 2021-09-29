#ifndef CRYPTOCONTROLLER_H
#define CRYPTOCONTROLLER_H
#include <QString>
#include <QObject>


class CryptoController:public QObject
{   Q_OBJECT
public:
     explicit CryptoController(QObject *parent = nullptr);
     QString soursefile;
public slots:

   bool encriptFile(const QString & mkey, const QString &in_file); //, const QString &out_file
   bool decriptFile(const QString & mkey, const QString &in_file);
private: // они все начинаются с m_
    unsigned char * m_iv = (unsigned char *)("l3j5m78sbr0iyn1m3jhen6uyg7890tr1"); //32 символа
};

#endif // CRYPTOCONTROLLER_H
