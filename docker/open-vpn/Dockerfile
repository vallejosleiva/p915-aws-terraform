FROM python:2

RUN pip install
RUN pip install ansible
RUN pip install passlib
RUN apt-get update
RUN apt-get -y install qrencode
RUN apt-get -y install imagemagick
RUN apt-get install autotools-dev
RUN apt-get install autoconf
RUN cp /usr/lib/x86_64-linux-gnu/libqrencode.so.3 /usr/local/lib/
RUN apt-get -y install build-essential libpam0g-dev freeradius
RUN git clone https://github.com/google/google-authenticator-libpam.git
RUN chmod +x google-authenticator-libpam/bootstrap.sh
RUN cd google-authenticator-libpam; ./bootstrap.sh
RUN chmod +x google-authenticator-libpam/configure
RUN cd google-authenticator-libpam; ./configure; make; make install
RUN mkdir /p915-aws-terraform