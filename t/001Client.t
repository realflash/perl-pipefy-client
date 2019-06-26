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

	# Client object is created OK
	ok(Pipefy::Client->new({ oauthToken => $pipefy_oauth_token, organizationID => $pipefy_org_id }), "Client creation");
	dies_ok(sub {HubSpot::Client->new({ oauthToken => 'foo', $pipefy_org_id => '9999' })}, "Client creation dies with nonsense token");
	dies_ok(sub {HubSpot::Client->new({ organizationID => '9999' })}, "Client creation dies with missing token");
	dies_ok(sub {HubSpot::Client->new({ oauthToken => $pipefy_oauth_token })}, "Client creation dies with missing id");
	dies_ok(sub {HubSpot::Client->new({ })}, "Client creation dies with everything missing");


	my $client = Pipefy::Client->new({ oauthToken => $pipefy_oauth_token, organizationID => $pipefy_org_id });
	my $user = $client->me();
	is(length($user->name) > 1, 1, "Checking property name is populated - '".$user->name."'");
	is(length($user->email) > 1, 1, "Checking property email is populated - '".$user->email."'");
}
done_testing();
