# Proyecto C++ con CMake

Template minimalista para proyectos C++ con CMake.

Soporta:
- Múltiples ejecutables en un mismo proyecto
- Compartir librerías internas entre ejecutables
- Debug (GDB/Valgrind) y Release (-O3) con presets

## Estructura

```text
.
├── CMakeLists.txt
├── CMakePresets.json
├── cmake/
├── include/
├── src/
├── apps/
└── docs/
```

## Uso rápido

**Debug:**
```bash
cmake --preset debug
cmake --build --preset debug
./build/debug/apps/main_app
```

**Release:**
```bash
cmake --preset release
cmake --build --preset release
./build/release/apps/main_app
```

## Agregar ejecutable

1. Crear archivo en `apps/`, ej: `apps/tool.cpp`
2. Agregar en `apps/CMakeLists.txt`:
```cmake
add_project_executable(tool SOURCES tool.cpp)
```

## Documentación

- [cmake_workflow.md](docs/cmake_workflow.md) - Cómo funciona CMake
- [conventions.md](docs/conventions.md) - Convenciones de nombres
