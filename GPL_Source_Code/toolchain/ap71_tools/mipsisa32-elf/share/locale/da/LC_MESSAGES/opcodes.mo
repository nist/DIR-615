??    P      ?  k         ?  [   ?     %  9   9  (   s     ?     ?  	   ?     ?  	   ?     ?     ?       (   .     W     m     ?     ?     ?  ,   ?     ?  :   	  1   K	  9   }	  6   ?	     ?	  %    
  #   &
  +   J
  +   v
  1   ?
  1   ?
  %     +   ,  1   X  1   ?  /   ?     ?               8  .   M  +   |     ?     ?  !   ?  5   ?  "   5  0   X     ?     ?     ?  )   ?             %   8  &   ^     ?     ?  !   ?     ?  !   ?  !     2   .  2   a  2   ?  0   ?  -   ?  ;   &  	   b     l     t     ?     ?     ?     ?     ?      ?          $  0  7  \   h     ?  3   ?  %        :     H     W     `     z     ?     ?     ?  ,   ?     ?  0     !   <     ^     p  -   y     ?  :   ?  1   ?  9   1  <   k     ?  "   ?  #   ?  0   ?  -   0  /   ^  ,   ?     ?  ,   ?  2     /   9  B   i     ?      ?  1   ?       K   :  L   ?  0   ?       /     O   J  +   ?  8   ?     ?  (        9  :   Y  +   ?     ?  #   ?  &   ?  !   "     D      a     ?     ?     ?  A   ?  A     A   a  9   ?  1   ?  @     
   P     [     b     p          ?     ?     ?     ?     ?     	         L   &   2   H   "   B   -                          D      G   P                    7   :          I   	         ,                              +   3   K   F   
       5   @          M      <       /   6                    J   A          ?       0       =   8   N          O          E   ;       %       >   1       $       9          *   )      !       .   '       (   C   4              #    
The following ARM specific disassembler options are supported for use with
the -M switch:
 # <dis error: %08x> # internal disassembler error, unrecognised modifier (%c) # internal error, undefined modifier(%c) $<undefined> %02x		*unknown* (unknown) *unknown operands type: %d* *unknown* <function code %d> <illegal precision> <internal disassembler error> <internal error in opcode table: %s %s>
 <unknown register %d> Address 0x%x is out of bounds.
 Bad case %d (%s) in %s:%d
 Don't understand %x 
 Hmmmm %x Illegal limm reference in last instruction!
 Internal disassembler error Internal error:  bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal error: bad sparc-opcode.h: "%s" == "%s"
 Internal error: bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal: Non-debugged code (test-case missing): %s:%d Unknown error %d
 Unrecognised disassembler option: %s
 Unrecognised register name set: %s
 Unrecognized field %d while building insn.
 Unrecognized field %d while decoding insn.
 Unrecognized field %d while getting int operand.
 Unrecognized field %d while getting vma operand.
 Unrecognized field %d while parsing.
 Unrecognized field %d while printing insn.
 Unrecognized field %d while setting int operand.
 Unrecognized field %d while setting vma operand.
 attempt to set y bit when using + or - modifier bad instruction `%.50s' bad instruction `%.50s...' branch operand unaligned branch to odd offset branch value not in range and to an odd offset branch value not in range and to odd offset branch value out of range can't cope with insert %d
 displacement value is not aligned displacement value is not in range and is not aligned displacement value is out of range ignoring least significant bits in branch offset illegal bitmask immediate value is out of range immediate value must be even immediate value not in range and not even index register in load range invalid conditional option invalid register for stack adjustment invalid register operand when updating jump hint unaligned junk at end of line missing mnemonic in syntax string offset not a multiple of 4 offset not between -2048 and 2047 offset not between -8192 and 8191 operand out of range (%ld not between %ld and %ld) operand out of range (%ld not between %ld and %lu) operand out of range (%lu not between %lu and %lu) operand out of range (%lu not between 0 and %lu) syntax error (expected char `%c', found `%c') syntax error (expected char `%c', found end of instruction) undefined unknown unknown	0x%02x unknown	0x%04lx unknown	0x%04x unknown constraint `%c' unknown operand shift: %x
 unknown pop reg: %d
 unrecognized form of instruction unrecognized instruction value out of range Project-Id-Version: opcodes 2.12-pre020121
POT-Creation-Date: 2002-01-17 13:58+0000
PO-Revision-Date: 2002-02-12 19:35+0200
Last-Translator: Keld Simonsen <keld@dkuug.dk>
Language-Team: Danish <dansk@klid.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
 
F?lgende ARM-specifikke disassembleralternativ underst?ttes for brug
sammen med flaget -M:
 # <disassemblerfejl: %08x> # intern disassembler-fejl, ukendt modifikator (%c) # intern fejl, ukendt modifikator(%c) $<udefineret> %02x		*ukendt* (ukendt) *ukendt operandstype: %d* *ukendt* <funktionskode %d> <ugyldig pr?cision> <intern fejl i disassembleren> <intern fejl i instruktionstabellen: %s %s>
 <ukendt register %d> Adressen 0x%x ligger uden for tilladte gr?nser.
 Fejlagtig 'case' %d (%s) i %s:%d
 Forst?r ikke %x 
 Hmmmm %x Ugyldig limm-reference i sidste instruktion!
 Intern fejl i disassembleren Intern fejl:  d?rlig sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Intern fejl: d?rlig sparc-opcode.h: "%s" == "%s"
 Intern fejl: d?rlig sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internt: ikke-fejltestet kode (test-tilf?lde mangler): %s:%d Ukendt fejl %d
 Ukendt disassembleralternativ: %s
 Ukendt registernavn er angivet: %s
 Ukendt felt %d ved konstruktion af instruktion.
 Ukendt felt %d ved afkodning af instruktion.
 Ukendt felt %d ved hentning af heltalsoperand.
 Ukendt felt %d ved hentning af vma-operand.
 Ukendt felt %d ved tolkning.
 Ukendt felt %d ved udskrift af instruktion.
 Ukendt felt %d ved indstilling af heltalsoperand.
 Ukendt felt %d ved indstilling af vma-operand.
 fors?g p? at s?tte y-bitten n?r modifikatoren + eller - blev brugt fejlagtig instruktion "%.50s" fejlagtig instruktion "%.50s..." operanden for betinget hop ligger p? sk?v adresse betinget hop til ulige afs?t v?rdien for betinget hop er ikke indenfor intervallet og til et ulige afs?t v?rdien for betinget hop er ikke inden for intervallet og til et ulige afs?t v?rdien for betinget hop er uden for intervallet kan ikke inds?tte %d
 forskydningsv?rdien ligger ikke p? lige adresse forskydningsv?rdien er ikke indenfor intervallet og ligger ikke p? lige adresse forskydningsv?rdien er uden for intervallet ignorerer mindste betydende bit i afs?t for betinget hop ugyldig bitmaske umiddelbar v?rdi er uden for intervallet umiddelbar v?rdi skal v?re lige umiddelbar v?rdi er ikke indenfor intervallet og ikke lige indeksregistret er i indl?sningsintervallet ugyldigt betinget flag ugyldigt register for stakjustering ugyldig registeroperand ved opdatering hopper?det ligger p? sk?v adresse snavs ved slutning p? linjen Mangler mnemonic i syntaksstreng afs?t ikke et produkt af 4 afs?t ikke mellem -2048 og 2047 afs?t ikke mellem -8192 og 8191 operanden er uden for intervallet (%ld er ikke mellem %ld og %ld) operanden er uden for intervallet (%ld er ikke mellem %ld og %lu) operanden er uden for intervallet (%lu er ikke mellem %lu og %lu) operanden uden for intervallet (%lu ikke mellem 0 og %lu) syntaksfejl (tegnet "%c" forventedes, fandt "%c") syntaksfejl (tegnet "%c" forventedes, fandt slut p? instruktion) udefineret ukendt ukendt	0x%02x ukendt	0x%04lx ukendt	0x%04x ukendt begr?nsning "%c" ukendt operandskiftning: %x
 ukendt pop-register: %d
 ukendt form af instruktion ukendt instruktion v?rdien er uden for intervallet 