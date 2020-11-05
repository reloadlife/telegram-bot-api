FROM alpine:3.7 as BUILD

WORKDIR /src
COPY . ./src/
RUN apk update
RUN apk upgrade
RUN apk add --update alpine-sdk linux-headers git zlib-dev openssl-dev gperf cmake
RUN mkdir build
RUN cd build
RUN export CXXFLAGS=""
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. ..
RUN cmake --build . --target install

FROM alpine:3.7 

WORKDIR /opt/telegram

COPY --from=build /src/bin/telegram-bot-api ./

CMD ["./telegram-bot-api", "--api-id=77119", "--api-hash=736683aa5bf8a5f92d149d3820fbe5a0", "-p 4444", "-s 5555"]

