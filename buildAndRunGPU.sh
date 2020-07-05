docker build --tag foorenxiang/ohr400backendgpu . \
&& docker container prune -f \
&& docker run -ti --name ohr400backendGPUInstance --rm \
 -p 81:80 \
 -p 3000:3000 \
 -p 5001:5001 \
 -p 6001:6001 \
 -p 6002:6002 \
 --gpus all foorenxiang/ohr400backendgpu bash
# && docker run -ti --name ohr400backend --rm --volume ~/dockermountUbuntu:/home/foorx/ foorenxiang/ohr400backend bash
