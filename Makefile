# Support luajit and check for it
LUA = $(shell lua -e 'if type(jit) == "table" then print "luajit" else print "lua" end')
PKGS      = libpulse $(LUA)

INCS     := $(shell pkg-config --cflags $(PKGS)) -I./
CFLAGS   := -std=gnu99 -ggdb -W -Wall -Wextra -fPIC -pedantic $(INCS) $(CFLAGS)

LIBS     := $(shell pkg-config --libs $(PKGS))
LDFLAGS  := $(LIBS) $(LDFLAGS) $(LIBFLAG) -Wl,--export-dynamic

SRCS  = $(wildcard *.c)
HEADS = $(wildcard *.h)
OBJS  = $(foreach obj,$(SRCS:.c=.o),$(obj))

pulseaudio.so: $(OBJS)
	@echo $(CC) -o $@ $(OBJS)
	@$(CC) -shared -o $@ $(OBJS) $(LDFLAGS)

$(OBJS): $(HEADS)

.c.o:
	@echo $(CC) -c $< -o $@
	@$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -f pulseaudio.so $(OBJS)

test:
	lua -e "require('pulseaudio')"

install: pulseaudio.so
	cp pulseaudio.so $(INST_LIBDIR)

all: pulseaudio.so
