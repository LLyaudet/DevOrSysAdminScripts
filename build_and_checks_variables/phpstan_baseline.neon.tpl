parameters:
 ignoreErrors:
  # https://github.com/phpstan/phpstan/issues/14585
  -
   rawMessage: Variable $argv might not be defined.
   identifier: variable.undefined
   count: 1
   path: ../build_and_checks_dependencies/build_dependencies_notes.exec.php
  -
   rawMessage: 'Parameter #2 $i_current_octet of function \
               DOSAS_unicode\get_message_and_data_array expects int, \
               int<0, 191>|int<194, 244>|int<246, 254>|null given.'
   identifier: argument.type
   count: 1
   path: ../unicode.libr.php
