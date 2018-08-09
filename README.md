# android-ci-gem

[![Build Status](https://travis-ci.org/andreadelfante/android-ci-gem.svg?branch=master)](https://travis-ci.org/andreadelfante/android-ci-gem)
[![](https://images.microbadger.com/badges/image/andreadelfante/android-ci-gem.svg)](https://microbadger.com/images/andreadelfante/android-ci-gem "Get your own image badge on microbadger.com")

## Build tools
### Latest
```yml
image: andreadelfante/android-ci-gem:latest
```
Version: 27.0.3

### 27.0.3
```yml
image: andreadelfante/android-ci-gem:27.0.3
```
- Build Tools: 27.0.3
- Platform: Android 25, 26 & 27

## Sample usages
### GitLab
*.gitlab-ci.yml*

```yml
image: andreadelfante/android-ci-gem:27.0.3

variables:
  ANDROID_AVD: "system-images;android-24;default;armeabi-v7a"

cache:
  paths:
    - .m2/
    - .gradle/

before_script:
  - export ANDROID_HOME=/android-sdk-linux
  - export PATH=$PATH:/android-sdk-linux/platform-tools/
  - export ANDROID_SDK_ROOT=/android-sdk-linux

  - chmod +x ./gradlew

stages:
  - build
  - test

build:
  stage: build
  script:
    - ./gradlew assembleDebug
  artifacts:
    paths:
    - app/build/outputs/

avd_tests:
  stage: test
  script:
    - wget --quiet --output-document=/android-wait-for-emulator https://raw.githubusercontent.com/travis-ci/travis-cookbooks/0f497eb71291b52a703143c5cd63a217c8766dc9/community-cookbooks/android-sdk/files/default/android-wait-for-emulator
    - chmod +x /android-wait-for-emulator

    # Downloading image
    - /android-sdk-linux/tools/bin/sdkmanager ${ANDROID_AVD}

    # Creating emulator
    - echo no | /android-sdk-linux/tools/bin/avdmanager -s create avd -n test -k ${ANDROID_AVD}

    # Starting emulator
    - /android-sdk-linux/tools/emulator -avd test -no-window -no-audio -wipe-data &
    - /android-wait-for-emulator

    # Turn off animations
    - adb shell settings put global window_animation_scale 0 &
    - adb shell settings put global transition_animation_scale 0 &
    - adb shell settings put global animator_duration_scale 0 &

    # Wake up avd
    - adb shell input keyevent 82

    # Start testing
    - ./gradlew cAT
```
