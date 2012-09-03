#!/bin/bash


## smartITSM Demo System
## Copyright (C) 2012 synetics GmbH <http://www.smartitsm.org/>
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU Affero General Public License as
## published by the Free Software Foundation, either version 3 of the
## License, or (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


##
## Export Icinga configuration from i-doit and enable it in Icinga itself.
##


/var/www/i-doit_svn/controller -m nagios_export -u icinga -p icinga -i 1 -v -n demo.smartitsm.org
md5sum --status -c /tmp/i-doit_icinga.md5
status="$?"

if [ "$status" -gt 0 ]; then
    echo "Reloading Icinga configuration..."
    service icinga reload
    find /etc/icinga /var/www/i-doit_svn/icingaexport -type -f -print0 | xargs -0 md5sum > /tmp/i-doit_icinga.md5
else
    echo "Icinga configuration is up-to-date."
fi

exit 0
