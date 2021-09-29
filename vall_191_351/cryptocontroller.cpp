#include "cryptocontroller.h"
#include <QString>
#include <openssl/conf.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <QFile>
#include <QByteArray>
#include <QImage>
#include <QIODevice>
#include <QObject>
#include <QTemporaryFile>
#include <openssl/aes.h>
#include <QBuffer>

//CryptoController::CryptoController(QObject *parent)
//{
//    EVP_CIPHER_CTX *ctx;

//        int len;

//        int plaintext_len;

//        /* Create and initialise the context */
//        ctx = EVP_CIPHER_CTX_new();
//}


CryptoController::CryptoController(QObject *parent):QObject (parent)
{

}

bool CryptoController::encriptFile(const QString & mkey, const QString & in_file){ //, const QString & out_file

    EVP_CIPHER_CTX *ctx;
    if(!(ctx = EVP_CIPHER_CTX_new())){ // выделение памяти, аналогичное new()
        return false;
    }


    if(1 != EVP_EncryptInit_ex(ctx,
                               EVP_aes_256_cfb(), // тип шифрования
                               NULL,
                               reinterpret_cast<unsigned char *>(mkey.toLatin1().data()), // из QML ключ
                               m_iv)) // вектор инициализации
    {
        return false;
    }

    unsigned char mytext[256] = {0};
    unsigned char plaintexttext[256] = {0};
    int len = 0, plaintext_len = 0;
    // открыть файл с исходными данными (только для чтения) через QFile file_in(mkey); file_in.open(QFile::ReadOnly);
    soursefile = in_file.mid(8);
    QFile sourse_file(soursefile);
    sourse_file.open(QIODevice::ReadOnly);

    int position = soursefile.lastIndexOf(".");
    QString file_extension = soursefile.mid(position);
    QString soursefile_enc = soursefile.left(position) + "_e" + file_extension;

    //и создать (открыть с перезаписью) файл с шифрованными данными
    QFile file_modificate(soursefile_enc);
    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
    plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    while(plaintext_len > 0/*условие конфа файла*/){ // цикл шифрования


        if(1 != EVP_EncryptUpdate(ctx, // уже заполненная структура с настройками
                                  mytext, // выходной параметр, бувур, куда записывается шифрованный текст
                                  &len, // выходной параметр, количество зашифрованных символов, объем в байтах
                                  plaintexttext, // входной параметр, шифруемый буфер
                                  plaintext_len)) // входной параметр, количество исходных символов
        {
            return false;
        }

        //Запись mytext в файл шифрованных данных
        file_modificate.write((char *)mytext, len);
        plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    }

    if(1 != EVP_EncryptFinal_ex(ctx,
                                mytext + len,
                                &len))
    {
        return false;
    }
    file_modificate.write((char*)mytext, len);
    EVP_CIPHER_CTX_free(ctx);
      // закрытие файлов
    sourse_file.close();
    file_modificate.close();

    return true;
}

bool CryptoController::decriptFile(const QString & mkey, const QString & in_file){ //, const QString & out_file

    EVP_CIPHER_CTX *ctx; // СИшная структура
    if(!(ctx = EVP_CIPHER_CTX_new())){ // выделение памяти, аналогичное оператору-C++ new()
        return false;
    }
    if(1 != EVP_DecryptInit_ex(ctx, // уже выделенная в памяти структура, в которую будут заноситься параметры
                               EVP_aes_256_cfb(), // параметр, отвечающий за тип шифрования
                               NULL,
                               reinterpret_cast<unsigned char *>(mkey.toLatin1().data()), // ключ шифрования, из QML
                               m_iv)) // вектор инициализации
    {
        return false;
    }
    unsigned char mytext[256] = {0};
    unsigned char plaintexttext[256] = {0};
    int len = 0, plaintext_len = 0;
    // открыть файл с исходными данными (только для чтения) через QFile file_in(mkey); file_in.open(QFile::ReadOnly);
    soursefile = in_file.mid(8);
    QFile sourse_file(soursefile);
    sourse_file.open(QIODevice::ReadOnly);

    int position = soursefile.lastIndexOf(".");
    QString file_extension = soursefile.mid(position);
    QString soursefile_dec = soursefile.left(position) + "_d" + file_extension;

    //и создать (открыть с перезаписью) файл с шифрованными данными
    QFile file_modificate(soursefile_dec);
    file_modificate.open(QIODevice::ReadWrite | QIODevice::Truncate);
    plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    while(plaintext_len > 0/*условие конфа файла*/){ // цикл шифрования


        if(1 != EVP_DecryptUpdate(ctx, mytext, &len, plaintexttext, plaintext_len))
        {
            return false;
        }
        //Запись mytext в файл шифрованных данных
        file_modificate.write((char *)mytext, len);
        plaintext_len = sourse_file.read((char *)plaintexttext, 256);

    }
    if(!EVP_DecryptFinal_ex(ctx, mytext + len, &len))
                return false;

    file_modificate.write((char*)mytext, len);
    EVP_CIPHER_CTX_free(ctx);
      // закрытие файлов
    sourse_file.close();
    file_modificate.close();

    return true;
}



/***
 Шифрование состоит из следующих этапов:
Настройка контекста
Инициализация операции шифрования
Предоставление байтов открытого текста для шифрования
Завершение операции шифрования
***/
