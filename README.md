# QtVnc Module

A Qt module that provides VNC (Virtual Network Computing) client functionality for Qt applications. This library enables Qt developers to easily integrate remote desktop viewing and control capabilities into their applications.

## Structure

The project is organized as follows:

- **src/vncclient/**: Contains the core QVncClient library
  - `qvncclient.h` and `qvncclient.cpp`: Main VNC client implementation
  - `qtvncclientglobal.h`: Global definitions for the library
  - Various `.qdoc` files: Documentation in Qt's documentation format
  - `api_documentation.md`: Comprehensive API documentation in Markdown format

- **examples/vncclient/**: Contains a VNC Watcher example application
  - Demonstrates how to use the QVncClient in an application
  - Provides a simple UI for connecting to VNC servers
  
- **tests/**: Contains automated tests for the library
  - Unit tests for QVncClient functionality
  - Integration tests for protocol compliance

## Features

Current implementation provides:

- Connect to VNC servers by specifying hostname/IP and port
- Support for VNC protocol version 3.3 (with basic support for 3.7 and 3.8)
- Basic security types support (primarily None authentication)
- Remote keyboard and mouse control
- Raw encoding for framebuffer updates
- Simple Qt widget interface
- Optional ZLIB support for Tight and ZRLE encodings
- Cross-platform compatibility

See the [ROADMAP.md](ROADMAP.md) file for planned improvements and additional features.

## Building

### Prerequisites

- Qt 5.15 or Qt 6.2+
- Qt Widgets module
- Qt Network module
- CMake 3.16 or higher
- ZLIB (optional, for Tight and ZRLE encodings)

### Build Steps with CMake

1. Use the provided build script:
   ```
   ./build.sh
   ```
   This will create the build in the `build/cline` directory.

2. Or manually build with CMake:
   ```
   mkdir -p build/cline
   cd build/cline
   cmake ../..
   make
   ```

3. To build without ZLIB support:
    ```
    mkdir -p build/cline
    cd build/cline
    cmake ../.. -DVNCCLIENT_USE_ZLIB=OFF
    make
    ```

4. Run the example application:
   ```
   build/cline/examples/vncclient/vnc-watcher
   ```

### Build Steps with Qt Creator

1. Open the main project file in Qt Creator:
   ```
   qtcreator CMakeLists.txt
   ```

2. Configure the project for your kit
   
3. Build the project

### Using the Library

#### With CMake

Add the following to your CMakeLists.txt:

```cmake
find_package(Qt NAMES Qt6 Qt5 REQUIRED COMPONENTS Widgets Network)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Widgets Network)

# Either link directly if built together
target_link_libraries(YourTarget PRIVATE QtVnc)

# Or find external package if installed
find_package(QtVnc REQUIRED)
target_link_libraries(YourTarget PRIVATE QtVnc::QtVnc)
```

#### With QMake

Add the following to your .pro file:
   ```
   # For Qt 5
   QT += widgets network
   LIBS += -L/path/to/library -lQtVnc
   INCLUDEPATH += /path/to/include/QtVnc
   ```

## Usage

```cpp
#include <QtVncClient/qvncclient.h>
#include <QTcpSocket>

// Create a VNC client
QVncClient* vncClient = new QVncClient(this);

// Create a socket and connect to a VNC server
QTcpSocket* socket = new QTcpSocket(this);
socket->connectToHost("192.168.1.100", 5900);

// Set the socket for the VNC client
vncClient->setSocket(socket);

// To display the VNC screen, connect to the imageChanged signal
connect(vncClient, &QVncClient::imageChanged, this, [this, vncClient](const QRect &) {
    // Update your UI with the new image
    QImage screen = vncClient->image();
    // e.g., myLabel->setPixmap(QPixmap::fromImage(screen));
});

// Handle screen size changes
connect(vncClient, &QVncClient::framebufferSizeChanged, this, 
    [this](int width, int height) {
        // Resize your UI components accordingly
    });
```

## Documentation

The library provides comprehensive documentation in multiple formats:

### API Documentation

- **QDoc format**: Located in `src/vncclient/*.qdoc` files
  - Build with: `qdoc src/vncclient/vncclient.qdocconf`
  - View in Qt Assistant after building

- **Markdown format**: Located at `src/vncclient/api_documentation.md`
  - Viewable in any Markdown viewer or editor

### Example Code

The `examples/vncclient/` directory contains a fully functional VNC client application that demonstrates how to use the library in a real-world scenario.

## License

Qt VNC Client is available under the:
- GNU Lesser General Public License v3 (LGPL-3.0)
- GNU General Public License v2 (GPL-2.0)
- GNU General Public License v3 (GPL-3.0)

## Authors

Signal Slot Inc.

Copyright (C) 2025 Signal Slot Inc.