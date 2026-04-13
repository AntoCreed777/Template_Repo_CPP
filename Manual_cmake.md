# Guía de migración: Makefile → CMake

Este proyecto fue migrado desde un flujo basado en `Makefile` a uno basado en `CMake`.

La idea de este documento es mostrar las equivalencias entre los comandos que se usaban antes con `make` y los que se usan ahora con `cmake`.

---

## Diferencia conceptual

Con `Makefile`, el flujo típico era:

```bash
make
```

Con `CMake`, el flujo se separa en dos etapas:

1. **Configuración**
2. **Compilación**

Ejemplo:

```bash
cmake -S . -B build
cmake --build build
```

* `-S .` indica el directorio fuente
* `-B build` indica el directorio donde se generarán los archivos de compilación

---

## Equivalencias de comandos

| Acción                                | Makefile                    | CMake                                                             |
| ------------------------------------- | --------------------------- | ----------------------------------------------------------------- |
| Configurar proyecto por primera vez   | *(no aplica)*               | `cmake -S . -B build`                                             |
| Compilar proyecto                     | `make`                      | `cmake --build build`                                             |
| Compilar en paralelo                  | `make -j`                   | `cmake --build build -j`                                          |
| Limpiar archivos compilados           | `make clean`                | `cmake --build build --target clean`                              |
| Limpiar completamente la build        | *(no se usaba normalmente)* | `rm -rf build`                                                    |
| Ejecutar el programa principal        | `make run`                  | `./build/main.out`                                                |
| Abrir el programa en GDB              | `make debug`                | `gdb ./build/main.out`                                            |
| Revisar fugas de memoria con Valgrind | `make memoria`              | `valgrind --leak-check=full --track-origins=yes ./build/main.out` |
| Recompilar desde cero                 | `make clean && make`        | `rm -rf build && cmake -S . -B build && cmake --build build`      |

---

## Flujo recomendado

### Primera compilación

```bash
cmake -S . -B build
cmake --build build
```

### Compilaciones posteriores

Si solo cambiaste archivos `.cpp` o `.h`:

```bash
cmake --build build
```

### Si cambiaste el `CMakeLists.txt`

Debes reconfigurar antes de compilar:

```bash
cmake -S . -B build
cmake --build build
```

### Si algo se rompe raro

Haz una limpieza total:

```bash
rm -rf build
cmake -S . -B build
cmake --build build
```

---

## Debug y herramientas

### Ejecutar el binario principal

```bash
./build/main.out
```

### Debug con GDB

```bash
gdb ./build/main.out
```

### Valgrind

```bash
valgrind --leak-check=full --track-origins=yes ./build/main.out
```

---

## Múltiples ejecutables

En este proyecto, la idea es separar:

* `src/` → código común, sin `main()`
* `src/ejecutables/` → archivos con `main()`

De esta forma, CMake puede construir distintos ejecutables reutilizando el código compartido.

Ejemplo conceptual:

* `main.out`
* `prub.out`

Para compilar un ejecutable específico:

```bash
cmake --build build --target main.out
cmake --build build --target prub.out
```

Para ejecutar uno específico:

```bash
./build/main.out
./build/prub.out
```

---

## Resumen rápido

### Antes

```bash
make
make run
make debug
make memoria
make clean
```

### Ahora

```bash
cmake -S . -B build
cmake --build build
./build/main.out
gdb ./build/main.out
valgrind --leak-check=full --track-origins=yes ./build/main.out
cmake --build build --target clean
```

---

## Nota final

`CMake` puede parecer más verboso al principio que un `Makefile` simple, pero escala mucho mejor cuando:

* hay múltiples ejecutables
* se quiere separar código común
* se manejan configuraciones `Debug` y `Release`
* se integra el proyecto con herramientas como `clangd`, IDEs o generadores como `Ninja`
