FROM ubuntu:16.04
MAINTAINER ARM <doug.anson@arm.com>
EXPOSE 22/tcp
EXPOSE 8081/tcp
RUN apt-get update
RUN apt-get -y install python-software-properties build-essential vim sudo curl net-tools
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN apt-get -y install openssh-server supervisor
RUN apt-get -y install nodejs git 
RUN useradd arm -m -s /bin/bash 
RUN mkdir -p /home/arm
RUN chown arm.arm /home/arm
COPY ssh-keys.tar /home/arm/
RUN chmod 755 /home/arm/ssh-keys.tar
COPY configure_instance.sh /home/arm/
COPY start_instance.sh /home/arm/
COPY update_hosts.sh /home/arm/
COPY run_blockchain_ui.sh /home/arm/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod 700 /home/arm/configure_instance.sh
RUN chmod 700 /home/arm/start_instance.sh
RUN chmod 700 /home/arm/update_hosts.sh
RUN chmod 700 /home/arm/run_blockchain_ui.sh
RUN /home/arm/configure_instance.sh
ENTRYPOINT [ "/home/arm/start_instance.sh" ]
