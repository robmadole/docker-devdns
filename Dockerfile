FROM google/golang

MAINTAINER Rob Madole http://github.com/robmadole

RUN apt-get install -y git

RUN \
  git clone https://github.com/robbiev/devdns.git $GOPATH/src/devdns && \
  cd $GOPATH/src/devdns && \
  go get . && \
  # Use "-w" to keep the binary smaller
  go build -ldflags "-w" .

# Script to easily start our server
ADD devdns.sh /usr/bin/devdns.sh

# Make it executable
#RUN chmod a+x /usr/bin/devdns.sh

# When we query the DNS server what IP address should it always answer with?
ENV ANSWER 127.0.0.1

# This is where the DNS server will listen
EXPOSE 5300

CMD ["/usr/bin/devdns.sh"]
