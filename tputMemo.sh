#!/bin/sh

tput flash
tput clear

#Terminal info
##############
echo "Getting terminal info"
echo "Terminal width is: $(tput cols)"
echo "Terminal height is: $(tput lines)"
sleep 10

tput flash
tput clear

#Text effects
#############
echo "Text effects"
echo normal
echo $(tput blink)blink$(tput sgr0)
echo $(tput bold)bold$(tput sgr0)
echo $(tput dim)half intensity$(tput sgr0)
echo $(tput rev)reverse video$(tput sgr0)
echo $(tput smso)soft reverse video$(tput rmso)
echo $(tput smul)underlined$(tput rmul)
sleep 10

tput flash
tput clear

#Cursor fonctionalities
#######################
#Centered text
tput sc #Save character position
centerX=$(( $(tput cols) / 2 ))
centerY=$(( $(tput lines) / 2 ))
centeredText="CENTERED TEXT"
tput cup $centerY $(( $centerX - $(( ${#centeredText} / 2 )) ))
echo "$centeredText"
tput rc #Restore character position

sleep 5

tput flash
tput clear

echo $(tput civis)turn off the cursor 5 seconds
sleep 5
echo $(tput cnorm)turn on the cursor again
sleep 5

tput flash
tput clear

#Move cursor on the screen
direction="left2Right"
moveHorizontally='tput cuf 1'
moveVertically='tput cud 1'
for sequenceNumber in 1 2
do
  for lineIndex in $(seq 0 $(( $(tput lines) - 1 )) )
  do

    for culumnIndex in $(seq 0 $(( $(tput cols) - 1 )) )
    do
      $moveHorizontally
    done

    #Change direction
    if [ "$direction" == "left2Right" ]
    then
      #Move 1 character to the right
      moveHorizontally='tput cub 1'
      direction="right2Left"
    else
      moveHorizontally='tput cuf 1'
      direction="left2Right"
    fi

    #Move to the bottom
    $moveVertically
  done
  moveVertically='tput cuu 1'
done
