# HiPERCalc-linux

This project allows installing the Windows (Java) version of [HiPER Calc](https://hiperdevelopment.wixsite.com/hipercalc) on Linux.

No code or assets from HiPER Calc are included - it is downloaded from the official website and unpacked. This project is released to public domain but the resulting HiPER Calc installation is Copyright [HiPER Labs](https://hiperdevelopment.wixsite.com/home).

I have no affiliation with HiPER Labs or HiPER Calc other than being a happy user.

## Usage

NOTE: Running HiPERCalc requires the Java Runtime Environment, building the package requires OpenJDK, 7zip, icoutils, and ImageMagick.

To build the package:

    $ make

To run it from the source directory:

    $ ./hipercalc

To install it system-wide:

    $ sudo make install

To uninstall it:

    $ sudo make uninstall
