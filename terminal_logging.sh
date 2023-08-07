###############################################
# Author: Aaron van Diepen
# Append a line in /etc/bash.bashrc to:
# Automatically log all terminal/SSH sessions
#
# Tested on and works with Ubuntu 20.04
###############################################

# Create the directory logs if not yet there
if [ ! -d "$HOME/logs" ]; then
    mkdir "$HOME/logs"
fi

# remove the lines if already appended
grep -v "Automatically" /etc/bash.bashrc > tmpfile && mv tmpfile /etc/bash.bashrc
grep -v "script" /etc/bash.bashrc > tmpfile && mv tmpfile /etc/bash.bashrc

# write comment to file
echo "# Automatically log all terminal/SSH sessions" >> /etc/bash.bashrc
# write command to file
echo "test \"\$(ps -ocommand= -p \$PPID | awk '{print \$1}')\" == 'script' || (script -t -f \$HOME/logs/\$(date +\"%d-%b-%y_%H-%M-%S\").\${HOSTNAME:-\$(hostname)}.\$\$.\${RANDOM}_shell.log)" >> /etc/bash.bashrc
