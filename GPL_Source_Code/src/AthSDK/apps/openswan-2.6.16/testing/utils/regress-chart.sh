#!/bin/sh

# $Id: regress-chart.sh,v 1.1 2008/10/01 03:43:23 ken_chiang Exp $
#
# this script produces a graph of FreeSWAN regression testing status
#
# note that this timefmt requires gnuplot 3.7.2+
# see http://www.sourceforge.net/projects/gnuplot
#

tree=$1

cd $tree || exit 1

cat */*/stats.txt | sort -n >regressstats.txt
gnuplot <<EOF
set terminal png
set output 'regressgraph.png'
set timefmt '%s'
set xdata time
set yrange [0:400]
plot 'regressstats.txt' using 1:2 title "total" with linespoints , 'regressstats.txt' using 1:3 title "passing" with points, 'regressstats.txt' using 1:4 title "failing" with linespoints, 'regressstats.txt' using 1:5 title "missing" with linespoints
EOF

