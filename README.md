# Docker image for GEOS-Chem dry-run

See https://github.com/geoschem/geos-chem/pull/122

Build container:

    git clone https://github.com/JiaweiZhuang/gc-dryrun-docker.git
    cd gc-dryrun-docker/docker
    docker build -t gc-dryrun ./

`docker build` requires you to [pass AWS credentials to Docker container](https://stackoverflow.com/questions/36354423/which-is-the-best-way-to-pass-aws-credentials-to-docker-container). On EC2 this is set automatically.

Run container:

    docker run --rm gc-dryrun  # print to screen
    docker run --rm gc-dryrun > dryrun_docker.log  # print to file

    # run interactively to allow tweaking run-time configurations
    docker run --rm -it gc-dryrun bash
    ./geos --dry-run

## Reference
- https://github.com/geoschem/geos-chem-docker
