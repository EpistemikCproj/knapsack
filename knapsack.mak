#
# Borland C++ IDE generated makefile
# Generated 04/19/03 at 6:41:47 PM 
#
.AUTODEPEND


#
# Borland C++ tools
#
IMPLIB  = Implib
BCC32   = Bcc32 +BccW32.cfg 
BCC32I  = Bcc32i +BccW32.cfg 
TLINK32 = TLink32
ILINK32 = Ilink32
TLIB    = TLib
BRC32   = Brc32
TASM32  = Tasm32
#
# IDE macros
#


#
# Options
#
IDE_LinkFLAGS32 =  -LD:\Program Files\BC5\LIB
LinkerLocalOptsAtC32_knapsackdexe =  -Tpe -ap -c -LD:\PROGRAM FILES\BC5\LIB
ResLocalOptsAtC32_knapsackdexe =  -l0
BLocalOptsAtC32_knapsackdexe = 
CompInheritOptsAt_knapsackdexe = -ID:\Program Files\BC5\INCLUDE -D_RTLDLL;_BIDSDLL;KNAPSACK_NODE_DEBUG=1;KNAPSACK_MAIN_DEBUG=1;KNAPSACK_BFS_DEBUG=1;KNAPSACK_BOUND_DEBUG=1
LinkerInheritOptsAt_knapsackdexe = -x
LinkerOptsAt_knapsackdexe = $(LinkerLocalOptsAtC32_knapsackdexe)
ResOptsAt_knapsackdexe = $(ResLocalOptsAtC32_knapsackdexe)
BOptsAt_knapsackdexe = $(BLocalOptsAtC32_knapsackdexe)

#
# Dependency List
#
Dep_knapsack = \
   knapsack.exe

knapsack : BccW32.cfg $(Dep_knapsack)
  echo MakeNode

Dep_knapsackdexe = \
   D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\node.obj\
   D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\knapsack.obj

knapsack.exe : $(Dep_knapsackdexe)
  $(ILINK32) @&&|
 /v $(IDE_LinkFLAGS32) $(LinkerOptsAt_knapsackdexe) $(LinkerInheritOptsAt_knapsackdexe) +
D:\PROGRAM FILES\BC5\LIB\c0x32.obj+
D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\node.obj+
D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\knapsack.obj
$<,$*
D:\PROGRAM FILES\BC5\LIB\bidsfi.lib+
D:\PROGRAM FILES\BC5\LIB\import32.lib+
D:\PROGRAM FILES\BC5\LIB\cw32i.lib



|
D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\node.obj :  node.c
  $(BCC32) -P- -c @&&|
 $(CompOptsAt_knapsackdexe) $(CompInheritOptsAt_knapsackdexe) -o$@ node.c
|

D:\MY_DOCS\PROG\CPROJ\KNAPSACK\OBJ\knapsack.obj :  knapsack.c
  $(BCC32) -P- -c @&&|
 $(CompOptsAt_knapsackdexe) $(CompInheritOptsAt_knapsackdexe) -o$@ knapsack.c
|

# Compiler configuration file
BccW32.cfg : 
   Copy &&|
-w
-R
-v
-WM-
-vi
-H
-H=knapsack.csm
-wnak
-VF
-5
-a
-WC
-A-
-i55
-VF-
| $@


