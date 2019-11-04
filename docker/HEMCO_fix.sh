#!/bin/bash

if [ "$1" ]; then
  DATA_ROOT=$1
else
  echo 'Must specify path to ExtData/ directory'
  exit 1
fi

# To fix https://github.com/geoschem/HEMCO/issues/3#issuecomment-546076956
aws s3 cp --request-payer=requester --recursive s3://gcgrid/HEMCO/PARANOX $DATA_ROOT/HEMCO/PARANOX

aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/LIGHTNOX/v2014-07/light_dist.ott2010.dat $DATA_ROOT/HEMCO/LIGHTNOX/v2014-07/

aws s3 cp --request-payer=requester s3://gcgrid/HEMCO/VOLCANO/v2019-08/2016/07/so2_volcanic_emissions_Carns.20160701.rc $DATA_ROOT/HEMCO/VOLCANO/v2019-08/2016/07/
