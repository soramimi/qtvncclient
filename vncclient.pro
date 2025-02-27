TARGET = vncclient
TEMPLATE = app
QT += core gui widgets network

INCLUDEPATH += examples/vncclient
INCLUDEPATH += src/vncclient

HEADERS += \
    src/vncclient/qtvncclientglobal.h \
	src/vncclient/qvncclient.h \
	examples/vncclient/mainwindow.h \
	examples/vncclient/spinbox.h \
	examples/vncclient/vncwidget.h

SOURCES += \
    src/vncclient/qtvncclientlogging.cpp \
	src/vncclient/qvncclient.cpp \
	examples/vncclient/main.cpp \
	examples/vncclient/mainwindow.cpp \
	examples/vncclient/spinbox.cpp \
	examples/vncclient/vncwidget.cpp

FORMS += \
examples/vncclient/mainwindow.ui
