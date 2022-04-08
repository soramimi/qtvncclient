# Qt VNC Client API Documentation

*Last Updated: February 2025*

## QVncClient Class

The `QVncClient` class provides a client implementation for the VNC (Virtual Network Computing) protocol. It enables Qt applications to connect to VNC servers, receive framebuffer updates, and send keyboard and mouse events to control remote desktops.

### Class Overview

```cpp
class QVncClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QTcpSocket *socket READ socket WRITE setSocket NOTIFY socketChanged)
    Q_PROPERTY(ProtocolVersion protocolVersion READ protocolVersion NOTIFY protocolVersionChanged)
    Q_PROPERTY(SecurityType securityType READ securityType NOTIFY securityTypeChanged)
public:
    // Enums
    enum ProtocolVersion {
        ProtocolVersionUnknown,
        ProtocolVersion33 = 0x0303,
        ProtocolVersion37 = 0x0307,
        ProtocolVersion38 = 0x0308,
    };
    Q_ENUM(ProtocolVersion)
    
    enum SecurityType : qint8 {
        SecurityTypeUnknown = -1,
        SecurityTypeInvalid = 0,
        SecurityTypeNone = 1,
        SecurityTypeVncAuthentication = 2,
        SecurityTypeRA2 = 5,
        SecurityTypeRA2ne = 6,
        SecurityTypeTight = 16,
        SecurityTypeUltra = 17,
        SecurityTypeTLS = 18,
        SecurityTypeVeNCrypt = 19,
        SecurityTypeGtkVncSasl = 20,
        SecurityTypeMd5HashAuthentication = 21,
        SecurityTypeColinDeanXvp = 22,
        // More security types will be added in future versions
    };
    Q_ENUM(SecurityType)

    // Constructor & Destructor
    explicit QVncClient(QObject *parent = nullptr);
    ~QVncClient() override;

    // Properties
    QTcpSocket *socket() const;
    ProtocolVersion protocolVersion() const;
    SecurityType securityType() const;
    
    // Framebuffer methods
    int framebufferWidth() const;
    int framebufferHeight() const;
    QImage image() const;
    
    // Input event handling
    void handleKeyEvent(QKeyEvent *e);
    void handlePointerEvent(QMouseEvent *e);

public slots:
    void setSocket(QTcpSocket *socket);
    
signals:
    void socketChanged(QTcpSocket *socket);
    void protocolVersionChanged(ProtocolVersion protocolVersion);
    void securityTypeChanged(SecurityType securityType);
    void framebufferSizeChanged(int width, int height);
    void imageChanged(const QRect &rect);
    void connectionStateChanged(bool connected);
};
```

### Current Capabilities

This implementation currently supports:
- VNC Protocol version 3.3 (fully implemented)
- VNC Protocol versions 3.7 and 3.8 (basic support, treated as 3.3)
- Basic security types (primarily None authentication)
- Multiple encoding methods for framebuffer updates:
  - Raw encoding (uncompressed)
  - Hextile encoding (basic compression)
  - ZRLE encoding (zlib-based compression)
  - **NEW!** Tight encoding (zlib and JPEG compression)
- Keyboard and pointer (mouse) event handling

> **Note**: See the [ROADMAP.md](../../ROADMAP.md) file for planned improvements, including full implementation of protocols 3.7 and 3.8, additional security types, and more encoding methods.

### Enums

#### ProtocolVersion

```cpp
enum ProtocolVersion {
    ProtocolVersionUnknown,
    ProtocolVersion33 = 0x0303,
    ProtocolVersion37 = 0x0307,
    ProtocolVersion38 = 0x0308,
};
```

Represents the VNC protocol version:

- **ProtocolVersionUnknown**: Unknown or unsupported protocol version.
- **ProtocolVersion33**: VNC protocol version 3.3.
- **ProtocolVersion37**: VNC protocol version 3.7.
- **ProtocolVersion38**: VNC protocol version 3.8.

#### SecurityType

```cpp
enum SecurityType : qint8 {
    SecurityTypeUnknown = -1,
    SecurityTypeInvalid = 0,
    SecurityTypeNone = 1,
    SecurityTypeVncAuthentication = 2,
    SecurityTypeRA2 = 5,
    SecurityTypeRA2ne = 6,
    SecurityTypeTight = 16,
    SecurityTypeUltra = 17,
    SecurityTypeTLS = 18,
    SecurityTypeVeNCrypt = 19,
    SecurityTypeGtkVncSasl = 20,
    SecurityTypeMd5HashAuthentication = 21,
    SecurityTypeColinDeanXvp = 22
};
```

Represents the security type used for VNC authentication:

- **SecurityTypeUnknown**: Unknown security type.
- **SecurityTypeInvalid**: Invalid security type.
- **SecurityTypeNone**: No authentication required.
- **SecurityTypeVncAuthentication**: Standard VNC authentication (password-based).
- **SecurityTypeRA2**: RSA-based security authentication.
- **SecurityTypeRA2ne**: RSA-based security authentication.
- **SecurityTypeTight**: Tight-specific authentication.
- **SecurityTypeUltra**: UltraVNC-specific authentication.
- **SecurityTypeTLS**: TLS security type.
- **SecurityTypeVeNCrypt**: VeNCrypt security type.
- **SecurityTypeGtkVncSasl**: SASL authentication used by GTK-VNC.
- **SecurityTypeMd5HashAuthentication**: MD5 hash authentication.
- **SecurityTypeColinDeanXvp**: Colin Dean XVP authentication.

> **Implementation Note**: Currently, only SecurityTypeNone is fully implemented. Other security types are defined for future implementation.

### Properties

#### socket
The TCP socket used for the VNC connection.

```cpp
QTcpSocket *socket() const;
void setSocket(QTcpSocket *socket);
void socketChanged(QTcpSocket *socket);
```

The socket should be created and connected to the VNC server by the application. Once set, the VNC handshaking process will begin automatically.

> **Usage Note**: The application is responsible for creating and managing the socket lifecycle. The QVncClient will not delete the socket when destroyed.

#### protocolVersion
The negotiated VNC protocol version.

```cpp
ProtocolVersion protocolVersion() const;
void protocolVersionChanged(ProtocolVersion protocolVersion);
```

This property is updated automatically after connecting to a VNC server and completing the protocol handshake. It is read-only from the application side.

#### securityType
The negotiated security type for the VNC connection.

```cpp
SecurityType securityType() const;
void securityTypeChanged(SecurityType securityType);
```

This property is updated automatically after connecting to a VNC server and completing the protocol handshake. It is read-only from the application side.

### Framebuffer Methods

#### framebufferWidth
Returns the width of the remote framebuffer in pixels.

```cpp
int framebufferWidth() const;
```

This value is available after successful connection to a VNC server and completion of the initialization phase.

> **Return Value**: Width of the remote framebuffer in pixels, or 0 if not connected.

#### framebufferHeight
Returns the height of the remote framebuffer in pixels.

```cpp
int framebufferHeight() const;
```

This value is available after successful connection to a VNC server and completion of the initialization phase.

> **Return Value**: Height of the remote framebuffer in pixels, or 0 if not connected.

#### image
Returns the current framebuffer image.

```cpp
QImage image() const;
```

This image represents the current state of the remote desktop. It is updated each time framebuffer updates are received from the server.

> **Return Value**: A QImage containing the current framebuffer contents. May be empty if not connected.

### Input Event Handling

#### handleKeyEvent
Handles a keyboard event and sends it to the VNC server.

```cpp
void handleKeyEvent(QKeyEvent *e);
```

This method should be called when keyboard events occur in the client application that should be forwarded to the remote VNC server.

> **Parameters**:
> - **e**: A QKeyEvent object containing information about the key event.
>
> **Supported Event Types**:
> - QEvent::KeyPress
> - QEvent::KeyRelease

#### handlePointerEvent
Handles a mouse event and sends it to the VNC server.

```cpp
void handlePointerEvent(QMouseEvent *e);
```

This method should be called when mouse events occur in the client application that should be forwarded to the remote VNC server.

> **Parameters**:
> - **e**: A QMouseEvent object containing information about the mouse event.
>
> **Supported Event Types**:
> - QEvent::MouseButtonPress
> - QEvent::MouseButtonRelease
> - QEvent::MouseMove

### Signals

#### framebufferSizeChanged
Emitted when the framebuffer size changes.

```cpp
void framebufferSizeChanged(int width, int height);
```

This typically occurs when first connecting to the VNC server, or if the remote desktop is resized.

> **Parameters**:
> - **width**: The new width of the framebuffer in pixels.
> - **height**: The new height of the framebuffer in pixels.

#### imageChanged
Emitted when a portion of the framebuffer image changes.

```cpp
void imageChanged(const QRect &rect);
```

The application should update its display of the framebuffer in the specified rectangle.

> **Parameters**:
> - **rect**: The rectangle within the framebuffer that has been updated.

#### connectionStateChanged
Emitted when the connection state changes.

```cpp
void connectionStateChanged(bool connected);
```

The parameter is true if connected to the VNC server, false if disconnected.

> **Parameters**:
> - **connected**: True if connected to the VNC server, false if disconnected.

## Example Usage

```cpp
#include <QtVncClient/qvncclient.h>
#include <QApplication>
#include <QLabel>
#include <QTcpSocket>
#include <QVBoxLayout>
#include <QPushButton>
#include <QDebug>

class VncViewer : public QLabel
{
    Q_OBJECT
public:
    VncViewer(QWidget *parent = nullptr)
        : QLabel(parent),
          m_client(new QVncClient(this))
    {
        // Set up socket
        QTcpSocket *socket = new QTcpSocket(this);
        m_client->setSocket(socket);
        
        // Connect to signals
        connect(m_client, &QVncClient::imageChanged,
                this, &VncViewer::updateImage);
        connect(m_client, &QVncClient::framebufferSizeChanged,
                this, &VncViewer::resizeToFramebuffer);
        connect(m_client, &QVncClient::connectionStateChanged,
                this, &VncViewer::handleConnectionChange);
    }
    
    void connectToHost(const QString &host, quint16 port = 5900)
    {
        m_client->socket()->connectToHost(host, port);
    }
    
protected:
    // Forward input events to the VNC server
    void keyPressEvent(QKeyEvent *event) override
    {
        m_client->handleKeyEvent(event);
    }
    
    void keyReleaseEvent(QKeyEvent *event) override
    {
        m_client->handleKeyEvent(event);
    }
    
    void mouseMoveEvent(QMouseEvent *event) override
    {
        m_client->handlePointerEvent(event);
    }
    
    void mousePressEvent(QMouseEvent *event) override
    {
        m_client->handlePointerEvent(event);
    }
    
    void mouseReleaseEvent(QMouseEvent *event) override
    {
        m_client->handlePointerEvent(event);
    }
    
private slots:
    void updateImage(const QRect &rect)
    {
        setPixmap(QPixmap::fromImage(m_client->image()));
    }
    
    void resizeToFramebuffer(int width, int height)
    {
        resize(width, height);
        setPixmap(QPixmap::fromImage(m_client->image()));
    }
    
    void handleConnectionChange(bool connected)
    {
        if (connected)
            qDebug() << "Connected to VNC server";
        else
            qDebug() << "Disconnected from VNC server";
    }
    
private:
    QVncClient *m_client;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    // Create main window
    QWidget mainWindow;
    QVBoxLayout *layout = new QVBoxLayout(&mainWindow);
    
    // Create VNC viewer
    VncViewer viewer;
    layout->addWidget(&viewer);
    
    // Add connect button
    QPushButton *connectButton = new QPushButton("Connect to localhost");
    layout->addWidget(connectButton);
    QObject::connect(connectButton, &QPushButton::clicked, [&viewer]() {
        viewer.connectToHost("localhost");
    });
    
    mainWindow.resize(800, 600);
    mainWindow.setWindowTitle("Qt VNC Client Example");
    mainWindow.show();
    
    return app.exec();
}
```

## Implementation Notes

### Thread Safety

The QtVncClient classes are not thread-safe. They should be used from the main thread or from a single thread.

### Encoding Types

The library supports multiple encoding types for framebuffer updates, each with different characteristics:

#### Raw Encoding
- No compression, direct pixel data
- Highest bandwidth usage
- Lowest CPU usage
- Best for high-speed local networks

#### Hextile Encoding
- Divides rectangle into 16x16 tiles
- Moderate compression
- Low CPU usage
- Good for medium-speed networks

#### ZRLE Encoding
- Zlib Run-Length Encoding
- Good compression
- Moderate CPU usage
- Suitable for slower networks

#### Tight Encoding
- Combines zlib compression and JPEG
- Best compression ratios
- Higher CPU usage
- Ideal for slow networks or when bandwidth is limited
- Especially efficient for photographic content

The library automatically negotiates the best encoding with the server based on what both support. Tight encoding is preferred when available for its superior compression.

### Performance Considerations

- When handling large framebuffers, consider using the `imageChanged` signal to update only the modified portions of the display.
- For bandwidth-constrained connections, the newly implemented Tight encoding offers the best compression.
- For high-performance local connections where CPU might be limited, consider using Raw or Hextile encoding.

## License Information

Qt VNC Client is available under the commercial Qt license and under the GNU Lesser General Public License v3, GNU General Public License v2, or GNU General Public License v3.

## Future Enhancements

For information about planned improvements to the Qt VNC Client library, please refer to the [ROADMAP.md](../../ROADMAP.md) file.