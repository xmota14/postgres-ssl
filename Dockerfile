FROM postgres:11
COPY ./script.sh /build/script.sh
RUN  sh /build/script.sh
