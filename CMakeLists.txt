cmake_minimum_required(VERSION 3.16)

project(MainProject LANGUAGES CXX)

# Estándar de C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Exportar compile_commands.json para clangd
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Código común (sin main)
file(GLOB SOURCES CONFIGURE_DEPENDS
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
)

# Ejecutables
add_executable(main.out
    ${SOURCES}
    "${CMAKE_SOURCE_DIR}/src/apps/main.cpp"
)

add_executable(prub.out
    ${SOURCES}
    "${CMAKE_SOURCE_DIR}/src/apps/prub.cpp"
)

# Configuración común para ambos
foreach(target main.out prub.out)

    target_include_directories(${target} PRIVATE
        "${CMAKE_SOURCE_DIR}/include"
    )

    target_compile_options(${target} PRIVATE
        -Wall
        -Wextra
        -Wpedantic
        -Wshadow
        -Wconversion
        -Wsign-conversion
        -Wfloat-equal
        $<$<CONFIG:Debug>:-g>
        $<$<CONFIG:Release>:-O2;-march=native;-mtune=native>
    )

endforeach()
