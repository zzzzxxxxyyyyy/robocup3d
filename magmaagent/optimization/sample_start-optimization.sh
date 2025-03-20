#!/bin/bash

# Choose which optimization task to run
task="walk" # "walk""kick""kickwalk""walkStable"

# This script runs the simspark soccer simulator and an agent 

# Set the agent and monitor port randomly, to allow for multiple agents per machine
# Note: $RANDOM returns a value from 0 to 32767, ports <= 1024 are reserved for root 
# TODO: Instead of picking random ports purposely bind to available ports
export SPARK_SERVERPORT=$[3200] #3200
export SPARK_AGENTPORT=$[3100] #3100

echo -n "It is: "
date
echo -n "and I am on: "
hostname
echo "Agent port: $SPARK_AGENTPORT, Monitor port: $SPARK_SERVERPORT"

rcssserver3d --agent-port $SPARK_AGENTPORT --server-port $SPARK_SERVERPORT &
PID=$!

#To view task while it runs uncomment the following line
#<roboviz_start_script> --serverPort=$SPARK_SERVERPORT &

sleep 2
DIR_SCRIPT="$( cd "$( dirname "$0" )" && pwd )" 
TYPE=$1
DIR_PARAMS="$( cd "$( dirname "$2" )" && pwd )"
DIR_OUTPUT="$( cd "$( dirname "$3" )" && pwd )"
PARAMS_FILE=$DIR_PARAMS/$(basename $2)
OUTPUT_FILE=$DIR_OUTPUT/$(basename $3)
OUTPUT_PATH="/home/d3d3d/magmaRelease-main-zzj/magmaagent/target/magmaagent/optimization/"
OUTPUT_PATHNOW=$OUTPUT_PATH

# TODO: temporary fix!! get rid of it - because relative path dependency of skills
cd $DIR_SCRIPT/..
export LD_LIBRARY_PATH=./libs:$LD_LIBRARY_PATH




AGENTPID=$!




if [ $task == "kick" ]
then
  times=6
    for((kick_time=0;kick_time<$times;kick_time++))
    do
      OUTPUT_PATHNOW=$OUTPUT_PATH/outx.txt
                  # FixedKick optimization task
                  mkdir -p log
                  today=`date +%Y-%m-%d-%H-%M-%S`o

                    java -cp "lib/*" magma.robots.RoboCupClient --teamname=releaseTeam --playerid=8 --factory=NaoToe --decisionmaker=2 --server=192.168.75.134 1>log/outAndError$today.log 2>&1 &
                    sleep 2


                    xdotool search --name "localhost:3200 - RoboViz 1.8.2" windowactivate
                    xdotool key o
                    xdotool key p

                    xdotool key Return
                    xdotool key --clearmodifiers Shift+t

                    maxWaitTimeSecs=15
                    total_wait_time=0

                    while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                    do
                      sleep 1
                      total_wait_time=`expr $total_wait_time + 1`
                    done
                    OUTPUT_PATHNOW=$OUTPUT_PATH/outx.txt
                    if [ -f $OUTPUT_PATHNOW ]
                    then
                      echo "Timed out while waiting for script to complete, current wait time is $total_wait_time seconds."
                    else
                      echo "Completed with a wait time of $total_wait_time seconds."
                      let kick_time=times
                    fi

                    echo "Killing Agent"
                    bash kill.sh
                    xdotool search --name "localhost:3200 - RoboViz 1.8.2" windowactivate
                    if [ $kick_time > 2 ]
                    then
                      if [ ! -f $OUTPUT_FILE ]
                          then
                            echo "the file exit"
                          else
                            echo "the file deosnt exit"
                            let kick_time=times
                          fi
                    fi
                    sleep 1
                    xdotool key o
                    xdotool key Return
                    echo "Finished"

    done
    OUTPUT_PATHNOW=$OUTPUT_PATH/outx.txt
    rm -f $OUTPUT_PATHNOW
fi




if [ $task == "walk" ]
then

  # WalkForward optimization task
  mkdir -p log
  today=`date +%Y-%m-%d-%H-%M-%S`

  sleep 3
    java -cp "lib/*" magma.robots.RoboCupClient --teamname=releaseTeam --playerid=1 --factory=NaoToe --decisionmaker=1 --server=192.168.75.134 1>log/outAndError$today.log 2>&1 &

        times=5
        maxWaitTimeSecs=15
        total_wait_time=0
          for((test_time=0;test_time<$times;test_time++))
          do
              if [ $test_time -eq 0 ]
                then
                      let maxWaitTimeSecs=15
                      let total_wait_time=0
                      OUTPUT_PATHNOW=$OUTPUT_PATH/outx1.txt
                      while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                do
                                sleep 1
                                total_wait_time=`expr $total_wait_time + 1`

                                if [ -f $OUTPUT_PATHNOW ]
                                    then
                                    echo "the filex1 exit"
                                    let total_wait_time=$maxWaitTimeSecs
                                    fi
                                done
                      if [ -f $OUTPUT_PATHNOW ]
                      then
                               echo "the filex1 exit"
                      else
                               echo "the filex1 deosnt exit"
                               let test_time=5
                      fi

              fi


              if [ $test_time -eq 1 ]
                then
                      let maxWaitTimeSecs=20
                      let total_wait_time=0
                      OUTPUT_PATHNOW=$OUTPUT_PATH/outx.txt
                      while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                do
                                sleep 1
                                total_wait_time=`expr $total_wait_time + 1`

                                if [ -f $OUTPUT_PATHNOW ]
                                    then
                                    echo "the filex exit"
                                    let total_wait_time=$maxWaitTimeSecs
                                    fi
                                done
                      if [ -f $OUTPUT_PATHNOW ]
                      then
                               echo "the filx exit"
                      else
                               echo "the filex deosnt exit"
                               let test_time=5
                      fi

              fi


            if [ $test_time == 2 ]
            then
                      let maxWaitTimeSecs=25
                      let total_wait_time=0
                      OUTPUT_PATHNOW=$OUTPUT_PATH/outy.txt
                      while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                          do
                          sleep 1
                          total_wait_time=`expr $total_wait_time + 1`
                          if [ -f $OUTPUT_PATHNOW ]
                              then
                              echo "the filey exit"
                              let total_wait_time=$maxWaitTimeSecs
                              fi
                          done
                      if [ -f $OUTPUT_PATHNOW ]
                               then
                               echo "the fily exit"
                               else
                               echo "the filey deosnt exit"
                               let test_time=5
                      fi
            fi


            if [ $test_time == 3 ]
            then
                           let maxWaitTimeSecs=30
                           let total_wait_time=0
                          OUTPUT_PATHNOW=$OUTPUT_PATH/outz.txt
                           while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                               do
                               sleep 1
                               total_wait_time=`expr $total_wait_time + 1`
                               if [ -f $OUTPUT_PATHNOW ]
                                   then
                                   echo "the filex exit"
                                   let total_wait_time=$maxWaitTimeSecs
                                   fi
                               done
                           if [ -f $OUTPUT_PATHNOW ]
                                    then
                                    echo "the filz exit"
                                    else
                                    echo "the filez deosnt exit"
                                    let test_time=5
                           fi
            fi


            if [ $test_time == 4 ]
                  then
                         let maxWaitTimeSecs=30
                         let total_wait_time=0
                        OUTPUT_PATHNOW=$OUTPUT_PATH/out.txt
                                 while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                     do
                                     sleep 1
                                     total_wait_time=`expr $total_wait_time + 1`
                                     if [ -f $OUTPUT_PATHNOW ]
                                         then
                                         echo "the file exit"
                                         let total_wait_time=$maxWaitTimeSecs
                                         fi
                                     done
                                 if [ -f OUTPUT_PATHNOW ]
                                          then
                                          echo "the file exit"
                                          else
                                          echo "the file deosnt exit"
                                          let test_time=5
                                 fi
            fi


          done
    echo "finished"
         rm -f $OUTPUT_PATH/outx1.txt
     rm -f $OUTPUT_PATH/outx.txt
      rm -f $OUTPUT_PATH/outy.txt
       rm -f $OUTPUT_PATH/outz.txt
  echo "Killing Agent"
  bash kill.sh 1

fi






if [ $task == "kickwalk" ]
then
    maxWaitTimeSecs=15
    total_wait_time=0

OUTPUT_PATHNOW=$OUTPUT_PATH/out.txt
          while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                    do
                    sleep 1
                    total_wait_time=`expr $total_wait_time + 1`

                    if [ -f $OUTPUT_PATHNOW ]
                        then
                        echo "the file exit"
                        let total_wait_time=$maxWaitTimeSecs
                        fi
                    done
          if [ -f $OUTPUT_PATHNOW ]
          then
                   echo "the file exit"
          else
                   echo "the file deosnt exit"
          fi

fi

if [ $task == "walkStable" ]
then

  # WalkForward optimization task
  mkdir -p log
  today=`date +%Y-%m-%d-%H-%M-%S`

  sleep 3
    java -cp "lib/*" magma.robots.RoboCupClient --teamname=releaseTeam --playerid=1 --factory=NaoToe --decisionmaker=6 --server=192.168.75.134 1>log/outAndError$today.log 2>&1 &

        times=3
        maxWaitTimeSecs=20
        total_wait_time=0
          for((test_time=0;test_time<$times;test_time++))
          do
              if [ $test_time -eq 0 ]
                then
                      let maxWaitTimeSecs=25
                      let total_wait_time=0
                      OUTPUT_PATHNOW=$OUTPUT_PATH/outx1.txt
                      while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                do
                                sleep 1
                                total_wait_time=`expr $total_wait_time + 1`

                                if [ -f $OUTPUT_PATHNOW ]
                                    then
                                    echo "the filex1 exit"
                                    let total_wait_time=$maxWaitTimeSecs
                                    fi
                                done
                      if [ -f $OUTPUT_PATHNOW ]
                      then
                               echo "the filex1 exit"
                      else
                               echo "the filex1 deosnt exit"
                               let test_time=times
                      fi

              fi


              if [ $test_time -eq 1 ]
                then
                      let maxWaitTimeSecs=30
                      let total_wait_time=0
                      OUTPUT_PATHNOW=$OUTPUT_PATH/outx.txt
                      while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                do
                                sleep 1
                                total_wait_time=`expr $total_wait_time + 1`

                                if [ -f $OUTPUT_PATHNOW ]
                                    then
                                    echo "the filex exit"
                                    let total_wait_time=$maxWaitTimeSecs
                                    fi
                                done
                      if [ -f $OUTPUT_PATHNOW ]
                      then
                               echo "the filx exit"
                      else
                               echo "the filex deosnt exit"
                               let test_time=times
                      fi

              fi

            if [ $test_time == 2 ]
                  then
                         let maxWaitTimeSecs=30
                         let total_wait_time=0
                        OUTPUT_PATHNOW=$OUTPUT_PATH/out.txt
                                 while  [ $total_wait_time -lt $maxWaitTimeSecs ]
                                     do
                                     sleep 1
                                     total_wait_time=`expr $total_wait_time + 1`
                                     if [ -f $OUTPUT_PATHNOW ]
                                         then
                                         echo "the file out exit"
                                         let total_wait_time=$maxWaitTimeSecs
                                         fi
                                     done
                                 if [ -f OUTPUT_PATHNOW ]
                                          then
                                          echo "the file out exit!"
                                          else
                                          echo "the file deosnt exit"
                                          let test_time=times
                                 fi
            fi


          done
    echo "finished"
         rm -f $OUTPUT_PATH/outx1.txt
     rm -f $OUTPUT_PATH/outx.txt
  echo "Killing Agent"
  bash kill.sh 1

fi
