FROM alpine

ENV LANG C.UTF-8
ENV BITLBEE_VERSION 3.5

RUN apk add --no-cache --update \
	libpurple \
	libpurple-xmpp \
	libpurple-oscar \
	libpurple-ymsg \
	libpurple-bonjour \
	json-glib \
	openssl	\
	libgcrypt \
	libressl \
	gettext \
	libwebp \
	&& apk add --no-cache --update --virtual .build-dependencies \
	git \
	make \
	autoconf \
	automake \
	libtool \
	gcc \
	g++ \
	json-glib-dev \
	libgcrypt-dev \
	openssl-dev \
	libwebp-dev \
	pidgin-dev
RUN cd /tmp \
	&& git clone https://github.com/bitlbee/bitlbee.git \
	&& cd bitlbee \
	&& git checkout ${BITLBEE_VERSION} \
	&& ./configure --purple=1 --ssl=openssl --prefix=/usr --etcdir=/etc/bitlbee \
	&& make \
	&& make install \
	&& make install-dev 
RUN cd /tmp \
	&& git clone https://github.com/bitlbee/bitlbee-facebook.git \
	&& cd bitlbee-facebook \
	&& ./autogen.sh \
	&& make \
	&& make install 
RUN cd /tmp \
	&& git clone https://github.com/bitlbee/bitlbee-steam.git \
	&& cd bitlbee-steam \
	&& ./autogen.sh  \
	&& make \
	&& make install 
RUN cd /tmp \
        && git clone https://github.com/sm00th/bitlbee-discord.git \
        && cd bitlbee-discord \
        && ./autogen.sh \
        && ./configure \
        && make \
        && make install
RUN cd /tmp \
	&& git clone --recursive https://github.com/majn/telegram-purple.git \
	&& cd telegram-purple \
	&& ./configure \
	&& make \
	&& make install
RUN rm -rf /tmp/* \
    && rm -rf /usr/include/bitlbee \
    && rm -f /usr/lib/pkgconfig/bitlbee.pc \
    && apk del .build-dependencies

EXPOSE 6667
VOLUME /var/lib/bitlbee
ENTRYPOINT ["/usr/sbin/bitlbee", "-F", "-n"]

