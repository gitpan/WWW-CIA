package WWW::CIA;

require 5.005_62;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

sub new {

    my $proto = shift;
    my $opts = shift;
    my $class = ref($proto) || $proto;
    my $self = {};

    unless (exists $opts->{Source}) {
        croak("WWW::CIA: No source object specified");
    }
    $self->{SOURCE} = $opts->{Source};

    bless ($self, $class);
    return $self;

}

sub get {

    my $self = shift;
    my ($cc, $f) = @_;
    my $value = $self->source->value($cc, $f);
    return $value;

}

sub get_all_hashref {

    my $self = shift;
    my $country = shift;
    my $cc;
    my $data = {};
    foreach $cc (@$country) {
        $data->{$cc} = $self->source->all($cc);
    }
    return $data;

}

sub get_hashref {

    my $self = shift;
    my ($country, $field) = @_;
    my ($cc, $f);
    my $data = {};
    foreach $cc (@$country) {
         $data->{$cc} = {};
         foreach $f (@$field) {
             $data->{$cc}->{$f} = $self->source->value($cc, $f);
         }
    }
    return $data;

}

sub source {

    my $self = shift;
    return $self->{SOURCE};

}

1;

__END__

=head1 NAME

WWW::CIA - information from the CIA World Factbook.


=head1 SYNOPSIS

  use WWW::CIA;
  use WWW::CIA::Source::DBM;
  use WWW::CIA::Source::Web;

  # Get data from a pre-compiled DBM file

  my $source = WWW::CIA::Source::DBM->new({ DBM => "factbook.dbm" });
  my $cia = WWW::CIA->new({ Source => $source });
  $fact = $cia->get("uk", "Population");
  print $fact;

  # Get data direct from the CIA World Factbook

  my $source = WWW::CIA::Source::Web->new();
  my $cia = WWW::CIA->new({ Source => $source });
  $fact = $cia->get("uk", "Population");
  print $fact;


=head1 DESCRIPTION

A module which gets information from the CIA World Factbook.


=head1 METHODS

=over 4

=item C<new(\%opts)>

Creates a new WWW::CIA object. Takes a hashref, which must contain a "Source"
key whose value is a WWW::CIA::Storage object.


=item C<get($country_code, $field)>

This method retrieves information from the store.

It takes two arguments: a country code (as defined in FIPS 10-4 on
L<http://www.cia.gov/cia/publications/factbook/appendix/appendix-d.html>,
e.g. "uk", "us") and a field name (as defined in
L<http://www.cia.gov/cia/publications/factbook/docs/notesanddefs.html>,
e.g. "Population", "Agriculture - products"). (WWW::CIA::Parser also
creates four extra fields: "URL", "URL - Print", "URL - Flag", and "URL -
Map" which are the URLs of the country's Factbook page, the printable
version of that page, a GIF map of the country, and a GIF flag of the
country respectively.)

The field name is very case and punctuation sensitive.

It returns the value of the field, or C<undef> if the field or country isn't
in the store.

Note that when using WWW::CIA::Store::Web, C<get> will also return C<undef> if
there is an error getting the page.


=item C<get_hashref(\@countries, \@fields)>

This method takes two arguments: an arrayref of country codes and an arrayref
of field names.

It returns a hashref of the form

  {
   'country1' => {
                  'field1' => 'value',
                  'field2' => 'value'
                 },
   'country2' => {
                  'field1' => 'value',
                  'field2' => 'value'
                 }
  }

=item C<get_all_hashref(\@countries)>

Get all the fields available for countries.

It takes one argument, an arrayref of country codes.

It returns a hashref similar to the one from C<get_hashref> above,
containing all the fields available for each country.

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

WWW::CIA::Parser, WWW::CIA::Source::DBM, WWW::CIA::Source::Web


=cut
