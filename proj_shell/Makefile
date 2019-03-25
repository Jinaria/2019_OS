# Compiler and Compile option
CC = gcc
CXXFLAGS = -g -Wall -std=c++11

# Macros specifying path for compile.
SRCS := $(wildcard src/*.c)
OBJS := $(SRCS:.c=.o)
BIN = ./bin/
INC = ./include/
lib = ./lib/

# pre-processor
# CPPFLAGS += -I$(INC)

# Compile command
TARGET = shell
$(TARGET): $(OBJS)
	$(CC) $(CXXFLAGS) -o $(BIN)$(TARGET) $(OBJS)

# Delete
clean: 
	rm $(BIN)$(TARGET) $(OBJS)