find_package(Qt6 REQUIRED COMPONENTS Gui)

add_library(Backend STATIC)

qt_add_qml_module(Backend
    URI "Backend"
    VERSION 1.0
    RESOURCE_PREFIX "/"
    SOURCES
        animatedparam.cpp
        animatedparam.h
        backend.cpp
        backend.h
)

target_link_libraries(Backend PRIVATE Qt6::Gui)
