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

name             "wal-e"
maintainer       "Simple Finance Technology Corp"
maintainer_email "ops@simple.com"
license          "Apache 2.0"
description      "Installs/Configures WAL-E, a PostgreSQL backup daemon"
version          "1.2.0"

depends "postgresql"
depends "libevent"
depends "build-essential"
depends "git"
depends "python"
depends "runit"

