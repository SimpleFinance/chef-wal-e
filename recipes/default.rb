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

node.default[:wal_e][:env]['WALE_S3_PREFIX'] = "s3://#{node[:wal_e][:bucket]}/#{node.name}"
node.normal[:postgresql][:recovery][:restore_command] = %Q(#{node[:wal_e][:bin]}/wal-e wal-fetch "%f" "%p")

include_recipe 'libevent::default'
include_recipe 'build-essential::default'
include_recipe 'git::default'
include_recipe 'python::default'
include_recipe 'runit::default'

%w{ lzop pv }.each do |pkg|
  package pkg do
    action :install
  end
end

deploy_revision node[:wal_e][:path] do
  repo node[:wal_e][:repo]
  revision node[:wal_e][:revision]
  before_restart do
    python_virtualenv release_path do
      action :create
    end

    execute "./bin/pip install ." do
      cwd release_path
    end
  end
end

directory node[:wal_e][:env]["TMP"] do
  owner node[:wal_e][:user]
  mode 00644
  recursive true
  action :create
end

# Zap Mash/node attr detritus that breaks instance var creation in ERB.
node.default[:wal_e][:data] = node[:postgresql][:config][:data_directory]
opts = node[:wal_e].to_hash.reject{|k| k.include?('!')}
template "#{node[:wal_e][:bin]}/wal-e" do
  mode '00755'
  variables(opts)
end

runit_service 'wal-e' do
  action [:enable, :stop]
  run_template_name 'wal-e-env'
  default_logger true
  env(node[:wal_e][:env].dup)
  options(opts)
end

