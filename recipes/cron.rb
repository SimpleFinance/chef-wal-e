# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node.normal[:postgresql][:config][:archive_mode] = 'on'
node.normal[:postgresql][:config][:archive_command] = %Q(#{node[:wal_e][:bin]}/wal-e wal-push "%p")
node.normal[:postgresql][:config][:hot_standby] = 'on'

include_recipe 'wal-e::default'

svc = resources('runit_service[wal-e]')
svc.run_template_name 'wal-e-backup'

cookbook_file '/usr/local/bin/check-wal-e' do
  mode '0555'
  owner 'root'
  group 'root'
end

file '/etc/cron.d/wal-e-backup' do
  content "14 09 * * 0 root /usr/bin/sv once wal-e\n"
  owner 'root'
  group 'root'
end

