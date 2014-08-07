#!/usr/bin/env perl

=head1 NAME

B<litade> - B<LI>st input B<TA>xon's species-level B<DE>scendents 

=head1 INPUT

Taxon ids as arguments or from STDIN

=head1 OUTPUT

Two column, TAB-delimited file containing input ids mapped to output ids.

=cut

use strict;
use warnings;
use Cwd 'abs_path';

my @input = @{&get_input()};
my %taxdat = %{&get_taxdat()};

foreach my $taxid (@input){
    &descend($taxid, $taxid);
}

# Prints leaf nodes descending from input taxon
sub descend {
    my ($original, $current) = @_;
    if(exists $taxdat{$current}){
        while($taxdat{$current} =~ /(\d+)/g){
            &descend($original, $1);
        }
    } else {
        print "$original\t$current\n";
    }
}

# Get array of input taxon ids
sub get_input {
    if(scalar @ARGV > 0){
        return \@ARGV;
    } else {
        my @out = <STDIN>;
        return \@out;
    }
}

# Load taxonomy file
# Format:
# parent child1,child2,...,childk
sub get_taxdat {
    my $dir = abs_path($0);
    $dir =~ s/\/[^\/]+$//;

    open PARCHI, '<', $dir.'/parent-children.txt';

    my %taxdat = ();
    while(<PARCHI>) {
        chomp $_;
        my ($p, $c) = split ' ', $_;
        $taxdat{$p} = $c;
    }

    return \%taxdat;
}
