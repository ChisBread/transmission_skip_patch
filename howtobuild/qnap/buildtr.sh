#cd ./TransmissionQPKG && docker run -it --rm -v ${PWD}:/my_project mrmoneyc/docker-qdk bash -c "cd /my_project; qbuild"
docker run -it --rm -v ${PWD}/TransmissionQPKG:/src dorowu/qdk2-build bash -c "cd /src && /usr/share/qdk2/QDK/bin/qbuild"
