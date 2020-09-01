.phony: all clean

MIX := mix
CFLAGS := -Ofast -g -ansi -pedantic

LINK = 

ifdef CROSSCOMPILE
	CFLAGS += $(ERL_CFLAGS)
	LDFLAGS += $(ERL_LDFLAGS)
else
	ERLANG_PATH += $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
	CFLAGS += -I$(ERLANG_PATH)
endif
CFLAGS += -std=c11 -Wno-unused-function

PRIV := _build/dev/lib/nif_perf/priv

ifeq ($(OS), Windows_NT)
	TARGET_LIB = $(PRIV)/libnif.dll
else
	TARGET_LIB = $(PRIV)/libnif.so

	CFLAGS += -fPIC
	ifeq ($(shell uname), Darwin)
		ifndef CROSSCOMPILE
			CFLAGS += -I`xcrun --show-sdk-path 2>/dev/null`/usr/include
			LDFLAGS += -L`xcrun --show-sdk-path 2>/dev/null`/usr/lib
			LINK += -dynamiclib -undefined dynamic_lookup
		endif
	endif
endif

OBJS := obj/libnif.o

$(shell mkdir -p obj)
$(shell mkdir -p $(PRIV))


all: $(TARGET_LIB)
	

$(TARGET_LIB): $(OBJS)
	$(CC) $^ -o $@ -shared $(LDFLAGS) $(LINK)

obj/libnif.o: native/libnif.c


%.o %.c:
	$(CC) -c $< -o $@ $(CFLAGS)

clean:
	$(RM) $(TARGET_LIB)
