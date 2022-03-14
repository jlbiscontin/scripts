#!/bin/sh
#
#    01-motd-tsoft - corporate branding
#    Copyright (C) 2021-TSOFT
#
#    Author: Javier Biscontin <javier.biscontin@tsoftglobal.com>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# Declare variables
RED="\033[0;31m"
LRED="\033[1;31m"
RESET="\033[0m"

# Corporate branding
printf "\n"
printf "                                                                  ${LRED}**${RESET}\n"
printf "                                                                  ${LRED}****${RESET}\n"
printf "                                                                   ${LRED}*****${RED},${RESET}\n"
printf "  @@@@@@@@@@@   @@@@@@@@       @@@@@@@     @@@@@@@@@@ @@@@@@@@@@@   ${LRED}****${RED},,,${RESET}\n"
printf "      @@@     @@@      @@@   @@@     @@@   @@@            @@@        ${LRED}**${RED},,,,,,${RESET}\n"
printf "      @@@     @@@@@@@@@@    @@@       @@@  @@@@@@@@@      @@@         ${LRED}*${RED},,,,,,,,${RESET}\n"
printf "      @@@              @@@  @@@       @@@  @@@            @@@         ${RED}********${RESET}\n"
printf "      @@@     @@@      @@@   @@@     @@@   @@@            @@@        ${RED}*******${RESET}\n"
printf "      @@@       @@@@@@@@       @@@@@@@     @@@            @@@       ${RED}*****${RESET}\n"
printf "                                                                   ${RED}***${RESET}\n"
printf "                                                                  ${RED}**${RESET}\n"
printf "\n"
printf "  DISCLAIMER:   Este sistema es propiedad de TSOFT y puede ser monitoreado,\n"
printf "                auditado y/o inspeccionado. Iniciar sesión asume conformidad\n"
printf "                con esta política de seguridad y el compromiso de respetarla.\n"
printf "                El uso no autorizado o inadecuado puede resultar en una acción\n"
printf "                disciplinaria y/o acciones legales.\n"
printf "\n"
printf "  Distro:       $(lsb_release -s -d) ($(uname -o) $(uname -r) $(uname -m))\n"
printf "  Hostname:     $(uname -n)\n"