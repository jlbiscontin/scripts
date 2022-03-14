# Declare variables
:local host "TGIF-MADE-SRV";
:local dest "jlbiscontin@yahoo.com,ulisesthomasm@gmail.com";

# Actual code
/tool e-mail send start-tls=yes \
to=$dest subject="$host is up!" \
body="Great news! $host is back!\nRunning strong since $[/system clock get date] at $[/system clock get time] ;-)"
