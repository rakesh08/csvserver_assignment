for n in `seq 10` ; do randomNumber=$(shuf -i 1-100 -n1) ; echo $n, $randomNumber >>  inputFile ; done
