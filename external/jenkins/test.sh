#/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

source $(dirname "$0")/test_base_functions.sh
# Set up Java to be used by the jenkins test
echo_setup

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8"
#begin jenkins test

set -e
echo "Build jenkins by using mvn \"mvn clean install -pl war -am -DskipTests\"" && \
mvn --batch-mode clean install -pl war -am -DskipTests -Denforcer.fail=false
set +e
echo "Building jenkins completed"

echo "Run jenkins test phase alone with cmd: \"mvn surefire:test\"" && \
mvn --batch-mode surefire:test -Denforcer.fail=false
test_exit_code=$?
find ./ -type d -name 'surefire-reports' -exec cp -r "{}" /testResults \;
exit $test_exit_code
