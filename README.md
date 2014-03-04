rgref-fstar
===========
F* Implementation of a simplified rely-guarantee references

Setting up F*
--------------
Install F*.  Grab the binary zip file from the MSR page.  Make sure you have .NET 4.0 or higher, F# Powerpack 2.0, the F# redistributable runtime for F# 2.0 (newer won't work; the assembly references the specific version of a DLL), Z3, and Cygwin.  More details, and links, here: https://gist.github.com/csgordon/5846399.  Get Z3 and F* on your Windows path.

After the above, go to the root of where you unpacked the F* .zip file, and run 

    fstar --fstar_home `pwd`

to set an important environment variable.
