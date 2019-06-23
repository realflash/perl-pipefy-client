######################################################################
# Makefile.PL for Pipefy::Client
# 2019, Ian Gibbs <igibbs@cpan.org>
######################################################################
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Pipefy::Client',
    'VERSION_FROM' => 'lib/Pipefy/Client.pm', # finds $VERSION
    'PREREQ_PM'    => {
		"Test::More" => "1",
		"REST::Client" => "273",
		"JSON" => "2.61",
		"Error" => "0.17"
    }
);
