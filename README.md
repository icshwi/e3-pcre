# e3-pcre

This implemenation is base on the NON-AUTOTOOLS-BUILD. And the epics-module/stream/pcre/ USR_CPPFLAGS are used to setup config.h as well.

* This is the basic PCRE C 8-bit library. 
* We are using the E3 building system to compile it, and put the ESS designed directory structure.
* One needs the E3 in order to compile.
* It uses the following repository as submodule

```
https://github.com/jeonghanlee/pcre
```

The default version is the pcre 8.41 version. 