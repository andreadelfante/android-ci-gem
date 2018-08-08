FROM openjdk:8-jdk
LABEL maintainer="Andrea Del Fante"

ENV ANDROID_COMPILE_SDK "27"
ENV ANDROID_BUILD_TOOLS "27.0.3"

ENV VERSION_SDK_TOOLS "4333796"

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 ruby ruby-dev build-essential

# Downloading SDK Tools
RUN wget --quiet --output-document=/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip
RUN unzip -q /android-sdk.zip -d /android-sdk-linux

# Accepting licence
RUN mkdir /android-sdk-linux/licenses
RUN printf "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > /android-sdk-linux/licenses/android-sdk-license
RUN printf "84831b9409646a918e30573bab4c9c91346d8abd" > /android-sdk-linux/licenses/android-sdk-preview-license

# Installing tools
RUN /android-sdk-linux/tools/bin/sdkmanager --update > update.log
RUN /android-sdk-linux/tools/bin/sdkmanager "platform-tools" "platforms;android-${ANDROID_COMPILE_SDK}" "build-tools;${ANDROID_BUILD_TOOLS}" "emulator" "extras;google;m2repository" "extras;android;m2repository" > installPlatform.log

# Install dependencies
RUN gem install bundler
