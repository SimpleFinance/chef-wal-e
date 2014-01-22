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

default[:wal_e][:repo] = 'https://github.com/wal-e/wal-e.git'
default[:wal_e][:revision] = '932f609fe3c9adc1bf5059d4274942f7d47a18d8'
default[:wal_e][:path] = '/opt/wal-e'
default[:wal_e][:bin] = '/usr/local/bin'
default[:wal_e][:user] = 'postgres'
default[:wal_e][:bucket] = 'xxx'
default[:wal_e][:envdir] = "#{node[:runit][:service_dir]}/wal-e/env"
default[:wal_e][:use_iam] = false

default[:wal_e][:env]['AWS_SECRET_ACCESS_KEY'] = 'xxx'
default[:wal_e][:env]['AWS_ACCESS_KEY_ID'] = 'xxx'

default[:wal_e][:env]["TMP"] = '/tmp'
default[:wal_e][:env]["PATH"] = '/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin'

