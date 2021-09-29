QT += quick
QT += network
QT += webview
QT += core
QT += charts
CONFIG += c++11
QT +=svg

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        cryptocontroller.cpp \
        main.cpp \
        models.cpp \
        webappcontroller.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


HEADERS += \
    cryptocontroller.h \
    models.h \
    webappcontroller.h

win32 {
INCLUDEPATH += "C:/Qt/Tools/OpenSSL/Win_x64/include"
LIBS += "C:/Qt/Tools/OpenSSL/Win_x64/lib/libcrypto.lib" \
        "C:/Qt/Tools/OpenSSL/Win_x64/lib/libssl.lib"
}
else: android {
        INCLUDEPATH += "C:\openssl\android_openssl\static\include"
        LIBS += "C:\openssl\android_openssl\static\lib\arm64\libcrypto.a" \
                "C:\openssl\android_openssl\static\lib\arm64\libssl.a"

}
