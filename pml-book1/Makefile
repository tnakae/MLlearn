MARP = ./conv.sh

SRCS = $(shell ls *.md)
OBJS = $(SRCS:.md=.html)

all: $(OBJS)

%.html : %.md $(MARP)
	$(MARP) $< --html

clean:
	rm $(OBJS)

