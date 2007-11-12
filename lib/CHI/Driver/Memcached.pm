package CHI::Driver::Memcached;
use strict;
use warnings;
use Cache::Memcached;
use CHI::Util;
use base qw(CHI::Driver::Base::CacheContainer);

__PACKAGE__->mk_ro_accessors(
    qw(compress_threshold debug memd no_rehash servers));

sub new {
    my $class = shift;
    my $self  = $class->SUPER::new(@_);

    my %mc_params =
      ( map { exists( $self->{$_} ) ? ( $_, $self->{$_} ) : () }
          qw(compress_threshold debug namespace no_rehash servers) );
    $self->{_contained_cache} = $self->{memd} =
      Cache::Memcached->new( \%mc_params );

    return $self;
}

sub get_keys {
    die "get_keys not supported for this driver";
}

sub get_namespaces {
    die "get_namespaces not supported for this driver";
}

1;

__END__

=pod

=head1 NAME

CHI::Driver::Memcached -- Distributed cache via memcached (memory cache daemon)

=head1 SYNOPSIS

    use CHI;

    my $cache = CHI->new(
        driver => 'Memcached',
        servers => [ "10.0.0.15:11211", "10.0.0.15:11212", "/var/sock/memcached",
        "10.0.0.17:11211", [ "10.0.0.17:11211", 3 ] ],
        debug => 0,
        compress_threshold => 10_000,
    );

=head1 DESCRIPTION

This cache driver uses Cache::Memcached to store data in the specified memcached server(s).

=head1 CONSTRUCTOR OPTIONS

=over

=item cache_size
=item page_size
=item num_pages
=item init_file

These options are passed directly to L<Cache::Memcached>.

=back

=head1 SEE ALSO

Cache::Memcached
CHI

=head1 AUTHOR

Jonathan Swartz

=head1 COPYRIGHT & LICENSE

Copyright (C) 2007 Jonathan Swartz, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
