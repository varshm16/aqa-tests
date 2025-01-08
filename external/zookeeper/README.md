# External Zookeeper Tests

Zookeeper tests are a part of the external third-party application tests that help verify that the Adoptium binaries are good by running a variety of Java applications inside of Docker containers. adoptium/aqa-tests/[Issue #172](https://github.com/adoptium/aqa-tests/issues/172) lists the applications that we have initially targeted to best exercise the Adoptium binaries. For each application, we choose to run a selection of their functional tests. Zookeeper test material is pulled from the [Zookeeper](https://github.com/apache/zookeeper.git) repository.


## Running External Zookeeper tests locally

To run AQA tests locally using Zookeeper, you follow the same pattern:

0. Ensure your test machine is set up with [test prereqs](https://github.com/adoptium/aqa-tests/blob/master/doc/Prerequisites.md). For external tests, you do need Docker installed.

1. Download/unpack the SDK that you want to test to your test machine.

2. `export TEST_JDK_HOME=</pathToWhereYouInstalledSDK>`

3. `git clone https://github.com/adoptium/aqa-tests.git`

4. `cd aqa-tests`

5. `./get.sh`

6. `cd TKG`

7. export required environment variables, BUILD_LIST and EXTRA_DOCKER_ARGS (`export BUILD_LIST=external/zookeeper` and `export EXTRA_DOCKER_ARGS="-v $TEST_JDK_HOME:/opt/java/openjdk"`

8. `make compile` (This fetches test material and compiles it, based on build.xml files in the test directories)

9. `make _zookeeper_test` (When you defined BUILD_LIST to point to a directory in aqa-tests/external, then this is a testCaseName from the playlist.xml file within the directory you chose)

When [running these from the command-line](https://github.com/adoptium/aqa-tests/blob/master/doc/userGuide.md#local-testing-via-make-targets-on-the-commandline), these tests are grouped under a make target called 'external', so 'make external' would run the entire set of tests found in the aqa-tests/external directory. This is unadvisable! Limit what you compile and run, BUILD_LIST=external/`<someSubDirectory>`, and TARGET=`<testCaseNameFromSubdirPlaylist>`

These tests run regularly and results can be found in [TRSS Third Party Application view](https://trss.adoptium.net/ThirdPartyAppView).

