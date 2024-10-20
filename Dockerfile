FROM ubuntu:latest
RUN apt update -y > /dev/null 2>&1 && apt upgrade -y > /dev/null 2>&1 && apt install locales -y \
&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
ARG Password
ARG re
ENV re=${re}
ENV Password=Yuiop890
RUN apt install ssh wget unzip -y > /dev/null 2>&1
RUN wget -O localtonet.zip https://localtonet.com/download/localtonet-linux-x64.zip > /dev/null 2>&1
RUN unzip localtonet.zip
RUN chmod +x localtonet
RUN mkdir /run/sshd
RUN echo '/usr/sbin/sshd -D' >>/1.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN echo root:Yuiop890|chpasswd
RUN service ssh start
RUN chmod 755 /1.sh
RUN echo "./localtonet authtoken JTpvCyHMtDFrLPh2uS54X9omGijRNazqs &&" >>/1.sh
EXPOSE 80 8888 8080 443 5130 5131 5132 5133 5134 5135 3306
CMD  /1.sh
