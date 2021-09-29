#ifndef MODEL_H
#define MODEL_H
#include <QObject>
#include <QAbstractItemModel>
#include<QAbstractListModel>
#include <QList>
#include <QModelIndex>
#include <QVariant>
#include <QUrl>
#include <QVariant>

class FriendsItem
{
public:
    FriendsItem(const QString &domain,
                const QUrl &photo,
                const QString &name,
                const QString &surname);

    QString getDomain() const;
    QUrl getPhoto() const;
    QString getName() const;
    QString getSurname() const;
private:
    QString m_userid;
    QUrl m_photo;
    QString m_name;
    QString m_surname;
};


class FriendsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum enmRoles {
        MailDomain,
        MailPhoto,
        MailName,
        MailSurname
    };
    FriendsModel(QObject *parent = nullptr);
    void addItem(const FriendsItem & newItem);
    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const; // возвращает по индексу переменную
    QVariantMap get(int idx) const;

    void clear();

 protected:
    QHash<int, QByteArray> roleNames() const;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда

 private:

   QList<FriendsItem> m_items;

};

#endif // MODEL_H
