package Pipefy::Client;
our $VERSION = "0.1";
use open qw/:std :utf8/;	# tell perl that stdout, stdin and stderr is in utf8
use strict;

# Modules
use REST::Client;
use Data::Dumper;
use JSON;
use Pipefy::User;

=pod

=head1 NAME

Pipefy::Client -- An object that can be used to manipulate the Pipefy API

=head1 SYNOPSIS

 my $client = Pipefy::Client->new({ oauth_token => $pipefy_oauth_token }); 
 # Retrieve 50 contacts
 my $contacts = $client->contacts(50);

=head1 DESCRIPTION

This module was created for internal needs. At the moment it does what I need it to do, which is to say not very much. However it is a decent enough framework for adding functionality to, so your contributions to extend it to what you need it to do are welcome.

At the moment you can only retrieve read-only representations of contact objects.

=head1 METHODS

=cut

# Make us a class
use Class::Tiny qw(rest_client oauth_token hub_id),
{
};

# Global variables
my $api_url = 'https://api.pipefy.com/graphql';
my $json = JSON->new;

sub BUILD
{
	my $self = shift;
	
	# Create ourselves a rest client to use
	$self->rest_client(REST::Client->new({ timeout => 20, follow => 1 }));
	if(length($self->{'oauth_token'}) > 0 && $self->{'oauth_token'} !~ /[0-9a-fA-F_\-\.]+/)
	{
		die("oauth_token doesn't look right. Should be a long alphanumeric string (200+ characters). You specified '".$self->{'oauth_token'}."'. To use the Pipefy demo account, don't specify oauth_token at all.");
	}
	if(length($self->{'oauth_token'}) < 1)
	{
		die("oauth_token not specified");
	}

	$self->rest_client->addHeader('Content-Type', 'application/json');
	$self->rest_client->addHeader('authorization', 'Bearer '.$self->oauth_token);

}

=item me()

Retrieve details about the account which owns the oauth token you have provided. Good for testing that all is well.

 my $contact = $client->contact_by_id('897654');owner 

Returns: L<Pipefy::Contact>, or undef if the contact wasn't found.

=cut

sub me
{
	my $self = shift;
	
	my $content = $self->_post("{ me { name, email }}");
	#~ return undef if	$self->rest_client->responseCode =~ /^404$/;
	my $result = $json->decode($content);

	return Pipefy::User->new({json => $result});
}

sub _post
{
	my $self = shift;
	my $content = shift;
	
	#~ $params = {} unless defined $params;								# In case no parameters have been specified
	#~ $params->{'hapikey'} = $self->oauth_token;						# Include the API key in the parameters
	$self->rest_client->POST($api_url, "{\"query\": \"$content\"}");	# Get it
	$self->_checkResponse();											# Check it was successful
	return $self->rest_client->responseContent();
}
	
sub _checkResponse
{
	my $self = shift;
	
	if($self->rest_client->responseCode !~ /^[23]/)
	{
		die ("Request failed.
	Response Code: ".$self->rest_client->responseCode."
	Response Body: ".$self->rest_client->responseContent."
");
	}
}
