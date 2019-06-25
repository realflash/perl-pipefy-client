use warnings;
use strict;
use Test::More;
use Test::Exception;
use Pipefy::Client;
use Data::Dumper;

BEGIN {}

my $pipefy_oauth_token = $ENV{'PIPEFY_OAUTH_TOKEN'};
SKIP: {
	skip "Environment variable PIPEFY_OAUTH_TOKEN not defined; skipping tests", 1 if !defined($pipefy_oauth_token);

	# Client object is created OK
	ok(sub {Pipefy::Client->new({ oauth_token => $pipefy_oauth_token })}, "Client creation");

	my $client = Pipefy::Client->new({ oauth_token => $pipefy_oauth_token });
	my $user = $client->me();
	is(length($user->name) > 1, 1, "Checking property name is populated - '".$user->name."'");
	is(length($user->email) > 1, 1, "Checking property email is populated - '".$user->email."'");
}
done_testing();
