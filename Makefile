LIBS = -lpthread -ggdb
COMPILE = gcc
OPTFLAGS = -Wall -O2
LDFLAGS = -L/usr/lib -lform -lmenu -lpanel -lncurses -lm
MKDIR = /bin/mkdir -p
INSTALL = /bin/cp
SETRX = /bin/chmod 755
SETR = /bin/chmod 644
DESTROOT = /usr/local
BINDIR = $(DESTROOT)/bin/
SBINDIR = $(DESTROOT)/sbin/
MAN1DIR = $(DESTROOT)/man/man1/
MAN8DIR = $(DESTROOT)/man/man8/
INITDIR = /etc/init.d/

all: tmon tmond

tmon: tmon.c
	$(COMPILE) $(OPTFLAGS) -o tmon tmon.c $(LDFLAGS)

tmond: tmond.c
	$(COMPILE) $(OPTFLAGS) -o tmond tmond.c $(LIBS)

install: install-man install-client install-server

install-man:
	$(MKDIR) $(MAN1DIR)
	$(INSTALL) tmon.1 $(MAN1DIR)
	$(SETR) $(MAN1DIR)/tmon.1
	$(MKDIR) $(MAN8DIR)
	$(INSTALL) tmond.8 $(MAN8DIR)
	$(SETR) $(MAN8DIR)/tmond.8

install-client: tmon
	$(MKDIR) $(BINDIR)
	$(INSTALL) tmon $(BINDIR)
	$(SETRX) $(BINDIR)/tmon
	$(MKDIR) $(MAN1DIR)
	$(INSTALL) tmon.1 $(MAN1DIR)
	$(SETR) $(MAN1DIR)/tmon.1

install-server: tmond
	$(MKDIR) $(SBINDIR)
	$(INSTALL) tmond $(SBINDIR)
	$(SETRX) $(SBINDIR)/tmond
	$(MKDIR) $(MAN8DIR)
	$(INSTALL) tmond.8 $(MAN8DIR)
	$(SETR) $(MAN8DIR)/tmond.8
	$(INSTALL) tmond.init $(INITDIR)/tmond
	$(SETRX) $(INITDIR)/tmond
	$(INITDIR)/tmond start
clean:
	rm -f tmon tmond

