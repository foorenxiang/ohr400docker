docker build --tag foorenxiang/ohr400backend . \
&& docker container prune -f \
&& docker run -ti --name ohr400backendInstance --rm foorenxiang/ohr400backend bash
