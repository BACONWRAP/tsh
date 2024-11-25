#!/usr/bin/perl 
#!/usr/local/bin/perl 
use Getopt::Std;
# sanft added next two lines (source: https://stackoverflow.com/questions/46549671/doesnt-perl-include-current-directory-in-inc-by-default):
use FindBin 1.51 qw( $RealBin );
use lib $RealBin;
use config;

#########################################################################
# grade-shlab.pl - Shell lab autograder 
#
# Copyright (c) 2002, R. Bryant and D. O'Hallaron, All rights reserved.
# May not be used, modified, or copied without permission.
#
# This program develops an initial grade for a shell lab solution by 
# comparing its output to the output from a reference shell. The 
# comparison is not perfect, so the output needs to be checked by hand.
#
########################################################################

# autoflush output on every print statement
$| = 1; 

# Any tmp files created by this script are readable only by the user
umask(0077); 

#
# usage - print help message and terminate
#
sub usage {
    printf STDERR "$_[0]\n";
    printf STDERR "Usage: $0 [-h]\n";
    printf STDERR "Options:\n";
    printf STDERR "  -h          Print this message\n";
    die "\n";
}

##############
# Main routine
##############

# 
# Parse the command line arguments
#
getopts('hef:s:');
if ($opt_h) {
    usage();
}

# 
# Initialize various file and path names
#
$infile = "./tsh.c";                            # src file to test
($infile_basename = $infile) =~ s#.*/##s;    # basename of input file
$tmpdir = "/tmp/$infile_basename.$$";        # scratch directory
$0 =~ s#.*/##s;                              # $0 is this program's basename

# 
# This is a message we use in several places when the program dies
#
$diemsg = "The files are in $tmpdir.";

# 
# Make sure the src directory exists
#
(-d $SRCDIR and -e $SRCDIR) 
    or die "$0: ERROR: Can't access source directory $SRCDIR.\n";

# 
# Make sure the input file exists and is readable
#
open(INFILE, $infile) 
    or die "$0: ERROR: couldn't open file $infile\n";
close(INFILE);

# 
# Set up the contents of the scratch directory
#
system("mkdir $tmpdir") == 0
    or die "$0: ERROR: mkdir $tmpdir failed. $diemsg\n";
system("cp $infile $tmpdir/tsh.c") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp checktsh.pl $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp csapp.c $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp csapp.h $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/Makefile $tmpdir/Makefile") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/trace*.txt $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/tsh $tmpdir/tshref") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/sdriver.pl $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/myspin.c $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/mysplit.c $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/mystop.c $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";
system("cp $SRCDIR/myint.c $tmpdir") == 0
    or die "$0: ERROR: cp failed. $diemsg\n";

# Print header
print "\nCS:APP Shell Lab: Grading Sheet for $infile_basename\n\n";

#
# Compile the student's tsh.c file
#
print "\nPart 0: Compiling your shell\n\n";
system("(cd $tmpdir; make clean > /dev/null 2>&1)");
system("(cd $tmpdir; make)") == 0
    or die "$0: ERROR: $infile_basename did not compile. $diemsg\n";

#
# Run the autograder
#
print "\nPart 1: Correctness Tests\n\n";
print "This will take several minutes\n\n";
print "You can end individual tests with ctrl-c\n\n";

$score = 0;
foreach $tracefile (@TRACEFILES) {

    # If perfect match, than add in the points
    if (system("cd $tmpdir; ./checktsh.pl -e -t $tracefile") == 0) {
	$score += $POINTS;
    }
}

# Max correctness points is number of traces times points per trace
$maxcorrect = ($#TRACEFILES + 1) * $POINTS; 

print "\nPreliminary correctness score: $score / ", $maxcorrect, "\n"; 

print "\nPlus up to $MAXSTYLE points for style (good comments and checking the return value of every system call)\n";
print "\nTentative grade: ", $score+10, " / ", $maxcorrect+$MAXSTYLE, "\n";

print "\nBe sure to check for runaway tsh jobs and kill them.\n";
#
# Print the grade summary template that the instructor fills in
#

#print "\nPart 2: Score\n\n";


#print "Correctness:\t\t     / $maxcorrect\n\n";
#print "Style:      \t\t     / $MAXSTYLE\n\n";
#print "            \t\t__________\n\n";
#print "Total:      \t\t     / ", $maxcorrect+$MAXSTYLE, "\n";   

# 
# Print the original handin file 
#
# sanft change: don't include in student autograder
#if (!$opt_e) {
#  print "\f\nPart 3: Original $infile_basename file\n\n";
#  system("cat $infile");
#}

# Clean up and exit
system("rm -rf $tmpdir");
exit;


