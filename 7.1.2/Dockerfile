FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"]
ARG USERID

# install the required dependencies
RUN apt-get update --yes
RUN apt-get install git curl repo rsync openjdk-8-jdk bison g++-multilib git gperf libxml2-utils make zlib1g-dev zip liblz4-tool dc bc --yes

# copy the setup/build scripts
COPY run_build.sh /home/run_build.sh
COPY setup_repo.sh /home/setup_repo.sh
COPY build_kernel.sh /home/build_kernel.sh
RUN chmod a+x /home/run_build.sh
RUN chmod a+x /home/setup_repo.sh
RUN chmod a+x /home/build_kernel.sh

USER root
# From https://stackoverflow.com/questions/67363030/rebuild-android-code-with-error-ssl-error-when-connecting-to-the-jack-server-t
# Fix jack server SSL issue during build
RUN perl -0777 -i -p -e 's/(jdk.tls.disabledAlgorithms=.*?), TLSv1, TLSv1\.1/$1/g' \
     /etc/java-8-openjdk/security/java.security

# the local user should have the same id than the user who the aosp files belong to
WORKDIR /home/android
RUN useradd -u $USERID android
USER android
# set local to ASCII (without this, AOSP wont build)
RUN export LC_ALL=C
