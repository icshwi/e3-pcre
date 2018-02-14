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
# Date    : Wednesday, February 14 02:37:45 CET 2018
# version : 0.0.1
# 

where_am_I := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

include $(E3_REQUIRE_TOOLS)/driver.makefile


#for pcre version 8 and higher: have to create pcre.h and define some variables
USR_CPPFLAGS += -DHAVE_MEMMOVE=1 -DNEWLINE=10 -DINT64_MAX="(0x7FFFFFFFFFFFLL)"
USR_CPPFLAGS += -DLINK_SIZE=2 -DMAX_NAME_COUNT=10000 -DMAX_NAME_SIZE=32
USR_CPPFLAGS += -DMATCH_LIMIT=10000000 -DMATCH_LIMIT_RECURSION=MATCH_LIMIT
USR_CPPFLAGS += -DPOSIX_MALLOC_THRESHOLD=10 -DPARENS_NEST_LIMIT=250
USR_CPPFLAGS += -DSUPPORT_PCRE8



USR_INCLUDES += -I$(where_am_I)

SRC:=

SOURCES += $(SRC)/pcre_config.c
SOURCES += $(SRC)/pcre_fullinfo.c
SOURCES += $(SRC)/pcre_tables.c
SOURCES += $(SRC)/pcre_exec.c
SOURCES += $(SRC)/pcre_valid_utf8.c
SOURCES += $(SRC)/pcre_study.c
SOURCES += $(SRC)/pcre_xclass.c
SOURCES += $(SRC)/pcre_jit_test.c
SOURCES += $(SRC)/pcre_jit_compile.c
SOURCES += $(SRC)/pcre_compile.c
SOURCES += $(SRC)/pcre_byte_order.c
SOURCES += $(SRC)/pcre_ord2utf8.c
SOURCES += $(SRC)/pcre_chartables.c.dist
SOURCES += $(SRC)/pcre_string_utils.c
SOURCES += $(SRC)/pcre_maketables.c
SOURCES += $(SRC)/pcre_globals.c
SOURCES += $(SRC)/pcre_version.c
SOURCES += $(SRC)/pcre_get.c
SOURCES += $(SRC)/pcre_ucd.c
SOURCES += $(SRC)/pcre_newline.c
SOURCES += $(SRC)/pcre_dfa_exec.c
SOURCES += $(SRC)/pcre_refcount.c
SOURCES += $(SRC)/pcre_printint.c

#SOURCES += $(notdir $(wildcard $(SRC)/pcre_*.c))


HDRS_GENS += pcre.h
HDRS_GENS += config.h

HEADERS += pcre.h

vpath %.generic   $(where_am_I)$(SRC)

pcre_printint$(DEP): $(HDRS_GENS)



%.h: %.h.generic
	$(CP) $< $@

# %.c: pcre_chartables.c.dist
#ln -s pcre_chartables.c.dist pcre_chartables.c
# 	ln -s $
# db rule is the default in RULES_E3, so add the empty one

db:
