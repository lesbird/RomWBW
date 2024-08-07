���s�*1�**  "�"�!�e  ���v
ZDENSTAL - ZDE Installer, Version 1.6
Copyright 1990 by Carson Wilson

[Opening  !] ̈́!l � ��\ � <�D!�,\ 	͊�Q*�,˽�R�^��  !� ��!�*�*�6 ��:�� ʕ�v,  !�̈́�!���Q#��Q#�(	�K(�P�Q�� <�$�� <�nÕ:�˿!�*��P(D�K  ͊�Q*�*P�R�^!�*�. ��>͊�Q*�*�R�^!�*#-p ��͊�Q*�*f�R�^!�*�-� ���v]
Installing:  !�,̈́���v

...Press <ESC> to see Main Menu ͨ� ��v

--------------- ZDENSTAL MENU ---------------
<O>ption configuration     <K>ey definitions
<T>erminal installation    <F>urther patching
<P>rinter installation     <R>estore defaults

Choose option, <S>ave, <Q>uit, or <H>elp:  ͨͷ�H	�O�T%PK�F�Q1RhS�H�ó����v

ZDENSTAL HELP -- press ^C at any time to abort ZDENSTAL

ZDENSTAL asks for several types of values:
  LOGICAL values:    Simply enter "Y" or "N" (Yes/No).
  DECIMAL values:    Enter a number from 0-255.
  HEX (byte) values: 2 digits 0-F (don't omit leading zeros).
  BYTE STRINGS:      Fixed length - just enter the required
                       number of HEX bytes, 2 digits each.
                     Variable length - enter the HEX # of bytes
                       at the "(" prompt, up to the "[max]" value
                       shown, then the bytes themselves.
  CHARACTERS:        Type the single character directly.
  TEXT STRINGS:      Enter text, then <CR> to end.

For all items you can either press <CR> immediately to
keep the current value, or enter a new value instead.
(See ZDE manual for further explanation of patches and values.)
 ��v

RESTORE DEFAULTS.
This will restore ZDE to its original distribution
state:  default options, terminal, printer, proportional
spacing; no function keys, no user patches.

Proceed? (Y/N)  ͨͷ�Y�!��,7 ��!!�-� ���}!"�,!  "�,!#.T]6 ���!#-p ��!�S._ ���v  Done. ��v

USER OPTIONS.
Create BAKup files:   !�,�-�v
Default file mode (W/A/N):   �d�v
Auto mode select filetype 1:   ���v  Mode:   �d�v
Auto mode select filetype 2:   ���v  Mode:   �d�v
Auto mode select filetype 3:   ���v  Mode:   �d�v
Auto mode select filetype 4:   ���v  Mode:   �d�v
Default insert on:   �-�v
Default ruler on:   �-�v
Default HCR display on:   �-�v
Enable hyphenation:   �-�v
Enable proportional formatting:   �-�v
Allow proportional toggle:   �-�v
Left margin col:   �\�v
Right margin col:   �\�v
Scroll overlap:   �\�v
Show system files:   �-�v
Fixed drives (A-P):   ���v
Ring bell on error:   �-�v
Enable help menus:   �-�v
Use alt video in header:   �-�v
Suppress header by default:   �-�v
Clock speed in MHz:   ͽ�v
Horizontal & vertical scroll delay:   ͽ�v
Fixed tab display spacing:   ��\��v
Variable tab columns:  
 �J�f�J�v

MODIFY DEFAULT CHARACTERS? (Y/N)  �ͨͷ��Y��v
Wildcard character:   �d�v
Code for block marker:   ͽ�v
Print toggles 1-4 ( ������v):   �*�v
Print switches 1-4 ( ������v):   �*�4�+5#���~͌��#���v

TERMINAL INSTALLATION.
Currently " !#-̈́�v"
CHOOSE: <E>dit current or <L>ist terminals:  ͨͷ�E��L ��v

TERMINALS: press <Y> to select from list:
 !~#G��̈́�_ͨͷ��f����Y(p ��v(End of list) �#-p ���vSelected ��v

EDIT TERMINAL. �v
Terminal ID:   !#-���v
Viewable columns:   �\�v
Auto wrap at line end:   �-�v
Viewable lines:   �\�v
Extra DELete key:   ͽ�v
Extra arrow keys u/d/r/l:   �*#�v
Clear to end of line [06]:   �8�v
Terminal init [07]:   �8�v
Terminal deinit [07]:   �8�v
Alternate video on [06]:   �8�v
Alternate video off [06]:   �8�v
Alt video uses high bit:   �-�v
Output filter limit:   ͽ�v
Cursor position mode (Std/Rev/ANSI/None):   �d�v
[Non-ANSI] Cursor position sequence:   �*�v
Delay after cursor positioning:   ͽ�v
Insert line [06]:   �8�v
Delete line [06]:   �8�v
Ins/del specific to line 1:   �-�v
Cursor off [06]:   �8�v
Cursor on  [06]:   �8��v

PRINTER INSTALLATION.
Printer ID:   !�-���v
Send LF after CR:   �-�v
Page length, lines:   �\�v
Top margin, lines:   �\�v
Left margin, columns:   �\�v
Printer initialization [13]:
   �8�v
Printer deinit [07]:   �8�v

 :-ͧ�v toggle on [07]:   �8�v
  ...and off [07]:   �8�v
 :-ͧ�v toggle on [07]:   �8�v
  ...and off [07]:   �8�v
 :-ͧ�v toggle on [07]:   �8�v
  ...and off [07]:   �8�v
 :-ͧ�v toggle on [07]:   �8�v
  ...and off [07]:   �8�v

 :-ͧ�v switch [07]:   �8�v
 :-ͧ�v switch [07]:   �8�v
 :-ͧ�v switch [07]:   �8�v
 :-ͧ�v switch [07]:   �8���͌����V�v

Select <0-9> or <Z>ap; or <CR> to exit:   ͨͷ���Z�P2��0���
��2��v
New definition: (<BS> edits, <CR> saves; use ^P to enter these)
 ͬԌï�}ï�v


MACRO KEYS.  ( �L!�.��!�.���vh bytes free) !�.
>
����02��v
<?> �͟����v<?> !����ͱ���(0�(�(w#��͌���>�8�+~� �����ͱ����!�>��w��7�                                                                                                                                 ���v  ��� :�W:�_!�.z�(N 	#= �~�(��^ 6 #�DM�!�0��BDM����L��{��I:�.� :�.��s#K �!�0T]��B���BDM���N #�!�����v
Choose <N>o-repeat or <Q>uiet if desired:   ͨͷ�͌���N(�Q +~�#8#��+���L
!� �!�.>�ݾ 8�^ �R8��#�"�.|���6  �#+|� ��!�"�.�!�.!��� OҴ�@O�^ʹ�ô��#($#�~���~+ �~��+~#�G~�#��͌�����v<> ��v<N> ��v<Q> ��v

FURTHER PATCHING.
  You will need DDT or a similar utility.  Addresses
  in this version of the program are:

     User patch area:   *�,�ͳ-ʹ�:�,_ +ͳ�v
  Proportional table:   *�,�ͳ-ʹ�:�,_ +ͳ�v

      Command tables
               Basic:   *�,ͳ�v
                  ^K:   *�,ͳ�v
                 ESC:   *�,ͳ�v
                  ^O:   *�,ͳ�v
                  ^Q:   *�,ͳ�f��v

[Closing  !] ̈́�2h 2| 2�2�!�,\ 	ͬ�n:�� �$�v,  !�̈́:�˿�K(.�P(!"�*!#-�*p ��(!f"�*!�-�*� ��!P"�*!�.�*���!�*�ͬ�n�v]

 �{�*��v *Aborted*
 �,�v
*File )�v
*Read �v
*Version �v
*Write �v error*
 �,����� ��� ��� 
�� ���7������ ��� ��� ��� ��� <(ط���̈́�m�_͓�(.!w#����͓���(
� 8�w#�6 #�!�H �������H 	�                �~Y� Nʹ�m�_ͨͷ�(��Y(�N � �Oʹ��q#��#��~͌�_ͨͷ�(	�͌��w#��#��#�������m�_��8�(2���8�(��w#:�w#��##� �|���}������m�_��8��(w#�͓�7?��؇���2�͓��O:�����A� ~��Oʹ��Oô��0�:�����0��
?�ͷ��?�>�2E�CF"H$�2E�CF"H(ʹ*H��)ʹ*HF#��(������#��m�_!$% 6 ���KF:E�x(!$w�(Y#��͓��� -����8���0�!$wG�(4#��͓��� :E� "������8�����w��͓����h�w#��[H�KFH !$:E� #����*H�KFH 	:E��#�(ʹ���)ʹ��                                      ��\�v...    ����Ϳ�m�_�s8��(w#�͓�7?����2�͓�(0���_:�W������2�͓�(���_:�W��؇؂؂؃�2��:��~�o& ���!�~� (	O�ʹ�#�����0��
?�      �!>��F�N y�(-�B0	�#�#�>1�B8�4��	�#�#�N �Fy�(>0�}�0���B>��	6 #= ��'�d 
  �F#^#V#�# ^#V##�����v : ��v
 ��v?
 �㯆#��O�ʹ��#�O��ʹ����ͨͷͨ���Oʹ��ͱ��1�ñô�a��{��_�COMZDE                                    �AZ80NWS WCMDNLIBN���� �A @@��� @8     Teletype        �6                                                                                                                               �   ���  � �           ��    �  � �  �   ����   �  ��� Generic CRT     P������                                   N                                             ADDS 25         P��
� K    k    k    G4   G0    SY   L    M                                ADDS Viewpoint  P������ K    0A         G4   G0    SY   E    R                                Amstrad / Heath P��
� K    HE   HE   p    q     SY   L    M     x5   y5                ANSI standard   P��
� [K   [H[J [H[J [7m  [m    A     [L   [M    ;A   ;I                Bondwell 2      P��
� T                I    N     S=   E    R                                DEC VT52        P��
� K    HJ   HJ                  SY                                             Commodore 128   P��
� T                )    (     S=   E    R                                Epson Geneva PX8P�� T                               S=   �  �  �                           Kaypro II/IV    P��
�                                 S=   E    R                                Kaypro 2/4/10   P��
�                  B0   C0    S=   E    R     C4   B4                LearSiegler ADM3P��
� T                               S=   E    R                                Morrow MDT-20   P��
� T                               R=   E    R                                Morrow MT-70    P������ T                G1   G0    S=   E    R     "6   "2                NEC Starlet 8401P� T    g*   *     )    (     S=   E    R                                Northstar Advtg.P��
�                             S=   L    M                            Osborne 1       ��
� T                )    (     S=   E    R                                Osb.Exec./TVI912P����� T                l    m     S=   E    R     .0   .2                Osborne Vixen   P�
� T                )    (     S=   E    R                                Otrona Attache  P��
� K                U&   U     S=   L    M                                Qume 102a       P������ T          =7   )    (     S=   E    R     .    .                 Televideo 910+  P��
� T                G4   G0    S=   E    R                                TRS-80 mod 2 P&TP �                     SY                                         TRS-80 model 4P P��
��                             S=                                             Wyse 60         P��
� T    +     +     Gp   G0    S=   E    R     `0   `1                Zenith ZT10     P��
� T                s1   s0    S=   E    R                                               