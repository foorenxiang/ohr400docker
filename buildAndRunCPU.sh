docker build --tag foorenxiang/ohr400backendcpu . \
&& docker container prune -f \
&& docker run -ti --name ohr400backendCPUInstance --rm foorenxiang/ohr400backendcpu bash
