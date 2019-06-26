use warnings;
use strict;
use Test::More;
use Test::Exception;
use Pipefy::Client;
use Data::Dumper;

BEGIN {}

my $pipefy_oauth_token = $ENV{'PIPEFY_OAUTH_TOKEN'};
my $pipefy_org_id = $ENV{'PIPEFY_ORGANIZATION_ID'};
SKIP: {
	skip "Environment variable PIPEFY_OAUTH_TOKEN not defined; skipping tests", 1 if !defined($pipefy_oauth_token) ;
	skip "Environment variable PIPEFY_ORGANIZATION_ID not defined; skipping tests", 1 if !defined($pipefy_org_id) ;

	my $client = Pipefy::Client->new({ oauthToken => $pipefy_oauth_token, organizationId => $pipefy_org_id });
	my $user = $client->databases();
	#~ is(length($user->name) > 1, 1, "Checking property name is populated - '".$user->name."'");
	#~ is(length($user->email) > 1, 1, "Checking property email is populated - '".$user->email."'");
}
done_testing();
