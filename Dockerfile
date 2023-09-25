FROM steamcmd/steamcmd AS steam

WORKDIR /scpsl
RUN steamcmd +force_install_dir /scpsl \
    +login anonymous \
    +app_update 996560 validate \
    +quit

FROM mono

ENV PORT=7777
ARG UID=999
ARG GID=999
ARG CONFIG=/config

USER root

RUN groupadd -g $GID scpsl && \
    useradd -m -s /bin/false -u $UID -g scpsl scpsl && \
    mkdir -p /scpsl $CONFIG "/home/scpsl/.config/SCP Secret Laboratory/config" && \
    ln -s $CONFIG "/home/scpsl/.config/SCP Secret Laboratory/config/$PORT" && \
    chown -R scpsl:scpsl /scpsl $CONFIG /home/scpsl/.config

COPY --chown=scpsl:scpsl --from=steam /scpsl /scpsl
COPY --chown=scpsl:scpsl ["localadmin_internal_data.json", "/home/scpsl/.config/SCP Secret Laboratory/config/"]

VOLUME $CONFIG
EXPOSE $PORT/udp

USER scpsl
WORKDIR /scpsl
ENTRYPOINT ["/bin/sh", "-c", "/scpsl/LocalAdmin $PORT"]
