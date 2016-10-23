FROM ruby:2.3.1

MAINTAINER maxime.visonneau@gmail.com

ARG CI_BUILD_REF_NAME=production

ENV PUPPET_PATH=/etc/puppetlabs/code/environments/${CI_BUILD_REF_NAME}

ADD / ${PUPPET_PATH}

RUN \
cd ${PUPPET_PATH} && \
rm -rf .git .gitignore .gitlab-ci.yml Dockerfile && \
gem install bundler r10k --no-ri --no-rdoc && \
r10k puppetfile install -v && \
gem uninstall r10k puppet_forge minitar -x && \
gem install fpm --no-ri --no-rdoc && \
cd site/profiles && \
bundle install --jobs $(nproc)

WORKDIR ${PUPPET_PATH}
