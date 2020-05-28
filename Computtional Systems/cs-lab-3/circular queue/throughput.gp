set term pngcairo enhanced font "Times,24" size 1200,800
set title "Concurrent Single-ended Queue"
set xlabel "Number of threads"
set ylabel "Throughput"
set output "throughput.png"
set key inside top right nobox
set label 1 "runs = 10"
set label 1 at graph 0.00, 1.09  font " ,12"
set label 2 "nopers = 4000000 per thread"
set label 2 at graph 0.00, 1.06  font " ,12"
set border lw 3
set grid lw 2.5
set pointsize 3.0

#plot "throughput" using 1:2 \
 #    ti "speedup" \
  #   with lp lw 4 pt 2 lc rgb '#007BCC'
plot "throughput-spin-mutex" using 2 title 'Mutex   ' with lp lw 4 pt 3 lc rgb '#CC1133', \
     "throughput-spin-mutex" using 3 title 'Spinlock' with lp lw 4 pt 2 lc rgb '#007BCC', \
   #  "throughput" using 4 title 'Modified' with lines
