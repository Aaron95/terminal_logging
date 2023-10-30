###############################################
# Author: Aaron van Diepen
# Append a line in /etc/bash.bashrc to:
# Automatically log all terminal/SSH sessions
#
# Tested on and works with Ubuntu 20.04
###############################################

# Get a list of all user directories
user_directories=$(ls /home)

# Create a logs folder in each user directory
for directory in $user_directories; do
    mkdir -p "/home/$directory/logs"
done

# remove the lines if already appended
grep -v "Automatically" /etc/bash.bashrc > tmpfile && mv tmpfile /etc/bash.bashrc
grep -v "script" /etc/bash.bashrc > tmpfile && mv tmpfile /etc/bash.bashrc

# write comment to file
echo "# Automatically log all terminal/SSH sessions" >> /etc/bash.bashrc
# write command to file
echo "test \"\$(ps -ocommand= -p \$PPID | awk '{print \$1}')\" == 'script' || (script -f \$HOME/logs/\$(date +\"%d-%b-%y_%H-%M-%S\").\${HOSTNAME:-\$(hostname)}.\$\$.\${RANDOM}_shell.log)" >> /etc/bash.bashrc
