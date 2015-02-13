FROM ubuntu
MAINTAINER "Tanguy ⧓ Herrmann <dolanorgit@evereska.org>"

RUN apt-get update -y && apt-get install git bundler npm -y
# Kind of an ugly trick, but otherwise bower won't find nodejs
RUN npm install -g bower && ln -s /usr/bin/nodejs /usr/bin/node

RUN useradd -ms /bin/bash daftpunk && mkdir -p /app && chown -R daftpunk.daftpunk /app
USER daftpunk
ENV HOME /home/daftpunk

COPY . /app
WORKDIR /app
RUN bundle install --path /app/.gem
RUN bower install -f

EXPOSE 4567

CMD [ "bundle", "exec", "middleman", "server"]
