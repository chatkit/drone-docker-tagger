FROM docker:17.03.0-ce-dind

ADD drone-docker-tagger /bin/
ENTRYPOINT ["/usr/local/bin/dockerd-entrypoint.sh", "/bin/drone-docker-tagger"]
