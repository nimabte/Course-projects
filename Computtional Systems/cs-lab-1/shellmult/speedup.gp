set term pngcairo enhanced font "Times,24" size 1200,800
set title "Shell Sort Algorithm"
set xlabel "Number of threads"
set ylabel "Speedup"
set output "speedup.png"
set key inside top left nobox
set label 1 "elements = 960000"
set label 1 at graph 0.00, 1.09  font " ,12"
set label 2 "runs = 10"
set label 2 at graph 0.00, 1.06  font " ,12"
set border lw 3
set grid lw 2.5
set pointsize 3.0

plot "speedup" using 1:2 \
     ti "speedup" \
     with lp lw 4 pt 2 lc rgb '#007BCC'
