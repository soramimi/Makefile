
NAME := myapp

SRCS := main.cpp

CC := gcc
CXX := g++
LD := $(CXX)
CFLAGS := -O3
CXXFLAGS := -O3

OBJS := $(SRCS:%.c=%.o)
OBJS := $(OBJS:%.cpp=%.o)
OBJS := $(OBJS:%.cc=%.o)
DEPS := $(SRCS:%.c=%.d)
DEPS := $(DEPS:%.cpp=%.d)
DEPS := $(DEPS:%.cc=%.d)

all: $(NAME)

$(NAME): $(OBJS)
	$(info OBJS = $(OBJS))
	$(LD) $(OBJS) -o $(NAME) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -MMD -MP -MF $(<:%.c=%.d) -c $<

.cpp.o:
	$(CXX) $(CXXFLAGS) -MMD -MP -MF $(<:%.cpp=%.d) -c $<

.cc.o:
	$(CXX) $(CXXFLAGS) -MMD -MP -MF $(<:%.cc=%.d) -c $<

.PHONY: clean
clean:
	rm -f $(NAME) *.o *.d

.PHONY: run
run:
	./$(NAME)

.PHONY: install
install:
	install -m 755 $(NAME) ~/.local/bin/

.PHONY: uninstall
uninstall:
	rm ~/.local/bin/$(NAME)

-include $(DEPS)

