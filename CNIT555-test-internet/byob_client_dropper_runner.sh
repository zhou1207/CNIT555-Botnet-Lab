#! /bin/bash

url="http://$1:$2/clients/droppers/client.py"
until curl -sHf "$url" -o client.py > /dev/null; do {
    echo "Game-client: server $1:$2 not ready, waiting..."
    sleep 1
}; done
echo "Game-client: server ready!"
python3 client.py &



# Made by RandomGuy
# Started on 16-2-2022 - completed on 18-2-2022



clear
# predefine
Version=1.0
# color
Clblack="\e[1;30m"
Clred="\e[1;31m"
Clgreen="\e[1;32m"
Clyellow="\e[1;33m"
Cldblue="\e[1;34m"
Clpurple="\e[1;35m"
Cllblue="\e[1;36m"
ClWhite="\e[1;37m"
Clnocl="\e[0m"
# assigning variable there position
x1="$Clblack \b1$ClWhite"
x2="$Clblack \b2$ClWhite"
x3="$Clblack \b3$ClWhite"
x4="$Clblack \b4$ClWhite"
x5="$Clblack \b5$ClWhite"
x6="$Clblack \b6$ClWhite"
x7="$Clblack \b7$ClWhite"
x8="$Clblack \b8$ClWhite"
x9="$Clblack \b9$ClWhite"
# random number
randomnum=$(( RANDOM % 10 ))




head_(){
	echo -e "$Clgreen Tick Tack Toe | V$Version $Clnocl"
	echo -e "$Clred [CTRL + c] Exit Game$Clnocl \n "
}
pause_(){
	echo  -n "Press any key to continue..."
	read -N 1 anything 
}
playing_area_(){
	clear
	head_
	echo -e "\n	$ClWhite $x1 | $x2 | $x3 \n	-----------\n	 $x4 | $x5 | $x6 \n	-----------\n	 $x7 | $x8 | $x9 "
}
player_turn_(){
	# check who wins
	who_wins_
	clear
	head_
	playing_area_
	# change title according to playing mode
	if [[ $playing_mode == 1 ]]; then
		echo -ne "$Cldblue\n\nYour turn ($player1)#~ $ClWhite"
	elif [[ $playing_mode == 2 ]]; then
		echo -ne "$Clpurple\n\nPlayer1 turn ($player1)#~ $ClWhite"
	fi
	read gameinput1 
	if [[ $gameinput1 == 1 ]]; then
		if [[ $x1 == $player1 ]] || [[ $x1 == $player2 ]]; then
			player_turn_
		else
			readonly x1="$player1"
		fi
	elif [[ $gameinput1 == 2 ]]; then
		if [[ $x2 == $player1 ]] || [[ $x2 == $player2 ]]; then
			player_turn_
		else
			readonly x2="$player1"
		fi
	elif [[ $gameinput1 == 3 ]]; then
		if [[ $x3 == $player1 ]] || [[ $x3 == $player2 ]]; then
			player_turn_
		else
			readonly x3="$player1"
		fi
	elif [[ $gameinput1 == 4 ]]; then
		if [[ $x4 == $player1 ]] || [[ $x4 == $player2 ]]; then
			player_turn_
		else
			readonly x4="$player1"
		fi
	elif [[ $gameinput1 == 5 ]]; then
		if [[ $x5 == $player1 ]] || [[ $x5 == $player2 ]]; then
			player_turn_
		else
			readonly x5="$player1"
		fi
	elif [[ $gameinput1 == 6 ]]; then
		if [[ $x6 == $player1 ]] || [[ $x6 == $player2 ]]; then
			player_turn_
		else
			readonly x6="$player1"
		fi
	elif [[ $gameinput1 == 7 ]]; then
		if [[ $x7 == $player1 ]] || [[ $x7 == $player2 ]]; then
			player_turn_
		else
			readonly x7="$player1"
		fi
	elif [[ $gameinput1 == 8 ]]; then
		if [[ $x8 == $player1 ]] || [[ $x8 == $player2 ]]; then
			player_turn_
		else
			readonly x8="$player1"
		fi
	elif [[ $gameinput1 == 9 ]]; then
		if [[ $x9 == $player1 ]] || [[ $x9 == $player2 ]]; then
			player_turn_
		else
			readonly x9="$player1"
		fi
	elif [[ $gameinput1 == [a-z] || $gameinput1 == [A-Z] ]]; then
		clear
		head_ && playing_area_
		echo -en "$Clred \n\nerr: Alphabets are not allowed$Clnocl" && sleep 1
		player_turn_
	elif [[ $gameinput1 == * ]]; then
		clear
		head_ && playing_area_
		echo -en "$Clred \n\nerr: Unknown input$Clnocl" && sleep 1
		player_turn_
	fi	
}
who_wins_(){
	if [[ $playing_mode == 1 ]]; then
		# if player is assigned with x then it's gonna be his/her victory
		if [[ $player1 == X ]]; then
			result1="$ClWhite \n\nYou win!\n"
		elif [[ $player2 == X ]]; then
			result1="$ClWhite \n\nBetter luck next time!\n"
		fi
		# if player is assigned with o then it's gonna be his/her victory
		if [[ $player1 == O ]]; then
			result2="$ClWhite \n\nYou win!\n"
		elif [[ $player2 == O ]]; then
			result2="$ClWhite \n\nBetter luck next time!\n"
		fi
	elif [[ $playing_mode == 2 ]]; then
		# if player1 is assigned with x then resut1 is going to print and if player2 is assigned with o then result2 is going to print 
		if [[ $player1 == X ]] && [[ $player2 == O ]]; then
			result1="$Clpurple \n\nplayer1 wins!\n"
			result2="$Cllblue \n\nplayer2 wins!\n"
		# Vice-versia above
		elif [[ $player2 == X ]] && [[ $player1 == O ]]; then
			result1="$Cllblue \n\nplayer2 wins!\n"
			result2="$Clpurple \n\nplayer1 wins!\n"
		fi
		
	fi
	if [[ $x1 == X ]] && [[ $x2 == X ]] && [[ $x3 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x1 == X ]] && [[ $x4 == X ]] && [[ $x7 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x1 == X ]] && [[ $x5 == X ]] && [[ $x9 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x5 == X ]] && [[ $x2 == X ]] && [[ $x8 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x6 == X ]] && [[ $x9 == X ]] && [[ $x3 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x7 == X ]] && [[ $x5 == X ]] && [[ $x3 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x4 == X ]] && [[ $x5 == X ]] && [[ $x6 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit
	elif [[ $x7 == X ]] && [[ $x8 == X ]] && [[ $x9 == X ]]; then
		sleep 0.6
		echo -e $result1
		pause_
		$0 && exit

	elif [[ $x1 == O ]] && [[ $x2 == O ]] && [[ $x3 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x1 == O ]] && [[ $x4 == O ]] && [[ $x7 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x1 == O ]] && [[ $x5 == O ]] && [[ $x9 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x5 == O ]] && [[ $x2 == O ]] && [[ $x8 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x6 == O ]] && [[ $x9 == O ]] && [[ $x3 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x7 == O ]] && [[ $x5 == O ]] && [[ $x3 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x7 == O ]] && [[ $x8 == O ]] && [[ $x9 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	elif [[ $x4 == O ]] && [[ $x5 == O ]] && [[ $x6 == O ]]; then
		sleep 0.6
		echo -e $result2
		pause_
		$0 && exit
	# if variable are not equal to there default values then game draw
	elif [[ $x1 != "$Clblack \b1$ClWhite" ]] && [[ $x2 != "$Clblack \b2$ClWhite" ]] && [[ $x3 != "$Clblack \b3$ClWhite" ]] && [[ $x4 != "$Clblack \b4$ClWhite" ]] && [[ $x5 != "$Clblack \b5$ClWhite" ]] && [[ $x6 != "$Clblack \b6$ClWhite" ]] && [[ $x7 != "$Clblack \b7$ClWhite" ]] && [[ $x8 != "$Clblack \b8$ClWhite" ]] && [[ $x9 != "$Clblack \b9$ClWhite" ]]; then
		sleep 0.6
		echo -e "\n\nMatch draw!\n"
		pause_
		$0 && exit
	fi
}
bot_turn_(){
	# check who wins
	who_wins_
	clear
	head_
	playing_area_
	echo -en "\n\nthinking..." && sleep 0.2
	randomnum=$(( RANDOM % 10 ))

	if [[ $randomnum == 0 ]]; then
		bot_turn_
	elif [[ $randomnum == 1 ]]; then
		if [[ $x1 == $player1 ]] || [[ $x1 == $player2 ]]; then
			bot_turn_
		else
			readonly x1=$player2
		fi
	elif [[ $randomnum == 2 ]]; then
		if [[ $x2 == $player1 ]] || [[ $x2 == $player2 ]]; then
			bot_turn_
		else
			readonly x2=$player2
		fi
	elif [[ $randomnum == 3 ]]; then
		if [[ $x3 == $player1 ]] || [[ $x3 == $player2 ]]; then
			bot_turn_
		else
			readonly x3=$player2
		fi
	elif [[ $randomnum == 4 ]]; then
		if [[ $x4 == $player1 ]] || [[ $x4 == $player2 ]]; then
			bot_turn_
		else
			readonly x4=$player2
		fi
	elif [[ $randomnum == 5 ]]; then
		if [[ $x5 == $player1 ]] || [[ $x5 == $player2 ]]; then
			bot_turn_
		else
			readonly x5=$player2
		fi
	elif [[ $randomnum == 6 ]]; then
		if [[ $x6 == $player1 ]] || [[ $x6 == $player2 ]]; then
			bot_turn_
		else
			readonly x6=$player2
		fi
	elif [[ $randomnum == 7 ]]; then
		if [[ $x7 == $player1 ]] || [[ $x7 == $player2 ]]; then
			bot_turn_
		else
			readonly x7=$player2
		fi
	elif [[ $randomnum == 8 ]]; then
		if [[ $x8 == $player1 ]] || [[ $x8 == $player2 ]]; then
			bot_turn_
		else
			readonly x8=$player2
		fi
	elif [[ $randomnum == 9 ]]; then
		if [[ $x9 == $player1 ]] || [[ $x9 == $player2 ]]; then
			bot_turn_
		else
			readonly x9=$player2
		fi
	fi
}
player2_turn_(){
	# check who wins
	who_wins_
	clear
	head_
	playing_area_
	# change title according to playing mode
	if [[ $playing_mode == 1 ]]; then
		echo -ne "$Cldblue\n\nInput#~ $ClWhite"
	elif [[ $playing_mode == 2 ]]; then
		echo -ne "$Cllblue\n\nPlayer2 turn ($player2)#~ $ClWhite"
	fi
	read gameinput1 
	if [[ $gameinput1 == 1 ]]; then
		if [[ $x1 == $player1 ]] || [[ $x1 == $player2 ]]; then
			player2_turn_
		fi
		readonly x1="$player2"
	elif [[ $gameinput1 == 2 ]]; then
		if [[ $x2 == $player1 ]] || [[ $x2 == $player2 ]]; then
			player2_turn_
		fi
		readonly x2="$player2"
	elif [[ $gameinput1 == 3 ]]; then
		if [[ $x3 == $player1 ]] || [[ $x3 == $player2 ]]; then
			player2_turn_
		fi
		readonly x3="$player2"
	elif [[ $gameinput1 == 4 ]]; then
		if [[ $x4 == $player1 ]] || [[ $x4 == $player2 ]]; then
			player2_turn_
		fi
		readonly x4="$player2"
	elif [[ $gameinput1 == 5 ]]; then
		if [[ $x5 == $player1 ]] || [[ $x5 == $player2 ]]; then
			player2_turn_
		fi
		readonly x5="$player2"
	elif [[ $gameinput1 == 6 ]]; then
		if [[ $x6 == $player1 ]] || [[ $x6 == $player2 ]]; then
			player2_turn_
		fi
		readonly x6="$player2"
	elif [[ $gameinput1 == 7 ]]; then
		if [[ $x7 == $player1 ]] || [[ $x7 == $player2 ]]; then
			player2_turn_
		fi
		readonly x7="$player2"
	elif [[ $gameinput1 == 8 ]]; then
		if [[ $x8 == $player1 ]] || [[ $x8 == $player2 ]]; then
			player2_turn_
		fi
		readonly x8="$player2"
	elif [[ $gameinput1 == 9 ]]; then
		if [[ $x9 == $player1 ]] || [[ $x9 == $player2 ]]; then
			player2_turn_
		fi
		readonly x9="$player2"
	elif [[ $gameinput1 == [a-z] || $gameinput1 == [A-Z] ]]; then
		clear
		head_ && playing_area_
		echo -en "$Clred \n\nerr: Alphabets are not allowed$Clnocl" && sleep 1
		player2_turn_
	elif [[ $gameinput1 == * ]]; then
		clear
		head_ && playing_area_
		echo -en "$Clred \n\nerr: Unknown input$Clnocl" && sleep 1
		player2_turn_
	fi	
}



# predifine player values
if [[ $1 == "-x" ]]; then
	if [[ $2 == "x" || $2 == "X" ]]; then
		player1="X"
		player2="O"
	elif [[ $2 == "o" || $2 == "O" ]]; then
		player1="O"
		player2="X"
	else
		player1="X"
		player2="O"
	fi
	head_
	echo -e "$ClWhite Player1 is assigned with $player1 $Clnocl" && sleep 1
elif [[ $randomnum == 0 ]] || [[ $randomnum == 1 ]] || [[ $randomnum == 2 ]] || [[ $randomnum == 3 ]] || [[ $randomnum == 4 ]]; then
	player1="X"
	player2="O"
else
	player1="O"
	player2="X"
fi

# scenerio one
clear
head_
echo -e "$Clyellow     ---Choose option---\n
     1- Play with Bot.
     2- Play multiplayer.\n$Clnocl"
echo -ne "$Cldblue \bInput#~ $ClWhite"
read input1

if [[ $input1 == 1 ]]; then	
	# Playing page
	playing_mode=1
	playing_area_
	# choose random turn
	if [[ $randomnum == 0 ]] || [[ $randomnum == 1 ]] || [[ $randomnum == 2 ]] || [[ $randomnum == 3 ]] || [[ $randomnum == 4 ]]; then
		random_player1=player_turn_
		random_player3=bot_turn_
	else
		random_player1=bot_turn_
		random_player3=player_turn_
	fi
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_
	$random_player1 && playing_area_ && $random_player3 && playing_area_

elif [[ $input1 == 2 ]]; then
	#playing page
	playing_mode=2
	playing_area_
	# choose random turn
	if [[ $randomnum == 0 ]] || [[ $randomnum == 1 ]] || [[ $randomnum == 2 ]] || [[ $randomnum == 3 ]] || [[ $randomnum == 4 ]]; then
		random_player1=player_turn_
		random_player2=player2_turn_
	else
		random_player1=player2_turn_
		random_player2=player_turn_
	fi

	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
	$random_player1 && playing_area_ && $random_player2 && playing_area_
else
	clear
	head_
	echo -e "$Clred ¯\_(ツ)_/¯$Clnocl\n"
	pause_
	$0
fi	
