#!/bin/bash
# Create parsers-src directory and move files
curl -L "https://github.com/helloworld5591/kotatsu-parsers-redo/archive/master.zip" -o parsers.zip && \
unzip -o parsers.zip && \
mkdir -p parsers-src && \
rm -rf parsers-src/kotatsu-parsers && \
mv kotatsu-parsers-redo-master parsers-src/kotatsu-parsers && \

# Re-run ssiv download to be safe
curl -L "https://github.com/KotatsuApp/subsampling-scale-image-view/archive/376930523c.zip" -o ssiv.zip && \
unzip -o ssiv.zip && \
rm -rf ssiv-src/ssiv && \
mkdir -p ssiv-src && \
mv subsampling-scale-image-view-* ssiv-src/ssiv && \

# The rest of the build process
sed -i 's/compileSdk = 34/compileSdk = 36/' ssiv-src/ssiv/library/build.gradle && \
export JAVA_HOME=/opt/nix/store/5badkg3gmzg1c29akwglknkizfg6zj0g-openjdk-17.0.17+8/lib/openjdk && \
export ANDROID_HOME=/opt/nix/store/nibdn1wppjp3gqw1z3y14s291r8r9rhn-androidsdk/libexec/android-sdk && \
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8 && \
./gradlew assembleDebug --max-workers=1 --no-daemon
