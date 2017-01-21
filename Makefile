SDK := "-sdk:4.5" "-define:NET_4_5"
#SDK := "-sdk:2" "-define:NET_2"

CC := gcc
MONO := "/C/Program Files (x86)/Mono/bin/mono"
MCS := $(MONO) "C:/Program Files (x86)/Mono/lib/mono/4.5/mcs.exe" $(SDK)
RM := rm -rf

CFLAGS := -I./lua-5.3.3/include -L./lua-5.3.3/lib -llua

DLL := sharplua.dll
BIN := sharplua.exe

all : $(DLL) $(BIN)

$(DLL) : sharplua.c
	$(CC) -g -Wall -o $@ --shared $^ $(CFLAGS)

$(BIN) : test.cs sharplua.cs sharpobject.cs
	$(MCS) -codepage:utf8 -out:$@ $^

test: $(BIN)
	$(MONO) $<

dotnetcore: $(DLL)
	dotnet restore
	dotnet build
	
dotnetrun: dotnetcore
	dotnet run

clean:
	$(RM) *.dll *.exe $(DLL) $(BIN)
	$(RM) project.lock.json
	$(RM) bin/ obj/

