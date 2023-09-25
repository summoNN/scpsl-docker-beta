FROM steamcmd/steamcmd AS steam

WORKDIR /scpsl
RUN steamcmd +force_install_dir /scpsl \
    +login anonymous \
    +app_update 996560 validate \
    +quit

FROM mono

ARG UID=999
ARG GID=999

USER root

RUN groupadd -g $GID scpsl && \
    useradd -m -s /bin/false -u $UID -g scpsl scpsl && \
    mkdir -p /scpsl /config "/home/scpsl/.config/SCP Secret Laboratory/config" && \
    ln -s /config "/home/scpsl/.config/SCP Secret Laboratory/config/7777" && \
    chown -R scpsl:scpsl /scpsl /config /home/scpsl

COPY --chown=scpsl:scpsl --from=steam /scpsl /scpsl
COPY --chown=scpsl:scpsl ["localadmin_internal_data.json", "/home/scpsl/.config/SCP Secret Laboratory/config/"]

VOLUME /config
EXPOSE 7777/udp

USER scpsl
WORKDIR /scpsl
ENTRYPOINT ["/scpsl/LocalAdmin", "7777"]
