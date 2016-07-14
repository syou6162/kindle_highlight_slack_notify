#!/usr/bin/env perl
use strict;
use warnings;
use Search::Elasticsearch;
use Encode;
use List::Util;

my $e = Search::Elasticsearch->new(
    nodes => [ 'localhost:9200', ]
);

my $results = $e->search(
    index => 'kindle',
    type => "highlight",
    body  => {
        size => 10000,
    }
);

my $highlights = [List::Util::shuffle @{$results->{hits}->{hits}}];
my $highlight = $highlights->[0]->{_source};

print encode_utf8 $highlight->{title}, "\n";
print encode_utf8 $highlight->{highlight}, "\n";
