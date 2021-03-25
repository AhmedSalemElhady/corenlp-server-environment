FROM ubuntu:latest

ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
	apt-get install -y apt-utils \
		default-jdk \
		ant \
		unzip \
		wget \
		git


RUN export LATEST_VERSION="2018-10-05"; \
	wget http://nlp.stanford.edu/software/stanford-corenlp-full-${LATEST_VERSION}.zip; \
	unzip stanford-corenlp-full-${LATEST_VERSION}.zip; \
	mv stanford-corenlp-full-${LATEST_VERSION} CoreNLP; \
	rm stanford-corenlp-full-${LATEST_VERSION}.zip; \
	cd CoreNLP; \
	export CLASSPATH=""; for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done

ENV PORT 9000

EXPOSE 9000

WORKDIR CoreNLP

CMD ls 
CMD pwd
CMD java -cp '*' -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer


