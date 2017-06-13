# arm7wrestler
ARM7 counterpart of the DS CPU tester ARMWrestler

Differences with the ARM9 version:

 * LDM opcodes with writeback: if the base register is included in the register list, writeback never happens
 * (maybe the STM opcodes also have differences that aren't being tested. TODO)
 * CLZ, QADD, QSUB, QDADD and QDSUB throw an 'undefined instruction' exception
 * MRC CP15 throws an exception, MRC CP14 works
 * LDRD and ARMv5 SMUL/SMLA don't throw exceptions, but seem to be no-ops