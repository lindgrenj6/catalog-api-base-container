FROM registry.access.redhat.com/ubi8/ubi

RUN dnf -y --disableplugin=subscription-manager module enable ruby:2.5 && \
    dnf -y --disableplugin=subscription-manager --setopt=tsflags=nodocs install \
    # ruby 2.5 via module
    ruby-devel \
    # build utilities
    gcc-c++ git make redhat-rpm-config \
    # libraries
    postgresql-devel openssl-devel libxml2-devel \
    #ImageMagick deps
    autoconf libpng-devel libjpeg-devel librsvg2 && \ 

    dnf clean all

# Compile ImageMagick 6 from source.
COPY ImageMagick6-6.9.10-90.tar.gz /tmp/
RUN cd /tmp/ && tar -xf ImageMagick6-6.9.10-90.tar.gz && cd ImageMagick6-6.9.10-90 && \
    ./configure --prefix=/usr --disable-docs && \
    make install && \
    cd $WORKDIR && rm -rvf /tmp/ImageMagick*
