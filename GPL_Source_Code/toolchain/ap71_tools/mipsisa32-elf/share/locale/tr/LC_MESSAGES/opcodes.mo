??    W      ?     ?      ?  [   ?     ?  9   ?  (   3     \     i  	   y     ?  	   ?     ?     ?     ?  (   ?     	     -	     M	     h	     ?	     ?	     ?	     ?	     ?	  ,   ?	     
  :   6
  1   q
  9   ?
  6   ?
       "   .  )   Q     {  %   ?  #   ?  +   ?  +     1   /  1   a  %   ?  +   ?  1   ?  1     /   I     y     ?     ?     ?  .   ?  +   	     5     O  !   j  5   ?  "   ?  0   ?          &     F  )   c     ?     ?  %   ?  &   ?          &  !   :     \  !   w  !   ?  2   ?  2   ?  2   !  0   T  -   ?  ;   ?  	   ?     ?                     /     G     b      w     ?     ?  X  ?  _        }  D   ?  .   ?     	          0     =     ]     j     {      ?  *   ?     ?  &   ?  )        E  )   \  &   ?     ?     ?     ?  (   ?      
  :   +  2   f  :   ?  7   ?       %   +  '   Q     y  -   ?  "   ?  5   ?  6     5   K  5   ?  5   ?  6   ?  4   $  4   Y  ?   ?     ?     ?       3      K   T  K   ?     ?       '   (  <   P  *   ?  3   ?     ?     ?  #     4   B  &   w     ?  -   ?  7   ?     !     @     S     q  &   ?  &   ?  8   ?  ;     7   O  5   ?  3   ?  :   ?     ,   
   =      H      Z      m         "   ?      ?      ?      ?      !     P   ;   J          >       ?   I           D   H   -      .   2          :   <   !           F   5   "            7   V           8          4            1      T   *   K       %                    Q                 L   U   )   &           ,      +   
           S   3      C                      G       	                 B   /                  A          #   =   @       $          O      E       6   R       M           (              0   N   9   W       '                  
The following ARM specific disassembler options are supported for use with
the -M switch:
 # <dis error: %08x> # internal disassembler error, unrecognised modifier (%c) # internal error, undefined modifier(%c) $<undefined> %02x		*unknown* (unknown) *unknown operands type: %d* *unknown* <function code %d> <illegal precision> <internal disassembler error> <internal error in opcode table: %s %s>
 <unknown register %d> Address 0x%x is out of bounds.
 Bad case %d (%s) in %s:%d
 Bad immediate expression Bad register in postincrement Bad register in preincrement Bad register name Don't understand %x 
 Hmmmm %x Illegal limm reference in last instruction!
 Internal disassembler error Internal error:  bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal error: bad sparc-opcode.h: "%s" == "%s"
 Internal error: bad sparc-opcode.h: "%s", %#.8lx, %#.8lx
 Internal: Non-debugged code (test-case missing): %s:%d Label conflicts with `Rx' Label conflicts with register name Small operand was not an immediate number Unknown error %d
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
 unrecognized form of instruction unrecognized instruction value out of range Project-Id-Version: opcodes 2.12.91
POT-Creation-Date: 2002-07-23 15:55-0400
PO-Revision-Date: 2002-07-24 11:26EET
Last-Translator: Deniz Akkus Kanca <deniz@arayan.com>
Language-Team: Turkish <gnu-tr-u12a@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: KBabel 0.9.5
 
Aşağıdaki ARM'a özgü karşıt-çevirici seçenekleri 
-M seçeneği ile kullanılabilir:
 # <`dis' hatası: %08x> #iç karşıt-çevirici hatası, tanımlanmamış değiştirici (%c) #iç hata, tanımlanmamış değiştirici (%c) $<tanımlanmamış> %02x		*bilinmeyen* (bilinmeyen) bilinmeyen işlenen türü: %d* *bilinmeyen* <işlev kodu %d> <geçersiz kesinlik> <iç karşıt-çevirici hatası> <işlemci kod tablosunda iç hata: %s %s>
 <bilinmeyen yazmaç %d> 0x%x adresi sınırların dışında.
 Hatalı durum %d (%s), %s içerisinde:%d
 Hatalı şimdiki ifade Arttırma sonrasında  geçersiz yazmaç  Arttırma öncesinde geçersiz yazmaç Geçersiz yazmaç adı %x anlaşılamadı
 Hmmmm %x Son işlemde geçersiz limm referansı!
 İç karşıt-çevirici hatası  İç hata: geçersiz sparc-opcode.h: "%s", %#.8lx, %#.8lx
 İç hata: geçersiz sparc-opcode.h: "%s" == "%s"
 İç hata: geçersiz sparc-opcode.h: "%s", %#.8lx, %#.8lx
 İç Hata: Hata ayıklanmamış kod (test eksik): %s:%d Etiket, `Rx' ile çakışıyor Etiket, yazmaç adıyla çakışıyor Küçük işlenen şimdiki sayı değil Bilinmeyen hata %d
 Bilinmeyen karşıt-çevirici seçeneği: %s
 Bilinmeyen yazmaç ad kümesi: %s
 Yönerge oluşturulurken bilinmeyen alan %d bulundu.
 Yönerge çözümlenirken bilinmeyen alan %d bulundu.
 `int' terimi alınırken bilinmeyen alan %d bulundu.
 `vma' terimi alınırken bilinmeyen alan %d bulundu.
 Ayrıştırma esnasında bilinmeyen alan %d bulundu.
 yönerge yazdırılırken bilinmeyen alan %d bulundu.
 `int' terimi atanırken bilinmeyen alan %d bulundu.
 `vma' terimi atanırken bilinmeyen alan %d bulundu.
 + veya - değiştiricisini kullanırken y bitini atama denemesi geçersiz işlem `%.50s' geçersiz işlem `%.50s...' dal işleneni hizalı değil dallanma tek sayılı göreli konuma işaret ediyor dal değeri kapsam dışında ve tek sayılı göreli konuma işaret ediyor dal değeri kapsam dışında ve tek sayılı göreli konuma işaret ediyor dal değeri kapsam dışında  insert %d yaptırılamıyor
 yer değiştirme değeri hizalanmamış yer değiştirme değeri kapsam dışında ve hizalanmamış yer değiştirme değeri kapsam dışında Dal göreli konumunda en önemsiz bitler atlanıyor geçersiz bitmask  şimdiki değer kapsam dışı şimdiki değer çift sayı olmalı şimdiki değer kapsam dışı ve çift sayı değil yükleme aralığında endeks yazmacı koşullu seçenek geçersiz  yığıt düzeltmesi için geçersiz yazmaç  güncelleme esnasında geçersiz yazmaç terimi bulundu atlama işareti hizalı değil Satır sonu bozuk  biçem dizgesinde ipucu eksik görece 4'ün katı değil görece -2048 ve 2047 arasında değil görece -8192 ve 8191 arasında değil Kapsam dışı terim (%ld, %ld ve %ld arasında değil)  Kapsam dışı işlenen (%ld, %ld ve %lu arasında değil)  Kapsam dışı terim (%lu, %lu ve %lu arasında değil) kapsam dışı terim (%lu 0 ve %lu arasında değil)  biçem hatası (char `%c' beklenirken `%c' bulundu) biçem hatası (char `%c' beklenirken işlem sonu bulundu) tanımlanmamış bilinmeyen bilinmeyen	0x%02x bilinmeyen	0x%04lx bilinmeyen	0x%04x `%c' bilinmeyen kısıtı bilinmeyen terim kaydırması: %x
 bilinmeyen çek yazmacı: %d
 bilinmeyen işlem türü bilinmeyen işlem değer aralık dışı 