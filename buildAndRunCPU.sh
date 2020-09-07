# docker build --tag foorenxiang/ohr400backendcpu . \
# && docker container prune -f \
# && docker run -ti --name ohr400backendCPUInstance --rm \
#  -p 81:80 \
#  -p 3000:3000 \
#  -p 5001:5001 \
#  -p 6001:6001 \
#  -p 6002:6002 \
#  foorenxiang/ohr400backendcpu bash


docker build --tag foorenxiang/ohr400backendcpu . \
&& docker container prune -f \
&& docker run -ti --name ohr400backendCPUInstance \
 -p 81:80 \
 -p 3000:3000 \
 -p 5001:5001 \
 -p 6001:6001 \
 -p 6002:6002 \
 --volume ~/code/OHR400Dashboard:/home/foorx/Sites/OHR400Dashboard \
 foorenxiang/ohr400backendcpu bash

 # docker exec -ti ohr400backendCPUInstance bash
