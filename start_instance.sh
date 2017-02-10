#!/bin/bash

update_hosts()
{
    sudo /home/arm/update_hosts.sh
}

run_supervisord()
{
   /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf 2>&1 1>/tmp/supervisord.log
}

set_perms() {
  cd /home/arm
  chown -R arm.arm .
}

run_ui_monitor()
{
   cd /home/arm
   rm -rf /home/arm/monitor.log 2>&1 1 > /dev/null
   su -l arm -s /bin/bash -c "/home/arm/run_blockchain_ui.sh 2>&1 1> /home/arm/monitor.log &"
}

main() 
{
   update_hosts
   set_perms $*
   run_ui_monitor $*
   run_supervisord
}

main $*
