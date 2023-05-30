FROM gradle:8.1-jdk17-focal

RUN mkdir -p /usr/local/lib/android/android-sdk-linux/cmdline-tools
RUN mkdir -p /usr/local/lib/maven

# See: https://developer.android.com/studio/index.html 
ENV ANDROID_SDK_TOOLS 9477386_latest
ENV ANDROID_COMPILE_SDK 33
ENV ANDROID_BUILD_TOOLS 33.0.2
ENV APACHE_MAVEN_VER 3.9.2

ENV ANDROID_ROOT /usr/local/lib/android
ENV ANDROID_SDK_ROOT $ANDROID_ROOT/android-sdk-linux
ENV ANDROID_HOME $ANDROID_ROOT/android-sdk-linux
ENV APACHE_MAVEN_ROOT /usr/local/lib/maven

# Install dependencies
RUN apt-get update && \
  apt-get install -y \
  wget \
  tar \
  unzip \
  lib32stdc++6 \
  lib32z1
  
# Install android cmd line tools
ARG SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip
ARG SDK_SIG=https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip.asc
# TODO verify signature
RUN wget --output-document=android-sdk.zip ${SDK_URL} && \
  unzip -d ${ANDROID_SDK_ROOT}/cmdline-tools android-sdk.zip && \
  mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
  rm -f android-sdk.zip

# Install android, platform tools, and build tools using sdkmanager
ARG SDKMANAGER=${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager
RUN echo y | ${SDKMANAGER} "platforms;android-${ANDROID_COMPILE_SDK}"
RUN echo y | ${SDKMANAGER} "platform-tools"
RUN echo y | ${SDKMANAGER} "build-tools;${ANDROID_BUILD_TOOLS}"
# RUN echo y | ${SDKMANAGER} "emulator" # makes image too big!

# Use yes to accept all licenses
RUN yes | ${SDKMANAGER} --licenses

RUN chmod -R a+rwx ${ANDROID_SDK_ROOT}

# Install apache maven
ARG MVN_FILE=apache-maven-${APACHE_MAVEN_VER}
ARG MVN_URL=https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/${MVN_FILE}-bin.zip
ARG MVN_SIG=https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/${MVN_FILE}-bin.zip.asc
# TODO verify signature
RUN wget --output-document=${MVN_FILE}.zip ${MVN_URL} && \
  unzip -d ${APACHE_MAVEN_ROOT} ${MVN_FILE}.zip && \
  rm -f ${MVN_FILE}

ENV PATH $PATH:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/:${APACHE_MAVEN_ROOT}/${MVN_FILE}/bin/
