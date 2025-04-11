# Variables
CXX = g++
CXXFLAGS = -std=c++17 -Wall -g -I ./include
OBJ_DIR = build
TARGET = main.out

# Buscar todos los archivos .cpp en el directorio src
SOURCES = $(wildcard ./src/*.cpp)
OBJECTS = $(patsubst ./src/%.cpp, $(OBJ_DIR)/%.o, $(SOURCES))

.PHONY: all clean run debug

# Regla por defecto: compilar el programa
all: $(TARGET)

# Regla para compilar el programa
$(TARGET): $(OBJECTS)
	@echo "Compilando el programa..."
	@$(CXX) $(OBJECTS) -o $(TARGET) $(CXXFLAGS)

# Regla para compilar los archivos objeto y guardarlos en obj/
$(OBJ_DIR)/%.o: ./src/%.cpp | $(OBJ_DIR)
	@echo "Compilando $<..."
	@$(CXX) -c $< -o $@ $(CXXFLAGS)

# Crear el directorio obj si no existe
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# Regla para ejecutar el programa
run: $(TARGET)
	@echo "Ejecutando el programa...\n"
	@./$(TARGET)

# Regla para debuggear el programa
debug: $(TARGET)
	@gdb ./$(TARGET)

# Regla para investigar las fugas de memoria
memoria: $(TARGET)
	@valgrind --leak-check=full --track-origins=yes ./$(TARGET)

# Regla para limpiar los archivos generados
clean:
	@rm -rf $(OBJ_DIR) $(TARGET)