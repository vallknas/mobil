QT += quick
QT += network
QT += webview
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        model.cpp \
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
    model.h \
    webappcontroller.h

QMAKE_EXTRA_TARGETS += before_build makefilehook
makefilehook.target = $(MAKEFILE)
makefilehook.depends = .beforebuild
PRE_TARGETDEPS += .beforebuild
before_build.target = .beforebuild
before_build.depends = FORCE
before_build.commands = chcp 1251
