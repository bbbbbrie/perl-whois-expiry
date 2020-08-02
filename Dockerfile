FROM ubuntu:20.04
LABEL AUTHOR "Brie Carranza <hi@brie.ninja>"

LABEL description="A Docker container that will check WHOIS \
and print the expiration date for the specified domain name."

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "perl", \
      "build-essential", \
      "cpanminus" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]

# Install needed CPAN modules
RUN ["cpanm", "Net::Whois::Raw", "Net::Domain::ExpireDate" ]

# Put Perl script in place
COPY [ "./check-expiry.pl", "/app/check-expiry.pl" ]
RUN [ "chmod", "+x",  "/app/check-expiry.pl" ]

RUN ["cat", "/app/check-expiry.pl"]

# Specify an entrypoint
ENTRYPOINT [ "/app/check-expiry.pl" ]
