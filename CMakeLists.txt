# Copyright (C) 2025 Signal Slot Inc.
# SPDX-License-Identifier: LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

cmake_minimum_required(VERSION 3.16.0)

include(.cmake.conf)
project(QtVncClient
    VERSION "${QT_REPO_MODULE_VERSION}"
    DESCRIPTION "Qt Vnc Client Libraries"
    HOMEPAGE_URL "https://gitlab.com/signal-slot/qtvncclient.git"
    LANGUAGES CXX C
)

# Option to enable ZLIB support (for Tight and ZRLE encoding)
option(VNCCLIENT_USE_ZLIB "Enable ZLIB compression support" ON)

find_package(Qt6 ${PROJECT_VERSION} CONFIG REQUIRED COMPONENTS
    BuildInternals
    Gui
    Network
)
find_package(Qt6 ${PROJECT_VERSION} CONFIG OPTIONAL_COMPONENTS
    Widgets
    Test
)

qt_internal_project_setup()

qt_build_repo()
