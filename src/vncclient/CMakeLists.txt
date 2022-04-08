# Copyright (C) 2025 Signal Slot Inc.
# SPDX-License-Identifier: LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

# Find required dependencies for Tight encoding
find_package(ZLIB REQUIRED)
find_package(JPEG REQUIRED)
 
qt_internal_add_module(VncClient
    SOURCES
        qtvncclientglobal.h
        qvncclient.cpp
        qtvncclientlogging.cpp
        qvncclient.h
    LIBRARIES
        ZLIB::ZLIB
        JPEG::JPEG
    INCLUDE_DIRECTORIES
        ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC_LIBRARIES
        Qt::Core
        Qt::Network
        Qt::Gui
)

