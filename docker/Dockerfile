FROM geoschem/gc_env

ARG GC_VERSION='feature/dryrun'
ARG UT_VERSION=12.6.1

RUN mkdir -p /ExtData/HEMCO /ExtData/CHEM_INPUTS /OutputDir

WORKDIR /geoschem

RUN git clone https://github.com/jimmielin/geos-chem.git Code.GC-classic \
    && cd Code.GC-classic && git checkout $GC_VERSION

RUN git clone https://github.com/geoschem/geos-chem-unittest.git UT \
    && cd UT && git checkout $UT_VERSION \
    && sed -i -e 's#CODE_DIR    :=.*#CODE_DIR    :=/geoschem/Code.GC-classic#' runs/shared_inputs/Makefiles/Makefile \
    && cd perl \
    && sed -i -e 's#GCGRID_ROOT    :.*#GCGRID_ROOT    : /#' CopyRunDirs.input \
    && sed -i -e 's#DATA_ROOT      :.*#DATA_ROOT      : /ExtData#' CopyRunDirs.input \
    && sed -i -e 's#UNIT_TEST_ROOT :.*#UNIT_TEST_ROOT : /geoschem/UT#' CopyRunDirs.input \
    && sed -i -e 's#COPY_PATH      :.*#COPY_PATH      : /geoschem#' CopyRunDirs.input \
    && git add -A && git status -v \
    && ./gcCopyRunDirs \
    && rm -rf /geoschem/UT

WORKDIR /geoschem/geosfp_4x5_standard

RUN make -j4 build TIMERS=1

# get necessary input data
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir awscli

COPY ./CHEM_INPUTS.sh /geoschem/CHEM_INPUTS.sh
RUN /geoschem/CHEM_INPUTS.sh /ExtData/

COPY ./HEMCO_fix.sh /geoschem/HEMCO_fix.sh
RUN /geoschem/HEMCO_fix.sh /ExtData/

CMD ["./geos", "--dry-run"]
