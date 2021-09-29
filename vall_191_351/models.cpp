#include "models.h"
#include <QAbstractItemModel>
#include <QMap>

FriendsItem::FriendsItem(const QString &getuserid, const QUrl &getPhoto, const QString &getName, const QString &getSurname)
    :   m_userid(getuserid),
        m_photo(getPhoto),
        m_name(getName),
        m_surname(getSurname)
{
 //
}


FriendsModel::FriendsModel(QObject *parent) : QAbstractListModel(parent)
{
    //пусто
}


QString FriendsItem::getDomain() const{ // функция для получения имени друга
    return m_userid;
}

QString FriendsItem::getName() const{ // функция для получения фамилии друга
    return m_name;
}

QUrl FriendsItem::getPhoto() const{ // функция для получения фото друга
    return m_photo;
}

QString FriendsItem::getSurname() const{ // функция для получения id друга
    return m_surname;
}

void FriendsModel::addItem(const FriendsItem & newItem){
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem;
    endInsertRows();
}

int FriendsModel::rowCount(const QModelIndex &parent) const
{
    // не изменяется
   // метод используется GridView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant FriendsModel::data(const QModelIndex & index,
                                int role) const
{
     // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    const FriendsItem&itemToReturn = m_items[index.row()];
    if (role == MailDomain)
    return itemToReturn.getDomain();
    else if (role == MailPhoto)
    return itemToReturn.getPhoto();
    else if (role == MailName)
    return itemToReturn.getName();
    else if (role == MailSurname)
    return itemToReturn.getSurname();

    return QVariant();
}

QHash<int, QByteArray> FriendsModel::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями

    QHash<int, QByteArray> roles;

    roles[MailDomain] = "user_id";
    roles[MailPhoto] = "pict";
    roles[MailName] = "name";
    roles[MailSurname] = "surname";
    return roles;
}

QVariantMap FriendsModel::get(int idx) const
{
    // не изменяется
   // метод используется ListView в QML для получения значений полей idx-го элемента модели
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

void FriendsModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();
    endRemoveRows();
}
