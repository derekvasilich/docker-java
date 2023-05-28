FROM gradle:8.1-jdk17-focal

RUN mkdir -p /usr/local/lib/android/android-sdk-linux/cmdline-tools

# See: https://developer.android.com/studio/index.html 
ENV ANDROID_SDK_TOOLS 9477386_latest
ENV ANDROID_COMPILE_SDK 33
ENV ANDROID_BUILD_TOOLS 33.0.2

ENV ANDROID_ROOT /usr/local/lib/android
ENV ANDROID_SDK_ROOT $ANDROID_ROOT/android-sdk-linux
ENV ANDROID_HOME $ANDROID_ROOT/android-sdk-linux
ENV SDKMANAGER $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager

# Install dependencies
RUN apt-get update && \
  apt-get install -y \
  wget \
  tar \
  unzip \
  lib32stdc++6 \
  lib32z1
  
RUN wget --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip && \
  unzip -d $ANDROID_SDK_ROOT/cmdline-tools android-sdk.zip && \
  mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
  rm -f android-sdk.zip
  
RUN echo y | ${SDKMANAGER} "platforms;android-${ANDROID_COMPILE_SDK}"
RUN echo y | ${SDKMANAGER} "platform-tools"
RUN echo y | ${SDKMANAGER} "build-tools;${ANDROID_BUILD_TOOLS}"

# Use yes to accept all licenses
RUN yes | ${SDKMANAGER} --licenses

RUN chmod -R a+rwx ${ANDROID_SDK_ROOT}
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/
