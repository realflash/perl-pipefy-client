use warnings;
use strict;
use Test::More;
use Test::Exception;
use Pipefy::Client;
use Data::Dumper;

BEGIN {}

my $pipefy_oauth_token = $ENV{'PIPEFY_OAUTH_TOKEN'};
SKIP: {
	skip "Environment variable PIPEFY_OAUTH_TOKEN not defined; skipping tests", 1 if length $pipefy_oauth_token < 1;

	# Client object is created OK
	ok(sub {Pipefy::Client->new({ oauth_token => $pipefy_oauth_token })}, "Client creation");

	my $client = Pipefy::Client->new({ oauth_token => $pipefy_oauth_token });
	my $user = $client->me();
	print Dumper $user;
}
done_testing();
