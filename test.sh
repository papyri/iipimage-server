#!/bin/bash -eu

cid=$(docker run --rm -d ${build_tag:-iipimage-server})

code=1
interval=5
timeout=60

SECONDS=0
while [[ $SECONDS -lt $timeout ]]; do
    echo -n "Checking health status ... "
    status=$(docker inspect -f '{{.State.Health.Status}}' $cid)
    echo $status

    case $status in
        healthy)
	    code=0
            break
            ;;
        unhealthy)
            break
            ;;
        starting)
            sleep $interval
            ;;
        *)
            echo "Unexpected status."
            break
            ;;
    esac
done

echo "Cleaning up ..."
docker stop $cid

if [[ $code -eq 0 ]]; then
    echo "SUCCESS"
else
    echo "FAILURE"
fi

exit $code
