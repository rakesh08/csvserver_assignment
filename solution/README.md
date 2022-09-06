1. Run the container image infracloudio/csvserver:latest failed with below file not found.

# docker run infracloudio/csvserver:latest          2022/09/06 06:56:45 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory

2. Write a bash script gencsv.sh to generate a file named inputFile. 

Below script will generate file with randomNumbers with index.

# cat gencsv.sh
ARG1=${1:-10}
for n in `seq $ARG1` ; do randomNumber=$(shuf -i 1-100 -n1) ; echo $n, $randomNumber >>  inputFile ; done

# cat inputFile
1, 48
2, 46
3, 97


3. Run the container again in the background with file generated. 

# docker run -d -v   /root/csvserver/csvserver/inputFile:/csvserver/inputdata  infracloudio/csvserver:latest
51b1f8d2efb5a418f4f209e0f4e85b7ac1436fd0314a260d372f9747dbc9aa83

4. Get shell access to the container and find the port on which the application is listening.

csvserver application is listening on port 9300.
# docker exec -it d9c22ef4a netstat -plant | grep -i listen
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver

5a. Run the container and make sure the application is accessible on the host at http://localhost:9393. 
# docker run -d -p 9393:9300  -v   /root/csvserver/csvserver/inputFile:/csvserver/inputdata  infracloudio/csvserver:latest

# nc -zv -w 1 localhost 9393
Connection to localhost 9393 port [tcp/*] succeeded!

# curl localhost:9393

5b.  Run the container and make sure to Set the environment variable CSVSERVER_BORDER to have value Orange.
# docker run -d -p 9393:9300 -e CSVSERVER_BORDER='orange'  -v   /root/csvserver/csvserver/inputFile:/csvserver/inputdata  infracloudio/csvserver:latest

