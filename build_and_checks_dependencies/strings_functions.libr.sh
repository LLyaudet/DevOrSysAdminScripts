#!/usr/bin/env bash
# This file is part of DevOrSysAdminScripts library.
#
# DevOrSysAdminScripts is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License
# as published by the Free Software Foundation,
# either version 3 of the License,
# or (at your option) any later version.
#
# DevOrSysAdminScripts is distributed in the hope
# that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of
# the GNU General Public License
# along with DevOrSysAdminScripts.
# If not, see <https://www.gnu.org/licenses/>.
#
# ©Copyright 2023-2026 Laurent Frédéric Bernard François Lyaudet
# I think I created a file strings_functions.sh or renamed to
# strings_functions.sh at some point, before committing.
# Hence, someone must have changed or reversed the name of this file
# to string_functions.sh at some point.
# This file was renamed from "string_functions.sh" to
# "strings_functions.libr.sh".

LFBFL_subdir="build_and_checks_dependencies"
# shellcheck source=get_common_text_glob_patterns.libr.sh
source "./${LFBFL_subdir}/get_common_text_glob_patterns.libr.sh"
# shellcheck source=comparisons.libr.sh
source "./${LFBFL_subdir}/comparisons.libr.sh"
# shellcheck source=too_long_code_lines.libr.sh
source "./${LFBFL_subdir}/too_long_code_lines.libr.sh"

split_line_at(){
  # $1=line
  # $2=position : number of characters in split_line_at_result_beginning
  declare -g split_line_at_result_beginning="${1:0:$2}"
  declare -g split_line_at_result_end="${1:$2}"
  # printf "%s\n" "$split_line_at_result_beginning"
  # printf "%s\n" "$split_line_at_result_end"
}

#--------------------------------------------------------------------------
#--------------------------------------------------------------------------
# Properties for the score for a possible split/cut in the string between
# two characters.
#--------------------------------------------------------------------------
# Some preliminary remarks:
# a) If the character before the split position is a forbidden previous
#   character, the score is -1.
#   (Usually, either we have no or one forbidden previous character that is
#   a backslash.)
# b) If the previous character is not forbidden,
#   and either the character before the position is among the delimiters,
#   or the character after the position is among the delimiters,
#   then the score is computed according to the delimiter found,
#   the position, and the fact that the position is after or before the
#   delimiter.
# c) If two consecutive delimiters are found in the string,
#   the maximum score between the one after the first delimiter
#   and before the second delimiter is taken for the score between the
#   two delimiters.
# d) Otherwise, by default,
#   the score for cutting/splitting at some position is 0.
# e) A substring is given by the goal length given for the resulting
#   strings/lines after split.
# f) When some scores are equal,
#   we split at the rightmost position with maximum score in the substring.
# g) Remark f) implies that below we do not need to consider strict
#    inequalities for the score.
# h) The score function SF(position) which will dictate our choice for
#   split/cut position is in reality
#   SF1a(
#     position, previous_character, next_character, delimiters, forbiddens
#   )
#   but at the cost of expliciting its internal and adding verbosity,
#   we can see that the score really depends on the following arguments
#   SF1b(
#     position, matched_delimiter_before, matched_delimiter_after,
#     previous_character_is_forbidden
#   )
#   If it is needed,
#   then matched_delimiter_before or matched_delimiter_after is NULL.
#   Somehow previous_character can be seen as position.previous_character,
#   and next_character can be seen as position.next_character.
#   We can see that the previous or next character without
#   knowing that it matches a delimiter is irrelevant.
#   The fact that there is 1 or more delimiters may be interesting.
#   The fact that there is 0 or more forbidden previous characters
#   may be interesting, but we haven't integrated it in the split_score
#   functions.
#   SF1a when the previous character is not forbidden
#   needs a score function SF2a with the following parameters
#   SF2a(position, current_character, delimiter, is_after):
#   SF1a(
#     position, previous_character, next_character, delimiters, forbiddens
#   ) = max(
#     For all delimiter in delimiters,
#     SF2a(position, previous_character, delimiter, TRUE),
#     SF2a(position, next_character, delimiter, FALSE),
#   )
#   =  max(
#     For all delimiter in delimiters,
#     For all couple C in {
#       (position.previous_character, TRUE),
#       (position.next_character, FALSE)
#     }
#     SF2a(position, C.1, delimiter, C.2),
#   )
#   Similarly,
#   SF1b(
#     position, matched_delimiter_before, matched_delimiter_after,
#     previous_character_is_forbidden
#   ) = max(
#     For all delimiter in delimiters,
#     SF2b(position, matched_delimiter_before, TRUE),
#     SF2b(position, matched_delimiter_after, FALSE),
#   )
#   where the score function SF2b has the following parameters
#   SF2b(cut_position, matched_delimiter, is_after).
#   We have also:
#   SF1b(
#     position, matched_delimiter_before, matched_delimiter_after,
#     previous_character_is_forbidden
#   ) = max(
#     For all delimiter in delimiters,
#     SF2c(position-1, matched_delimiter_before, TRUE),
#     SF2c(position, matched_delimiter_after, FALSE),
#   )
#   where the score function SF2c has the following parameters
#   SF2c(character_position, matched_delimiter, is_after).
#   current_character is only used to check if it is equal to the
#   delimiter, otherwise the score is zero;
#   but when expressing properties it makes sense to compare after
#   and before the same character position.
#   position, delimiter, and is_after may all three impact the score
#   once the current character matches the delimiter.
#   Position is an integer from 1 to goal length.
#   Cutting at position 0 would be stupid,
#   and moreover there would be no previous character.
#   Since we ask for a split, the current length is above goal length,
#   and there is a next character at the last considered position.
#   So, in search of properties that may have an impact on the algorithm,
#   we discard the characters to only keep matched delimiters.
#   Let us use p1 and p2 for position1 and position2,
#   mdb1 and mdb2 for matched_delimiter_before1, etc.,
#   mda1 and mda2 for matched_delimiter_after1, etc.,
#   pcif for previous_character_is_forbidden, etc.,
#   md1 and md2 for matched_delimiter1, etc.,
#   ia1 and ia2 for is_after1, etc.
#
#   What we consider as properties are of 3 forms.
#   The first form is like:
#     For all p1 in [1, goal_length], for all p2 in [1, goal_length],
#     for all mdb1 in delimiters union {NULL},
#     for all mdb2 in delimiters union {NULL},
#     for all mda1 in delimiters union {NULL},
#     for all mda2 in delimiters union {NULL},
#     RelationP(p1, p2) AND RelationM(mdb1, mdb2, mda1, mda2)
#     implies RelationS(
#       SF1b(p1, mdb1, mda1, false),
#       SF1b(p2, mdb2, mda2, false),
#     )
#   There are many choices for RelationP, RelationM and RelationS.
#   We can apply the without loss of generality argument only once when
#   breaking symmetry between equivalent properties.
#   Breaking symmetry on another relation that RelationS first
#   is a challenge that we do not tackle.
#   Indeed RelationS is the only relation where all variables appear.
#   And breaking symmetry on RelationP would not allow to break symmetry
#   on RelationM freely since some variables are correlated by the
#   suffixes 1 or 2.
#   But some choices for some relation may allow to break symmetry on
#   another relation.
#   Breaking symmetry on the result, there are only 2 choices for
#   RelationS:
#   RS= : SF1b(p1, mdb1, mda1, false) = SF1b(p2, mdb2, mda2, false),
#   RS<= : SF1b(p1, mdb1, mda1, false) <= SF1b(p2, mdb2, mda2, false).
#   But then there are 5+1 choices for RelationP:
#   RP1 : p1 = p2,
#   RP2 : p1 < p2,
#   RP3 : p1 <= p2,
#   RP4 : p1 > p2,
#   RP5 : p1 >= p2,
#   plus the choice that p1 and p2 are not necessarily related
#   (empty RP or RPe).
#   We can add RP6 : p1 = p2 + 1 and RP7 : p2 = p1 + 1, since it implies
#   some equalities between matched delimiters.
#   Note that  p1 = p2 + i or p2 = p1 + i with i >= 2 brings no additional
#   logical relations compared to p1 < p2 or p2 < p1;
#   it only yields subslices of other properties and open a slightly silly
#   door on infinity.
#   If we have RS=, by symmetry we can consider only RP1, RP2, RP3 and RPe,
#   and maybe RP6.
#   Note that RSe or empty RS would have no interest at all.
#   There are many choices for RelationM:
#   mdb1 is NULL AND mdb2 is NULL AND mda1 is NULL AND mda2 is NULL is not
#   interesting at all since both scores are 0 or -1.
#   mdb1 is NULL AND mdb2 is NULL AND mda1 is NULL AND mda2 is not NULL
#   implies that second score is always larger, that's not an additional
#   property, that is a theorem.
#   Hence, at least one of mdb1 or mda1, resp. mdb2 or mda2,
#   must (have the possibility to) be non-NULL.
#   If we start listing the remaining relations, we have:
#   1) mdb1 is NULL AND mdb2 is NULL AND mda1 is not NULL
#     AND mda2 is not NULL
#   RMA1A2
#   2) mdb1 is NULL AND mdb2 is NULL AND mda1 is not NULL
#     AND mda2 is not NULL
#     AND mda1 = mda2
#   RMA1A2=
#   3) mdb1 is NULL AND mdb2 is NULL AND mda1 is not NULL
#     AND mda2 is not NULL
#     AND mda1 != mda2 -> This case has no meaning:
#     If we only know they are different, we cannot say anything on
#     properties related to delimiters that are different unless the score
#     doesn't depend on the delimiter, and that case is already handled by
#     1). The same remark applies to some other choices.
#     The only thing that could be said would be if we had an order on
#     delimiters scores that are uniform for the position, or the score
#     before some delimiter would always be =, >=, <=, etc. the score
#     before or after another one. So it would only make sense with RPe,
#     and mda1 <= mda2 for example, but that would trivially imply RS<=.
#     It would end up with max(mda1, mdb1) <= max(mda2, mdb2) where max
#     ignores NULL value. You do not deduce or specify anything new here.
#   4) mdb1 is not NULL AND mdb2 is not NULL AND mda1 is NULL
#     AND mda2 is NULL
#   RMB1B2
#   and so on. So if we use the short notation RM followed by A1, resp. A2,
#   resp. B1, resp. B2, when mda1, resp. mda2, resp. mdb1, resp. mdb2,
#   is not null, we have the following possibilities:
#   RMA1A2, RMB1B2, RMA1B2, RMA2B1, all 4 with variant with = like RMA1A2=,
#   RMA1A2B1, RMA1A2B2, RMA1B1B2, RMA2B1B2, all 4 (RMXXYYZZ) with variants
#   with suffixes _1 (XX = YY), _2 (XX = ZZ), _3 (YY = ZZ),
#   and _4 (XX = YY = ZZ)
#   for equalities on the 1st, 2nd or 3rd couple or between the three
#   variables by transitivity,
#   RMALL where none is null, with suffixes A1A2 (A1 = A2), etc.
#   RMALL_A1A2, RMALL_A1B1, RMALL_A1B2, RMALL_A2B1, RMALL_A2B2, RMALL_B1B2,
#   for one edge;
#   RMALL_A1A2B1, RMALL_A1A2B2, RMALL_A1B1B2, RMALL_A2B1B2, one triangle;
#   RMALL_A1A2_B1B2, RMALL_A1B1_A2B2, RMALL_A1B2_A2B1, 2 disjoint edges;
#   RMALL_ALL square with diagonals.
#   So we see that we listed at least 39 possibilities only for RM.
#   We did not list yet the possibilities where the variables not present
#   in some equality can be NULL or not NULL, etc.
#   We see 9 of them : RMe (40), and the following 8:
#   RMA1A2+ = RMA1A2= OR RMA1A2B1_1 OR RMA1A2B2_1 OR RMALL_A1A2
#   RMB1B2+ = RMB1B2= OR RMA1B1B2_3 OR RMA2B1B2_3 OR RMALL_B1B2
#   RMA1B2+ = RMA1B2= OR RMA1A2B2_2 OR RMA1B1B2_2 OR RMALL_A1B2
#   RMA2B1+ = RMA2B1= OR RMA1A2B1_3 OR RMA2B1B2_1 OR RMALL_A2B1
#   RMA1A2B1+ = RMA1A2B1_4 OR RMALL_A1A2B1
#   RMA1A2B2+ = RMA1A2B2_4 OR RMALL_A1A2B2
#   RMA1B1B2+ = RMA1B1B2_4 OR RMALL_A1B1B2
#   RMA2B1B2+ = RMA2B1B2_4 OR RMALL_A2B1B2
#   We don't do complete analysis at the moment.
#   If we wanted to filter out some possibilities,
#   we would keep only the RM possibilities, among the 38,
#   that are symmetric between 1 and 2:
#   RMA1A2, RMB1B2, RMA1A2=, RMB1B2=,
#   RMALL, RMALL_A1A2, RMALL_A2B2, RMALL_A1A2_B1B2, RMALL_A1B1_A2B2,
#   RMALL_ALL. Still 10 possibilities.
#   We have 1 (RS=) times 5 times 10 + 1 (RS<=) times 8 times 10 = 130
#   combinations (life is too short ;) :) );
#   if we keep 48 RM possibilities, there is 624 combinations,
#   but we did not analyze totally which RM relations are useless.
#
#   The second form is like:
#     For all p1 in [1, goal_length], for all p2 in [1, goal_length],
#     for all md1 in delimiters union {NULL},
#     for all md2 in delimiters union {NULL},
#     for all ia1 in {TRUE,FALSE}, for all ia2 in {TRUE,FALSE},
#     RelationP(p1, p2) AND RelationMM(md1, md2) AND RelationIA(ia1, ia2)
#     implies RelationS(
#       SF2b(p1, md1, ia1)
#       SF2b(p2, md2, ia2)
#     )
#   The third form is like:
#     For all p1 in [1, goal_length], for all p2 in [1, goal_length],
#     for all md1 in delimiters union {NULL},
#     for all md2 in delimiters union {NULL},
#     for all ia1 in {TRUE,FALSE}, for all ia2 in {TRUE,FALSE},
#     RelationPP(p1, p2) AND RelationMM(md1, md2) AND RelationIA(ia1, ia2)
#     implies RelationS(
#       SF2c(p1, md1, ia1)
#       SF2c(p2, md2, ia2)
#     )
#   This time the combinatorics is much more pleasant :).
#   As above, we have RS= and RS<=, RPe, RP1 to RP7;
#   For RelationMM, assume that the possible delimiters correspond to
#   integer numbers 1 to i; hence md1, resp. md2, can be seen as an integer
#   in [0,i], either 0 for NULL or the delimiter index.
#   Clearly, if md1 = k in [1,i] and md2 = l in [1,i], then the only
#   information we can use is k = l or k != l.
#   If we allow that md1 != 0 and md2 = 0,
#   then both RS= and RS<= are false.
#   Thus RMMe is not possible.
#   If we allow that md1 = 0 and md2 != 0, then RS<= is always true,
#   whilst RS= is false.
#   Thus properties with RS<= can trivially be extended with
#   RMM-"allow-md1-0", not useful to explicit this for the moment.
#   If both md1 = 0 and md2 = 0, then both scores are 0 and we also learn
#   nothing more.
#   Thus we can focus on md1 and md2 are not NULL,
#   and are equal RMM= or not RMM!=. It seems that a property with RMM!=
#   could be extended to a property RMM=or!=/RMMNotNULL.
#   and finally RIA0 to RIA8 where TRUE = 1, FALSE = 0 and the digit is
#   3 * ia1 + ia2, and both variables can be 2 if they can be either TRUE
#   or FALSE. Wrong ! Not pleasant ! XD
#   So for RIA, we keep either: empty RIAe (RIA8),
#   ia1 = ia2 RIA= (RIA0 or RIA4),
#   ia1 = ia2 = TRUE RIA=T (RIA4), ia1 = ia2 = FALSE RIA=F (RIA0),
#   ia1 != ia2 RIA!= (RIA1 or RIA3), ia1 != ia2 = FALSE RIA!=T1 (RIA3),
#   ia1 != ia2 = TRUE RIA!=T2 (RIA1),
#   ia1 = TRUE (RIA5), ia1=FALSE (RIA2),
#   ia2 = TRUE (RIA7), ia2=FALSE (RIA6),
#   even less pleasant XD : 11 possibilities.
#   In total, we have now 1 (RS=) times 5 times 2 times 11
#   + 1 (RS<=) times 8 times 2 times 11 = 286
#   combinations (life is even shorter ;) :) ).
#   We only listed below properties of the third form.
# i) By the previous remark, there is a good chance that we missed some
#   possible property.
#   We hope we did found the properties that had a simple meaning,
#   in particular related to the algorithm where either you
#   loop on the string forward and keep last position with maximum score,
#   or you loop backward and abort as soon as possible as soon you know
#   that you found some position at the end that must have maximum score.
# j) These properties are "boolean" flags (integers that are powers of 2).
#   We first put the exact integers,
#   then wondered about switching everything to exponentiation 2**i,
#   then we took the solution that minimizes the character length between
#   [1-9][0-9]* and 2**i, then reverted to initial before committing.
#   Most efficient interpreted code is what we did first,
#   if there is no opcode cache for constants.
#   Most safe code is when the language hides the details and handles
#   families of flags,
#   but beware if some flag goes into the database.
#   Most readable code is a mix: 1 is easier to read than 2**0 ;) :P,
#   or $((2<<0))...
#   What I would love to see in many languages is a flag type, as a subtype
#   of integers, flag32, flag64 for C for example.
#   I think there is no such thing because sooner or later you play with
#   pseudo-flags that are combination of flags, hence integers.
#   But just for the declaration to let the type checker check that the
#   integer is a power of 2: flag32 MY_FLAG = 4;
#   Or better flag32 MY_FLAG = 2; as an equivalent of int32 MY_FLAG = 1<<2;
#   Another fact is that practice makes perfect, so working with the powers
#   of 2 written out in base 10 gets you accustomed to them.
#   Safe code should be favored since (pre-)compilation optimizes it,
#   but for this project, I prefer to keep the integers in decimal and
#   check that it doubles when reading my listing, because I'm familiar
#   with that and the powers of 2 doesn't go beyond what I can check fast
#   enough in my brain.
# k) Some of the properties below are union of other properties,
#   and are here to simplify not only code but understanding.
#   split_score_properties_logical_closure() function below checks that
#   all flags that are consequences of already activated flags are set.
# l) We use SSP_ prefix for SPLIT_SCORE_PROPERTY_.
# Some of these remarks are repeated below in the corresponding functions,
# and some remarks are added just after the constants.
#--------------------------------------------------------------------------
# Any score after a character that matches a delimiter
# is larger than or equal to
# any score before a character that matches a delimiter.
# RPPe RMMNotNull RIA!=T2 RS<=
declare -gir SSP_ALWAYS_LARGER_AFTER=1

# Any score before a character that matches a delimiter
# is larger than or equal to
# any score after a character that matches a delimiter.
# RPPe RMMNotNull RIA!=T1 RS<=
declare -gir SSP_ALWAYS_LARGER_BEFORE=2

# The score doesn't depend on the delimiter that is found.
# RPP1 RMMNotNull RIA= RS=
declare -gir SSP_DELIMITER_UNIFORM=4

# Whenever a character that matches a delimiter is found,
# the score after is equal to the score before.
# Or equivalently:
# For any delimiter, and for any character position,
# if the character at this position matches this delimiter,
# the score after the character
# is equal to
# the score before the character.
# RPP1 RMM= RIA!= RS=
declare -gir SSP_EQUAL_AFTER_OR_BEFORE=8
# declare -gir SSP_SAME_DELIMITER_AND_POSITION_EQUAL_AFTER_OR_BEFORE=

# Whenever a character that matches a delimiter is found,
# the score after is larger than or equal to the score before.
# Or equivalently:
# For any delimiter, and for any character position,
# if the character at this position matches this delimiter,
# the score after the character
# is larger than or equal to
# the score before the character.
# RPP1 RMM= RIA!=T2 RS<=
declare -gir SSP_LARGER_AFTER=16
# declare -gir SSP_SAME_DELIMITER_AND_POSITION_LARGER_AFTER=

# Whenever a character that matches a delimiter is found,
# the score before is larger than or equal to the score after.
# Or equivalently:
# For any delimiter, and for any character position,
# if the character at this position matches this delimiter,
# the score before the character
# is larger than or equal to
# the score after the character.
# RPP1 RMM= RIA!=T1 RS<=
declare -gir SSP_LARGER_BEFORE=32
# declare -gir SSP_SAME_DELIMITER_AND_POSITION_LARGER_BEFORE=

# The score after, resp. before, a character that matches a delimiter
# doesn't decrease when the position in the string increase.
# (RPP2 or RPP3) RMM= RIA= RS<=
declare -gir SSP_POSITION_NOT_DECREASING=64

# The score after a character that matches a delimiter doesn't decrease
# when the position in the string increases.
# (RPP2 or RPP3) RMM= RIA=T RS<=
declare -gir SSP_POSITION_NOT_DECREASING_AFTER=128

# The score before a character that matches a delimiter doesn't decrease
# when the position in the string increases.
# (RPP2 or RPP3) RMM= RIA=F RS<=
declare -gir SSP_POSITION_NOT_DECREASING_BEFORE=256

# The score after, resp. before, a character that matches a delimiter
# doesn't depend on the position in the string.
# (RPP2 or RPP3) RMM= RIA= RS=
declare -gir SSP_POSITION_UNIFORM=512

# The score after a character that matches a delimiter doesn't depend
# on the position in the string.
# (RPP2 or RPP3) RMM= RIA=T RS=
declare -gir SSP_POSITION_UNIFORM_AFTER=1024

# The score before a character that matches a delimiter doesn't depend
# on the position in the string.
# (RPP2 or RPP3) RMM= RIA=F RS=
declare -gir SSP_POSITION_UNIFORM_BEFORE=2048

# For any delimiter,
# any score after a character that matches this delimiter
# is equal to
# any score before a character that matches this delimiter.
# RPPe RMM= RIA!= RS=
# <=> RPPe RMM= RIAe RS=
declare -gir SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE=4096

# For any delimiter,
# any score after a character that matches this delimiter
# is larger than or equal to
# any score before a character that matches this delimiter.
# RPPe RMM= RIA!=T2 RS<=
declare -gir SSP_SAME_DELIMITER_LARGER_AFTER=8192

# For any delimiter,
# any score before a character that matches this delimiter
# is larger than or equal to
# any score after a character that matches this delimiter.
# RPPe RMM= RIA!=T1 RS<=
declare -gir SSP_SAME_DELIMITER_LARGER_BEFORE=16384

# For any character position,
# assuming that a character at this position matches some delimiter,
# the score after a character at this position that matches a delimiter
# is equal to
# the score before a character at this position that matches a delimiter.
# RPP1 RMMNotNull RIA!= RS=
declare -gir SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE=32768

# For any character position,
# assuming that a character at this position matches some delimiter,
# the score after a character at this position that matches a delimiter
# is larger than or equal to
# the score before a character at this position that matches a delimiter.
# RPP1 RMMNotNull RIA!=T2 RS<=
declare -gir SSP_SAME_POSITION_LARGER_AFTER=65536

# For any character position,
# assuming that a character at this position matches some delimiter,
# the score before a character at this position that matches a delimiter
# is larger than or equal to
# the score after a character at this position that matches a delimiter.
# RPP1 RMMNotNull RIA!=T1 RS<=
declare -gir SSP_SAME_POSITION_LARGER_BEFORE=131072

# For all possible split/cut positions, the score is equal as long as
# at least one of the previous and next characters is a delimiter.
# Or equivalently:
# Any score after a character that matches a delimiter
# is equal to
# any score before a character that matches a delimiter.
# is_after doesn't change anything.
# So we cut on the last position adjacent to a delimiter without
# forbidden previous character (edge case, on last position).
# RPPe RMMNotNull RIAe RS=
declare -gir SSP_UNIFORM=262144
# declare -gir SSP_ALWAYS_EQUAL_AFTER_OR_BEFORE=1

#--------------------------------------------------------------------------
# m) Note that a property telling that the score is always the same
#   even if the current character isn't among delimiters is not needed,
#   since, in that case, a null split score command will split at the goal
#   length.
#--------------------------------------------------------------------------
#--------------------------------------------------------------------------

split_score_properties_logical_closure(){
  # $1=split_score_properties
  # Since this code is not performance critical,
  # we followed lexicographic order on constants,
  # instead of an order to minimize the operations.
  # It is also safer to avoid forgetting some relation.
  declare -i LFBFL_i_result=$(($1))
  declare -i LFBFL_i_result_old=0
  declare -i LFBFL_i_all_flags=$((
    SSP_ALWAYS_LARGER_AFTER
    | SSP_ALWAYS_LARGER_BEFORE
    | SSP_DELIMITER_UNIFORM
    | SSP_EQUAL_AFTER_OR_BEFORE
    | SSP_LARGER_AFTER
    | SSP_LARGER_BEFORE
    | SSP_POSITION_NOT_DECREASING
    | SSP_POSITION_NOT_DECREASING_AFTER
    | SSP_POSITION_NOT_DECREASING_BEFORE
    | SSP_POSITION_UNIFORM
    | SSP_POSITION_UNIFORM_AFTER
    | SSP_POSITION_UNIFORM_BEFORE
    | SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE
    | SSP_SAME_DELIMITER_LARGER_AFTER
    | SSP_SAME_DELIMITER_LARGER_BEFORE
    | SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
    | SSP_SAME_POSITION_LARGER_AFTER
    | SSP_SAME_POSITION_LARGER_BEFORE
    | SSP_UNIFORM
  ))
  until [[ LFBFL_i_result_old -eq LFBFL_i_result ]]; do
    LFBFL_i_result_old=$((LFBFL_i_result))
    if ((LFBFL_i_result & SSP_ALWAYS_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_AFTER
        | SSP_SAME_DELIMITER_LARGER_AFTER
        | SSP_SAME_POSITION_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_ALWAYS_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_BEFORE
        | SSP_SAME_DELIMITER_LARGER_BEFORE
        | SSP_SAME_POSITION_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_NOT_DECREASING)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_NOT_DECREASING_AFTER
        | SSP_POSITION_NOT_DECREASING_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_UNIFORM_AFTER
        | SSP_POSITION_UNIFORM_BEFORE
        | SSP_POSITION_NOT_DECREASING
        | SSP_POSITION_NOT_DECREASING_AFTER
        | SSP_POSITION_NOT_DECREASING_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_NOT_DECREASING_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_NOT_DECREASING_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_EQUAL_AFTER_OR_BEFORE
        | SSP_LARGER_AFTER
        | SSP_LARGER_BEFORE
        | SSP_SAME_DELIMITER_LARGER_AFTER
        | SSP_SAME_DELIMITER_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_DELIMITER_UNIFORM
        | SSP_EQUAL_AFTER_OR_BEFORE
        | SSP_LARGER_AFTER
        | SSP_LARGER_BEFORE
        | SSP_SAME_POSITION_LARGER_AFTER
        | SSP_SAME_POSITION_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_UNIFORM)); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_ALWAYS_LARGER_AFTER))\
    && ((
      LFBFL_i_result & (
        SSP_ALWAYS_LARGER_BEFORE
        | SSP_EQUAL_AFTER_OR_BEFORE
        | SSP_LARGER_BEFORE
        | SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_DELIMITER_LARGER_BEFORE
        | SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_POSITION_LARGER_BEFORE
      )
    )); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_ALWAYS_LARGER_BEFORE))\
    && ((
      LFBFL_i_result & (
        SSP_EQUAL_AFTER_OR_BEFORE
        | SSP_LARGER_AFTER
        | SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_DELIMITER_LARGER_AFTER
        | SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_POSITION_LARGER_AFTER
      )
    )); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_POSITION_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_POSITION_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_DELIMITER_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_LARGER_AFTER))\
    && ((LFBFL_i_result & SSP_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_EQUAL_AFTER_OR_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_LARGER_AFTER))\
    && ((
      LFBFL_i_result & (
        SSP_POSITION_UNIFORM
        | SSP_POSITION_UNIFORM_AFTER
      )
    )); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_DELIMITER_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_LARGER_BEFORE))\
    && ((
      LFBFL_i_result & (
        SSP_POSITION_UNIFORM
        | SSP_POSITION_UNIFORM_BEFORE
      )
    )); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_DELIMITER_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_NOT_DECREASING_AFTER))\
    && ((LFBFL_i_result & SSP_POSITION_NOT_DECREASING_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_NOT_DECREASING
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM))\
    && ((LFBFL_i_result & SSP_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE)); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM_AFTER))\
    && ((LFBFL_i_result & SSP_POSITION_UNIFORM_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_POSITION_UNIFORM
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM_AFTER))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_POSITION_UNIFORM_BEFORE))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_EQUAL_AFTER_OR_BEFORE))\
    && ((
      LFBFL_i_result & (
        SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_POSITION_LARGER_AFTER
        | SSP_SAME_POSITION_LARGER_BEFORE
      )
    )); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_AFTER))\
    && ((
      LFBFL_i_result & (
        SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
        | SSP_SAME_POSITION_LARGER_BEFORE
      )
    )); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_AFTER))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_AFTER)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_AFTER
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_BEFORE))\
    && ((
      LFBFL_i_result & (
        SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
        |  SSP_SAME_POSITION_LARGER_AFTER
      )
    )); then
      LFBFL_i_result=$((LFBFL_i_all_flags))
      break
    fi
    if ((LFBFL_i_result & SSP_SAME_DELIMITER_LARGER_BEFORE))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_ALWAYS_LARGER_BEFORE
      ))
    fi
    if ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_AFTER))\
    && ((LFBFL_i_result & SSP_SAME_POSITION_LARGER_BEFORE)); then
      LFBFL_i_result=$((
        LFBFL_i_result
        | SSP_SAME_POSITION_EQUAL_AFTER_OR_BEFORE
      ))
    fi
  done
  declare -gi i_split_score_properties_logical_closure_result=$((
    LFBFL_i_result
  ))
}

split_score_simple(){
  # $1=larger_after (The name was "after_before" previously,
  #                  the meaning was not modified.
  #                  Remark not repeated below.)
  # $2=delimiters_strings_domain concatenated characters/delimiters
  # $3=delimiter_string a single character
  # $4=is_cut_after
  declare -gi i_split_score_result
  if [[ "$2" != *$3* ]]; then
    i_split_score_result=0
    return
  fi
  if [[ "$4" == "$1" ]]; then
    i_split_score_result=2
    return
  fi
  i_split_score_result=1
}

get_split_score_simple(){
  # $1=larger_after
  # $2=max_length
  # $3=delimiters_strings_domain
  declare -g get_split_score_result="split_score_simple $1 '$3'"
  declare -gi i_get_split_score_result2
  # i_get_split_score_result2=$((11-$1*4))
  # if [[ $1 -eq 1 ]]; then
  #   i_get_split_score_result2=7
  # else
  #   i_get_split_score_result2=11
  # fi
  i_get_split_score_result2=$((
    SSP_DELIMITER_UNIFORM
    + SSP_POSITION_UNIFORM
    + SSP_LARGER_BEFORE
    + (
      $1 * (
        SSP_LARGER_AFTER
        - SSP_LARGER_BEFORE
      )
    )
  ))
  # shellcheck disable=SC2248
  split_score_properties_logical_closure ${i_get_split_score_result2}
  i_get_split_score_result2=$((
    i_split_score_properties_logical_closure_result
  ))
}

get_split_score_exec(){
  declare -g SPLIT_SCORE_EXEC="./build_and_checks_dependencies"
  SPLIT_SCORE_EXEC+="/split_score.exec.php"
}

split_score(){
  # $1=larger_after
  # $2=max_length
  # $3=delimiters_strings_domain concatenated characters/delimiters
  # $4=delimiter_string a single character
  # $5=cut_position
  # $6=is_cut_after
  get_split_score_exec
  declare -r LFBFL_command="${SPLIT_SCORE_EXEC} $1 $2 '$3' '$4' $5 $6"
  declare -gi i_split_score_result
  i_split_score_result=$(eval "${LFBFL_command}")
}

# This function is currently not called,
# hence we need this shellcheck disable.
# shellcheck disable=SC2034
get_split_score(){
  # $1=larger_after
  # $1=max_length
  # $2=delimiters_strings_domain
  declare -g get_split_score_result="split_score $1 $2 '$3'"
  declare -gi i_get_split_score_result2
  # i_get_split_score_result2=$((9-$1*4))
  i_get_split_score_result2=$((
    SSP_DELIMITER_UNIFORM
    + SSP_LARGER_BEFORE
    + (
      $1 * (
        SSP_LARGER_AFTER
        - SSP_LARGER_BEFORE
      )
    )
  ))
  # shellcheck disable=SC2248
  split_score_properties_logical_closure ${i_get_split_score_result2}
  i_get_split_score_result2=$((
    i_split_score_properties_logical_closure_result
  ))
}

split_line_at_most(){
  # $1=line
  # $2=max_length of beginning result string
  # $3=split_score_command
  #   negative score means do not consider as a possible split
  # $4=split_score_command_properties :
  #   These properties are flags.
  #   If someday some property is not a flag,
  #   then create split_score_command_properties2.
  #   Old values to get a simple idea without reading everything at the
  #   beginning of file:
  #   - null or 0 no property;
  #   - 1 split score doesn't depend on which delimiter matches;
  #   - 2 split score doesn't depend on the current position;
  #   - 4 any split score after is always larger
  #     than any split score before;
  #   - 8 any split score before is always larger
  #     than any split score after;
  # $5=forbidden_previous_character
  # $6=split_score_command_delimiter_strings_domain
  #   optimisation if small domain
  #   - this argument can be "null", then we will use $3 only instead,
  #     in that case, only mono-character strings are considered,
  #   - this argument can be an array of characters,
  #     optimize accordingly,
  #   - this argument can be an array of strings,
  #     optimize accordingly,
  #   - this argument can be an array of regexps,
  #     optimize accordingly.
  #     Not sure an array of regexps makes more sense than a single
  #     one. Maybe they could be both cases with corresponding
  #     optimizations. Same for a single character or substring.
  #
  # Note that we're always looking for the last position to split
  # among the positions with maximum score;
  # if some position gets a score from 2 delimiters,
  # its score is always the maximum of the two corresponding scores.
  declare -g split_line_at_most_result_start
  declare -g split_line_at_most_result_end
  declare -A LFBFL_positions
  # printf "%s %s %s %s\n" "$1" "$2" "$3" "$4"
  # For my use case in Bash scripts, I will need only an array of
  # characters. See get_split_score().
  if [[ -n "$6" ]]; then
    printf $'split_line_at_most() $6 NOT IMPLEMENTED YET\n'
  fi
  if [[ $2 -ge ${#1} ]]; then
    split_line_at_most_result_start=$1
    split_line_at_most_result_end=""
    return
  fi
  # We know that ${#1} > $2, hence ${#1} - 1 >= $2
  # Edge cases:
  # There is always at least one character that is overlength,
  # but we need to look only at the score before that character that is
  # overlength, the score after that character is invalid,
  # whatever ${#1} - 1 = $2, or ${#1} - 1 > $2.
  # That first character that is overlength has index $2.
  # The cut position after that character has index $2 + 1.
  # Looping from character position going from 0 to $2, we need to drop
  # score before character 0 and drop score after character $2.
  # We do this with forbidden score -1.
  declare -ir LFBFL_i_max=$(($2))
  declare -i LFBFL_i
  declare -i LFBFL_j
  local LFBFL_current_char

  # At the beginning, each position has score 0.
  LFBFL_positions["0"]="-1"
  for ((LFBFL_i = 1; LFBFL_i <= LFBFL_i_max; ++LFBFL_i)) do
    LFBFL_positions["${LFBFL_i}"]="0"
  done
  LFBFL_positions["${LFBFL_i}"]="-1"

  # If we have a forbidden previous character,
  # we mark the forbidden positions with -1.
  if [[ -n "$5" ]]; then
    for ((LFBFL_i = 0; LFBFL_i < LFBFL_i_max;)) do
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      ((++LFBFL_i))
      if [[ "${LFBFL_current_char}" == "$5" ]]; then
        LFBFL_positions["${LFBFL_i}"]="-1"
      fi
    done
  fi

  declare -r LFBFL_sort_command="sort --numeric-sort"

  if (($4 & SSP_DELIMITER_UNIFORM))\
  && (($4 & SSP_LARGER_AFTER))\
  && (($4 & SSP_POSITION_NOT_DECREASING_AFTER)); then
    for ((LFBFL_i = LFBFL_i_max; LFBFL_i >= 0; --LFBFL_i)) do
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      eval "$3 '${LFBFL_current_char}' 1"
      # needs j=i+1 printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_j}"
      if [[ i_split_score_result -ge 1 ]]; then
        LFBFL_j=$((LFBFL_i + 1))
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_j}"
        if [[ ${LFBFL_positions["${LFBFL_j}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_j}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_j}"]}"\
              "${i_split_score_result}"
          )
          break
        fi
      fi
      eval "$3 '${LFBFL_current_char}' 0"
      # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
      if [[ i_split_score_result -ge 1 ]]; then
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${i_split_score_result}"
          )
        fi
      fi
    done
  elif (($4 & SSP_DELIMITER_UNIFORM))\
  && (($4 & SSP_LARGER_BEFORE))\
  && (($4 & SSP_POSITION_NOT_DECREASING_BEFORE)); then
    for ((LFBFL_i = LFBFL_i_max; LFBFL_i >= 0; --LFBFL_i)) do
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      # We still need to break in second if, after computing score after,
      # because SSP_LARGER_BEFORE implies large inequality instead of
      # strict inequality.
      # And since the algorithm is to take the largest position with
      # maximum score, there is a possibility that we'll break on a found
      # score before but for splitting on a score after.
      eval "$3 '${LFBFL_current_char}' 1"
      # needs j=i+1 printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_j}"
      if [[ i_split_score_result -ge 1 ]]; then
        LFBFL_j=$((LFBFL_i + 1))
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_j}"
        if [[ ${LFBFL_positions["${LFBFL_j}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_j}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_j}"]}"\
              "${i_split_score_result}"
          )
        fi
      fi
      eval "$3 '${LFBFL_current_char}' 0"
      # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
      if [[ i_split_score_result -ge 1 ]]; then
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${i_split_score_result}"
          )
          break
        fi
      fi
    done
  else
    for ((LFBFL_i = 0; LFBFL_i <= LFBFL_i_max;)) do
      LFBFL_current_char="${1:${LFBFL_i}:1}"
      eval "$3 '${LFBFL_current_char}' ${LFBFL_i} 0"
      # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
      if [[ i_split_score_result -ge 1 ]]; then
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${i_split_score_result}"
          )
        fi
      fi
      ((++LFBFL_i))
      eval "$3 '${LFBFL_current_char}' ${LFBFL_i} 1"
      # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
      if [[ i_split_score_result -ge 1 ]]; then
        # printf "%s|%s\n" "${i_split_score_result}" "${LFBFL_i}"
        if [[ ${LFBFL_positions["${LFBFL_i}"]} != "-1" ]]; then
          LFBFL_positions["${LFBFL_i}"]=$(
            max "${LFBFL_sort_command}"\
              "${LFBFL_positions["${LFBFL_i}"]}"\
              "${i_split_score_result}"
          )
        fi
      fi
    done
  fi
  declare -ir LFBFL_i_max_score=$(
    max 'sort --numeric-sort' "${LFBFL_positions[@]}"
  )
  local LFBFL_value
  declare -i LFBFL_i_best_position
  for ((LFBFL_i = LFBFL_i_max; LFBFL_i >= 0; --LFBFL_i)) do
    if [[ LFBFL_i -eq 0 ]]; then
      printf $'/!\\split_line_at_most bug: no split position found./!\\\n'
    fi
    local LFBFL_value=${LFBFL_positions[${LFBFL_i}]}
    # printf "%s %s\n" "${LFBFL_i} ${LFBFL_value}"
    if [[ "${LFBFL_value}" == "${LFBFL_i_max_score}" ]]; then
      LFBFL_i_best_position=$((LFBFL_i))
      break
    fi
  done
  # shellcheck disable=SC2248
  split_line_at "$1" ${LFBFL_i_best_position}
  split_line_at_most_result_start="${split_line_at_result_beginning}"
  split_line_at_most_result_end="${split_line_at_result_end}"
  # printf "%s\n" "$split_line_at_most_result_start"
  # printf "%s\n" "$split_line_at_most_result_end"
}

split_last_line(){
  # $1=new_lines
  # $2=prefix
  # $3=max_length
  # $4=suffix
  # $5=split_score_command
  # $6=split_score_command_properties
  # $7=forbidden_previous_character ('\' usually)
  # Options:
  #   --verbose
  # In general, a prefix/suffix can be a required line prefix/suffix
  # for all final lines like a comment prefix,
  # or it can be a continuation line prefix/suffix applied only
  # when splitting a line in 2 lines,
  # or it can be a prefix/suffix for the string made of all the lines.
  # Clearly, there is no gain to couple handling a prefix/suffix for
  # the string made of all the lines in this function.
  # Since we add a prefix/suffix when splitting,
  # it is easy to see that we do not need to distinguish between
  # required line prefix/suffix and continuation line prefix/suffix.
  # The $2 and $4 arguments are given as concatenation of the
  # required and continuation line prefixes/suffixes as needed by the
  # user.
  # Thus lines arguments should be given already prefixed
  # and suffixed.
  # This is logic, since it would be cumbersome to handle prefixing
  # or not already splitted lines in this function
  # (see repeated_split_last_line).
  # The given max_length is the goal.
  # This function adapts the effective max position for the split by
  # taking into account the length of the suffix.
  declare -i LFBFL_i_verbose=0
  get_verbose_option "$@"
  declare -a LFBFL_return_traps_stack
  local LFBFL_previous_return_trap
  init_return_trap

  enhanced_set_shell_option pipefail --trap-unset

  declare -g split_last_line_result="$1"
  declare -ir LFBFL_i_overlength=$(($3 + 1))
  declare -ir LFBFL_i_length2=$(($3 - ${#4}))
  # shellcheck disable=SC2248
  get_overlength_regexp ${LFBFL_i_overlength}

  # Testing if some line is too long.
  printf "%s" "$1"\
    | grep --quiet "${get_overlength_regexp_result}"
  if [[ ${PIPESTATUS[1]} -eq 1 ]]; then
    return
  fi

  declare -r LFBFL_start=$(
    printf "%s" "$1"\
    | head --lines=-1
  )
  # printf "start: %s\n" "${LFBFL_start}"
  declare -r LFBFL_last_line=$(
    printf "%s" "$1"\
    | tail --lines=1
  )
  # printf "last_line: %s\n" "${LFBFL_last_line}"
  split_last_line_result=""
  if [[ -n "${LFBFL_start}" ]]; then
    split_last_line_result="${LFBFL_start}"
    # Last line-return of LFBFL_start seems dropped by $() and not ="${}".
    # printf "%s %s\n" "${#split_last_line_result}"
    #   "${split_last_line_result}"
    split_last_line_result+=$'\n'
    # something="${split_last_line_result}"
    # printf "%s %s\n" "${#something}" "${something}"
  fi
  if [[ -n "$5" ]]; then
    # shellcheck disable=SC2248
    split_line_at_most "${LFBFL_last_line}" ${LFBFL_i_length2}\
      "$5" "$6" "$7"
    split_last_line_result+="${split_line_at_most_result_start}"
    split_last_line_result+="$4"
    split_last_line_result+=$'\n'
    split_last_line_result+="$2${split_line_at_most_result_end}"
  else
    split_last_line_result+="${LFBFL_last_line:0:${LFBFL_i_length2}}"
    split_last_line_result+="$4"
    split_last_line_result+=$'\n'
    split_last_line_result+="$2${LFBFL_last_line:${LFBFL_i_length2}}"
  fi
  # printf "result: %s\n" "${split_last_line_result}"
}

repeated_split_last_line(){
  # See split_last_line for the first arguments.
  # $8=final_suffix to handle when the end of the original string
  #    is the suffix.
  declare -g repeated_split_last_line_result="$1"
  local LFBFL_result="$1x"
  until
    [[ "${LFBFL_result}" == "${repeated_split_last_line_result}" ]];
  do
    split_last_line "${repeated_split_last_line_result}" "$2" "$3"\
      "$4" "$5" "$6" "$7"
    LFBFL_result="${repeated_split_last_line_result}"
    repeated_split_last_line_result="${split_last_line_result}"
    # printf "%s\n" "${repeated_split_last_line_result}"
  done
  if [[ -n "$4" && -n "$8" ]]; then
    declare -ir LFBFL_i_offset=$((-${#4}))
    local LFBFL_lines_end
    LFBFL_lines_end="${repeated_split_last_line_result: ${LFBFL_i_offset}}"
    if [[ "${LFBFL_lines_end}" == "$4" ]]; then
      repeated_split_last_line_result+="$8"
    fi
  fi
}
