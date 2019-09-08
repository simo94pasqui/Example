QT += quick gui core widgets serialport
CONFIG += c++11

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        laser.cpp \
        main.cpp

RESOURCES += qml.qrc

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    laser.h

DISTFILES +=
