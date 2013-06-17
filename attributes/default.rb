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

include_attribute 'postgresql'

default['wal-e']['repo'] = 'https://github.com/wal-e/wal-e.git'
default['wal-e']['path'] = '/opt/wal-e'
default['wal-e']['bin'] = '/usr/local/bin'
default['wal-e']['revision'] = '2f2a4662550b875a40362fc027d44076b4c04de8'
default['wal-e']['user'] = 'postgres'
default['wal-e']['data'] = node[:postgresql][:config][:data_directory]
default['wal-e']['bucket'] = bucket = 'xxx'
default['wal-e']['envdir'] = "#{node['runit']['service_dir']}/wal-e/env"
default['wal-e']['env'] = {
  'TMP' => '/tmp',
  'PATH' => '/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin',
  'AWS_SECRET_ACCESS_KEY' => 'xxx',
  'AWS_ACCESS_KEY_ID' => 'xxx',
  'WALE_S3_PREFIX' => "s3://#{bucket}/#{node.name}"
}

default['wal-e']['sensu']['subscribers'] = 'postgresql'
default['wal-e']['sensu']['interval'] = 15
default['wal-e']['sensu']['additional'] = {}

override['postgresql']['recovery']['restore_command'] = %Q(#{node['wal-e']['bin']}/wal-e wal-fetch "%f" "%p")

override['postgresql']['config']['archive_mode'] = 'on'
override['postgresql']['config']['archive_command'] = %Q(#{node['wal-e']['bin']}/wal-e wal-push "%p")
override['postgresql']['config']['hot_standby'] = 'on'

