FROM imankulov/wordpress-ssh
#FROM tutum/wordpress

MAINTAINER Eric Vantillard <eric.vantillard@evaxion.fr>

ENV ROOT_PASSWORD changeit
ENV APPSECRET zdnye99m8ze3kmo

COPY install_dropbox_uploader.sh /install_dropbox_uploader.sh
COPY restore_apel_wordpress.sh /restore_apel_wordpress.sh
COPY run.sh /run.sh

RUN chmod +x /*.sh

COPY content.tar.gz /restore/content.tar.gz

RUN /install_dropbox_uploader.sh

EXPOSE 22 80 3306

CMD ["/run.sh"]