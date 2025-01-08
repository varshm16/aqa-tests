#/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

source $(dirname "$0")/test_base_functions.sh
# Set up Java to be used by the functional test
echo_setup

echo "export GLIBC_TUNABLES=glibc.pthread.rseq=0:glibc.cpu.hwcaps=-XSAVEC,-XSAVE,-AVX2,-ERMS,-AVX,-AVX_Fast_Unaligned_Load";
export GLIBC_TUNABLES=glibc.pthread.rseq=0:glibc.cpu.hwcaps=-XSAVEC,-XSAVE,-AVX2,-ERMS,-AVX,-AVX_Fast_Unaligned_Load
echo "export LD_BIND_NOT=on";
export LD_BIND_NOT=on

export TEST_JDK_HOME=$JAVA_HOME
echo "TEST_JDK_HOME is : $TEST_JDK_HOME"
export JDK_VERSION=
echo "TEST_JDK_HOME has been unset, use auto-detect instead."
export DYNAMIC_COMPILE=true
export BUILD_LIST=functional
echo "USE_TESTENV_PROPERTIES is $USE_TESTENV_PROPERTIES"

cd /aqa-tests
./get.sh
cd /aqa-tests/TKG

set -e
echo "Generating make files and running the target tests"
make $1
set +e
