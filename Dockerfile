FROM ruby:2.6.5-stretch
LABEL maintainer="Andrea Del Fante"

ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.3"
ENV VERSION_SDK_TOOLS "4333796"
ENV ANDROID_HOME "/android-sdk-linux"
ENV ANDROID_SDK_ROOT ${ANDROID_HOME}

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes \
	wget \
	tar \
	unzip \
	openjdk-8-jdk \
	build-essential

# Downloading SDK Tools
RUN wget --quiet --output-document=/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip
RUN unzip -q /android-sdk.zip -d ${ANDROID_HOME}

# Accepting licence
RUN mkdir ${ANDROID_HOME}/licenses
RUN printf "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > ${ANDROID_HOME}/licenses/android-sdk-license
RUN printf "84831b9409646a918e30573bab4c9c91346d8abd" > ${ANDROID_HOME}/licenses/android-sdk-preview-license

# Paths
ENV PATH "${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}"

# Installing tools
RUN yes | sdkmanager --licenses
RUN yes | sdkmanager --update

RUN sdkmanager \
	"tools" \
	"platform-tools" \
	"emulator"

RUN sdkmanager \
	"platforms;android-${ANDROID_COMPILE_SDK}" \
	"build-tools;${ANDROID_BUILD_TOOLS}"

RUN sdkmanager \
	"extras;google;m2repository" \
	"extras;android;m2repository" \
	"extras;google;google_play_services"

# Install dependencies
RUN gem install bundler

