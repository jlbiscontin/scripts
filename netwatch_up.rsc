# Declare variables
:local host "SRV-xxx";
:local dest "yourname@yourdomain.com,yourname@yourdomain.com";

# Actual code
/tool e-mail send start-tls=yes \
to=$dest subject="$host is up!" \
body="Great news! $host is back!\nRunning strong since $[/system clock get date] at $[/system clock get time] ;-)"
