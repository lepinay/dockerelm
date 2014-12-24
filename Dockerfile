FROM ubuntu:14.04
MAINTAINER Lepinay Laurent, @foobarcode
#RUN  echo 'deb http://archive.ubuntu.com/ubuntu quantal main universe' > /etc/apt/sources.list
RUN  apt-get update
RUN  apt-get install -y haskell-platform git wget libncurses5-dev
RUN  cabal update
RUN cabal install cabal-install
RUN cabal install -j elm-compiler-0.14 elm-package-0.2 elm-make-0.1
RUN cabal install -j elm-repl-0.4 elm-reactor-0.2.0.1
RUN git config --global core.autocrlf true
RUN git clone https://github.com/elm-lang/elm-lang.org.git
WORKDIR elm-lang.org
RUN git checkout stable
ENV PATH /root/.cabal/bin:$PATH
RUN echo y | elm-package install
RUN cabal install --only-dependencies
RUN cabal configure
RUN cabal build
#RUN ./dist/build/run-elm-website/run-elm-website
