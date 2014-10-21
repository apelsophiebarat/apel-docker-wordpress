FROM tutum/wordpress
#FROM imankulov/wordpress-ssh
MAINTAINER Eric Vantillard <eric.vantillard@evaxion.fr>

EXPOSE 80 3306

ENV RESTORE_DATE 20140119_1205

ENV ROOT_PASSWORD foobar
ENV APPKEY u5q2rly67k9pp6e
ENV APPSECRET zdnye99m8ze3kmo

COPY content.tar.gz /restore/20140119_1205/content.tar.gz

COPY restore_wordpress_apel.sh /restore_wordpress_apel.sh
COPY run.sh /run.sh

RUN chmod +x /*.sh 

CMD ["/run.sh"]