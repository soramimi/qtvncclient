# Qt VNC Client Documentation

This directory contains the QDoc documentation for the Qt VNC Client module.

## Documentation Files

- `qvncclient.qdoc` - Main class documentation for QVncClient
- `qtvncclient.qdoc` - Module-level documentation
- `qtvncclientglobal.qdoc` - Documentation for global definitions and logging
- `examples.qdoc` - Documentation for example applications
- `vncclient.qdocconf` - QDoc configuration file

## Building the Documentation

To build the documentation, you need to have Qt's documentation tools installed.

```bash
# Navigate to the build directory
cd /path/to/build/directory

# Run qdoc
qdoc src/vncclient/vncclient.qdocconf

# The generated documentation will be in doc/qtvncclient
```

## Viewing the Documentation

After building, you can open the generated HTML files in your browser:

```bash
# Open the index page
open doc/qtvncclient/index.html
```

## Documentation Structure

The documentation is organized as follows:

- **Module Overview** - General introduction to the Qt VNC Client module
- **Classes** - Detailed API documentation for each class
- **Examples** - Tutorial and sample code demonstrating usage patterns

## Adding to the Documentation

When adding new classes or features:

1. Document each public API with proper QDoc comments in the header files
2. Create example code demonstrating the usage
3. Update the module documentation to reference new features
4. Run the documentation build to verify everything is correctly formatted