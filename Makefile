PROJECTS = ozw-power-on-off     \
           ozw-pir-power-switch \
           ozw-pir-active
OUT      = $(addsuffix .out,$(PROJECTS))
OBJ      = $(addsuffix .o,$(PROJECTS))
OZWAY    = ozway
CC       = g++
SRCDIR   = $(OZWAY)/cpp/src/
IFLAGS   = -I $(SRCDIR)                \
           -I $(SRCDIR)command_classes \
           -I $(SRCDIR)platform        \
           -I $(SRCDIR)value_classes
LIBS     = -lopenzwave \
           -lpthread
LDFLAGS   = -L/usr/local/lib -Wl,-R/usr/local/lib '-Wl,-R$$ORIGIN' -L$(OZWAY)
CFLAGS   = -std=c++11

all: ozway_lib $(OUT)

$(OUT): %.out: %.o
	echo "making out"
	$(CC) $(LDFLAGS) $< $(LIBS) -o $@

$(OBJ): %.o: %/Main.cpp
	echo "making obj"
	$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

ozway_lib:
	echo "making lib"
	$(MAKE) -C $(OZWAY)

clean:
	rm -rf *.o *.out

re: clean all

