#
#  Copyright (c) 2018 - Present  Jeong Han Lee
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
# 
# Author  : Jeong Han Lee
# email   : jeonghan.lee@gmail.com
# Date    : Wednesday, February 14 13:47:04 CET 2018
# version : 0.0.2
# 

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile


## FROM NON-AUTOTOOLS-BUILD

USR_INCLUDES += -I$(where_am_I)


## (1) We don't use config.h, but to use -D
##     Some from generated config.h by Debian 8 (./configure)
##     Some from epics-module/stream

USR_CPPFLAGS += -DHAVE_MEMMOVE=1
USR_CPPFLAGS += -DNEWLINE=10
USR_CPPFLAGS += -DINT64_MAX="(0x7FFFFFFFFFFFLL)"
USR_CPPFLAGS += -DLINK_SIZE=2
USR_CPPFLAGS += -DMAX_NAME_COUNT=10000 -DMAX_NAME_SIZE=32
USR_CPPFLAGS += -DMATCH_LIMIT=10000000 -DMATCH_LIMIT_RECURSION=MATCH_LIMIT
USR_CPPFLAGS += -DPOSIX_MALLOC_THRESHOLD=10
USR_CPPFLAGS += -DPARENS_NEST_LIMIT=250
USR_CPPFLAGS += -DSUPPORT_PCRE8
USR_CPPFLAGS += -DHAVE_STDINT_H=1
USR_CPPFLAGS += -DHAVE_STDLIB_H=1
USR_CPPFLAGS += -DHAVE_STRING_H=1
USR_CPPFLAGS += -DHAVE_UNISTD_H=1
USR_CPPFLAGS += -DVERSION=$(E3_MODULE_VERSION)



SRC:=


##(5) For an 8-bit library, compile the following source files, setting
##     -DHAVE_CONFIG_H as a compiler option if you have set up config.h with your
##     configuration, or else use other -D settings to change the configuration
##     as required.

## 
## Note that you must still compile pcre_jit_compile.c, even if you have not
## defined SUPPORT_JIT in config.h, because when JIT support is not
## configured, dummy functions are compiled. When JIT support IS configured,
## pcre_jit_compile.c #includes sources from the sljit subdirectory, where
## there should be 16 files, all of whose names begin with "sljit".



SOURCES += $(SRC)/pcre_byte_order.c
#SOURCES += $(SRC)/pcre_chartables.c
SOURCES += $(SRC)/pcre_compile.c
SOURCES += $(SRC)/pcre_config.c
SOURCES += $(SRC)/pcre_dfa_exec.c
SOURCES += $(SRC)/pcre_exec.c
SOURCES += $(SRC)/pcre_fullinfo.c
SOURCES += $(SRC)/pcre_get.c
SOURCES += $(SRC)/pcre_globals.c
SOURCES += $(SRC)/pcre_jit_compile.c
SOURCES += $(SRC)/pcre_maketables.c
SOURCES += $(SRC)/pcre_newline.c
SOURCES += $(SRC)/pcre_ord2utf8.c
SOURCES += $(SRC)/pcre_refcount.c
SOURCES += $(SRC)/pcre_string_utils.c
SOURCES += $(SRC)/pcre_study.c
SOURCES += $(SRC)/pcre_tables.c
SOURCES += $(SRC)/pcre_ucd.c
SOURCES += $(SRC)/pcre_valid_utf8.c
SOURCES += $(SRC)/pcre_version.c
SOURCES += $(SRC)/pcre_xclass.c

SRCS_GENS += pcre_chartables.c
SOURCES += $(SRCS_GENS)

SOURCES += $(SRC)/pcre_printint.c

## (1) Copy or rename the file config.h.generic as config.h
## (2) Copy or rename the file pcre.h.generic as pcre.h.
## (3) Copy or rename file pcre_chartables.c.dist as pcre_chartables.c.
## (4) Ensure that you have the following header files:

HDRS_GENS += pcre.h

HEADERS += $(HDRS_GENS)


#SRCS_GENS += pcre_chartables.c

vpath %.generic   $(where_am_I)$(SRC)
vpath %.dist      $(where_am_I)$(SRC)

pcre_printint$(DEP): $(SRCS_GENS)  $(HDRS_GENS)

%.h: %.h.generic
	$(CP) $< $@



%.c: %.c.dist
	$(CP) $< $@

# %.c: pcre_chartables.c.dist
#ln -s pcre_chartables.c.dist pcre_chartables.c
# 	ln -s $
# db rule is the default in RULES_E3, so add the empty one

db:
