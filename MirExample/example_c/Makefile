TARGET= example.dll
BOTM_SDK_DIR= ../../../botm_sdk

CC= gcc -m32 -s -shared -Wl,--subsystem,windows
CCOPT= -O2 -fomit-frame-pointer -flto
CCOPT_x86= -march=i686 -msse -msse2 -mfpmath=sse
LFLAGS= -L$(BOTM_SDK_DIR)/Lib -lbotm
IFLAGS= -I$(BOTM_SDK_DIR)/Include

COMPILE= $(CC) -o $@ $^ $(CCOPT) $(CCOPT_x86) $(LFLAGS)

DEPS= $(BOTM_SDK_DIR)/Include/*
OBJS= example.o 

%.o: %.c $(DEPS)
	$(CC) $(IFLAGS) -c -o $@ $< $(CCOPT) $(CCOPT_x86)

all: $(TARGET)

$(TARGET): $(OBJS) 
	$(COMPILE)
	
clean:
	rm -f *.o
	rm -f *.dll

.PHONY: clean all