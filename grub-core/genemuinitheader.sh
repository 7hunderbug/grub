#! /bin/sh
#
# Copyright (C) 2005,2007  Free Software Foundation, Inc.
#
# This gensymlist.sh is free software; the author
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

nm="$1"
shift

cat <<EOF
/* This file is automatically generated by gensymlist.sh. DO NOT EDIT! */
/*
 *  GRUB  --  GRand Unified Bootloader
 *  Copyright (C) 2005,2007  Free Software Foundation, Inc.
 *
 *  GRUB is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  GRUB is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
 */

EOF

cat <<EOF
void grub_init_all (void);
void grub_fini_all (void);
EOF

read mods
for line in $mods; do
  if ${nm} --defined-only -P -p ${line} | grep grub_mod_init > /dev/null; then
      echo "void grub_${line%%.*}_init (void);"
  fi
  if ${nm} --defined-only -P -p ${line} | grep grub_mod_fini > /dev/null; then
      echo "void grub_${line%%.*}_fini (void);"
  fi
done
