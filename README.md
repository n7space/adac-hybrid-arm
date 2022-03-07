ADAC-HYBRID-ARM
===============

A wrapper for AdaCore's arm-eabi-gcc, so that it can be hooked up to standard arm-none-eabi toolchain.

Prerequisites
---------------
* Install the newest version of qemu-system-arm 
(this software was developed with QEMU 6.2.50)
* Install arm-eabi-gcc Ada ARM cross-compiler
(this software was developed with GNAT Community 2021 20210519)
* Install make, gprbuild and arm-none-eabi-gcc C/C++ ARM crosscompiler

Installation
---------------
Execute make to build and test all necessary binaries.
You can add build/bin to system PATH for adac to be accessible from any place.

Usage
---------------

### arm-elf-adac

**arm-elf-adac** is constructed to mimic a regular c compiler in usage. However, it combines two different compilers, and as such accepts command-line arguments for all of them:
* All arguments prefixed with `-Wgnat,` are forwarded to arm-eabi-gcc, after stripping the prefix. Please consult arm-eabi-gcc manual for the list of accepted options.
* All arguments prefixed with `-gnat` are forwarded to arm-eabi-gcc as is. Please consult arm-eabi-gcc manual for the list of accepted options.
* All arguments prefixed with `-Wdac,` are interpreted by adac. Please consult the list below.
* All other arguments are forwareded to arm-none-eabi-gcc. Please consult arm-none-eabi-gcc manual for the list of accepted options.

Adac accepts the following options:
* `keep_ada_main` - don't rename `_ada_main` to `main`.
* `keep_intermediates` - don't delete the generated intermediate files: arm assembly and Ada `.ali` files.


### arm-elf-adabind

**arm-elf-adabind** is called implicitly by gprbuild when building a `.gpr` based project.
In order to configure the project to use both `arm-elf-adac` and `arm-elf-adabind`,
several options must be added to the project file:

Use `arm-elf-adabind` for binding:

```
package Binder is
    for Driver ("Ada")  use "arm-elf-adabind";
end Binder;
```

Use `arm-elf-adac` for compilation:

```
package Compiler is
    for Driver ("Ada") use "arm-elf-adac";

    (... the rest of regular compiler configuration ...)

end Compiler;
```