package WWW::CIA::Source;

require 5.005_62;
use strict;
use warnings;

our $VERSION = '0.01';


# Preloaded methods go here.

sub new {

    my $proto = shift;
    my $source = shift;
    my $class = ref($proto) || $proto;
    my $self = {};

    bless ($self, $class);
    return $self;

}

sub value {

    my $self = shift;
    my ($cc, $f) = @_;
    if ($cc eq 'testcountry' and $f eq 'Test') {
        return 'Wombat';
    } else {
        return undef;
    }

}

sub all {

    my $self = shift;
    my $cc = shift;
    if ($cc eq 'testcountry') {
        return {'Test' => 'Wombat'};
    } else {
        return {};
    }

}


1;
__END__


=head1 NAME

WWW::CIA::Source - a base class for WWW::CIA sources


=head1 SYNOPSIS

  use WWW::CIA::Source;
  my $source = WWW::CIA::Source->new();


=head1 DESCRIPTION

WWW::CIA::Source is a base class for WWW::CIA sources, such as
WWW::CIA::Source::DBM and WWW::CIA::Source::Web.

It could be used as a source in its own right, but it won't get you very far.


=head1 METHODS


=over 4

=item C<new()>

This method creates a new WWW::CIA::Source object. It takes no arguments.

=item C<value($country_code, $field)>

Retrieve a value. Always returns C<undef>.

=item C<all($country_code)>

Retrieve all fields and values. Always returns an empty hashref.


=back


=head1 AUTHOR

Ian Malpass (ian@indecorous.com)


=head1 COPYRIGHT

Copyright 2003, Ian Malpass

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

The CIA World Factbook's copyright information page
(L<http://www.cia.gov/cia/publications/factbook/docs/contributor_copyright.html>)
states:

  The Factbook is in the public domain. Accordingly, it may be copied
  freely without permission of the Central Intelligence Agency (CIA).


=head1 SEE ALSO

WWW::CIA, WWW::CIA::Parser, WWW::CIA::Source::DBM, WWW::CIA::Source::Web

=cut
