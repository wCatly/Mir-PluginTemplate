TARGET= example.dll
BOTM_SDK_DIR= ../../../botm_sdk

CC= g++ -m32 -s -shared -Wl,--subsystem,windows
CCOPT= -O2 -fomit-frame-pointer -flto
CCOPT_x86= -march=i686 -msse -msse2 -mfpmath=sse
LFLAGS= -Wl,-Bdynamic -L$(BOTM_SDK_DIR)/Lib -lbotm -static -lstdc++ 
IFLAGS= -I$(BOTM_SDK_DIR)/Include

COMPILE= $(CC) -o $@ $^ $(CCOPT) $(CCOPT_x86) $(LFLAGS)

DEPS= $(BOTM_SDK_DIR)/Include/*
OBJS= example.o 

%.o: %.cpp $(DEPS)
	$(CC) $(IFLAGS) -c -o $@ $< $(CCOPT) $(CCOPT_x86)

all: $(TARGET)

$(TARGET): $(OBJS) 
	$(COMPILE)
	
clean:
	rm -f *.o
	rm -f *.dll

.PHONY: clean all