# Qt VNC Client Documentation Guide

This guide explains how to build, view, and maintain the Qt VNC Client API documentation.

## Documentation Files

The documentation for Qt VNC Client is provided in multiple formats:

1. **QDoc documentation** (for Qt Help System):
   - `qvncclient.qdoc` - Main class documentation
   - `qtvncclient.qdoc` - Module documentation
   - `qtvncclientglobal.qdoc` - Global symbols documentation
   - `examples.qdoc` - Example code documentation
   - `vncclient.qdocconf` - QDoc configuration file

2. **Markdown documentation**:
   - `api_documentation.md` - Complete API reference in Markdown format

3. **In-code documentation**:
   - Header comments in `qvncclient.h`
   - Implementation comments in `qvncclient.cpp`

## Building the Documentation

### Building Qt Help Documentation

To build the Qt Help documentation, you need to have Qt's documentation tools installed.

```bash
# Install Qt documentation tools if not already available
sudo apt-get install qt6-documentation-tools   # For Debian/Ubuntu
# or
brew install qt6-documentation-tools           # For macOS

# Navigate to the build directory
cd /path/to/build/directory

# Run qdoc
qdoc src/vncclient/vncclient.qdocconf

# The generated documentation will be in doc/qtvncclient
```

After building, you can view the documentation in Qt Assistant:

```bash
assistant -collectionFile doc/qtvncclient/qtvncclient.qhc
```

### Viewing Markdown Documentation

The Markdown documentation (`api_documentation.md`) can be viewed directly in any Markdown viewer, including:

- VS Code with Markdown Preview
- GitHub web interface
- Any Markdown editor

## Using the Documentation in Your Project

### Integrating with Qt Help System

To integrate the Qt VNC Client documentation with your application's Qt Help system:

1. Add the `.qch` file to your Qt Assistant or Qt Creator:
   - In Qt Creator: Tools > Options > Help > Documentation > Add
   - Select the `doc/qtvncclient/qtvncclient.qch` file

2. To programmatically integrate with QHelpEngine:

```cpp
QHelpEngineCore helpEngine("myapp.qhc");
helpEngine.setupData();
helpEngine.registerDocumentation("doc/qtvncclient/qtvncclient.qch");
```

### Linking to Documentation from Code

You can use Qt's standard documentation markup in your application code to link to the VNC client documentation:

```cpp
/*!
    Creates a VNC viewer widget that uses the QVncClient class.
    \sa QVncClient
*/
MyVncViewer::MyVncViewer()
{
    // Implementation
}
```

## Maintaining Documentation

When making changes to the Qt VNC Client library:

1. **Update header documentation**: Ensure any new methods, signals, or properties are documented in the header file

2. **Update QDoc files**: Update the relevant `.qdoc` files with details of new features

3. **Update Markdown documentation**: Keep the `api_documentation.md` file synchronized with code changes

4. **Example code**: Add or update examples to demonstrate new features

5. **Rebuild documentation**: Regenerate the Qt Help documentation before releases

## Best Practices

- Use consistent terminology throughout the documentation
- Include example code for each major feature
- Document error conditions and edge cases
- Provide cross-references between related classes and methods
- Update documentation when code behavior changes

## Qt Documentation References

For more information on writing Qt documentation:

- [QDoc Manual](https://doc.qt.io/qt-6/qdoc-index.html)
- [Qt Documentation Best Practices](https://wiki.qt.io/Qt_Documentation_Best_Practices)