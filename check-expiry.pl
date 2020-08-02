#!/usr/bin/perl -w

use strict;
use Net::Domain::ExpireDate;

my @the_domains = ("amazon.com", "apple.com","facebook.com","google.com");
foreach my $domain (@the_domains) {
	my $new_expiry = expire_date( $domain, '%Y-%m-%d' );
	print "$domain: $new_expiry\n";
	open (TEMP_FILE, ">>/tmp/whois-results.md") ||
              &CgiDie ("Cannot open whois-results.md. Sorry.");
        print TEMP_FILE        "  - $domain: $new_expiry\n";
        close (TEMP_FILE);
}
