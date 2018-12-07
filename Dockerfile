FROM centos:7

# Install curl, wget, gettext-base(for envsubst)
RUN yum install -y curl wget gettext-base java-11-openjdk-headless \
    && yum clean all

