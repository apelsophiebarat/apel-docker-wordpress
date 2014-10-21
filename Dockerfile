FROM imankulov/wordpress-ssh
#FROM tutum/wordpress

MAINTAINER Eric Vantillard <eric.vantillard@evaxion.fr>

ENV APPKEY changeit
ENV APPSECRET changeit
ENV OAUTH_ACCESS_TOKEN changeit
ENV OAUTH_ACCESS_TOKEN_SECRET changeit

ENV ROOT_PASSWORD changeit

COPY install_dropbox_uploader.sh /install_dropbox_uploader.sh
COPY restore_apel_wordpress.sh /restore_apel_wordpress.sh
COPY run.sh /run.sh

RUN chmod +x /*.sh

COPY content.tar.gz /restore/content.tar.gz

RUN /install_dropbox_uploader.sh

EXPOSE 22 80 3306

CMD ["/run.sh"]