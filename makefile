platform=macosx
arch=x86_64
avian_path=avian

ifdef openjdk
	openjdk_option=openjdk=${openjdk}
endif

.PHONY: default
default: build ;

.PHONY: clean
clean:
	rm -f *.o Hello.class boot.jar hello __.SYMDEF
	sh -c "cd avian ; make clean"

.PHONY: build
build: hello ;

.PHONY: run
run: build
	open hello

.PHONY: make_avian
make_avian:
	sh -c 'cd avian ; make platform=${platform} arch=${arch} ${openjdk_option}'

.PHONY: libavian_objects
libavian_objects: make_avian
	ar x ./${avian_path}/build/${platform}-${arch}/libavian.a

boot.jar: make_avian
	cp ./${avian_path}/build/${platform}-${arch}/classpath.jar boot.jar

Hello.class: boot.jar
	javac -bootclasspath boot.jar Hello.java

.PHONY: embded_hello_to_boot_jar
embded_hello_to_boot_jar: boot.jar Hello.class
	jar u0f boot.jar Hello.class

boot-jar.o: embded_hello_to_boot_jar
	./${avian_path}/build/${platform}-${arch}/binaryToObject/binaryToObject boot.jar boot-jar.o _binary_boot_jar_start _binary_boot_jar_end ${platform} ${arch}

main.o: boot-jar.o
	g++ -I"${JAVA_HOME}"/include -I"${JAVA_HOME}"/include/darwin -D_JNI_IMPLEMENTATION_ -c embedded-jar-main.cpp -o main.o

hello: main.o libavian_objects
	g++ -rdynamic *.o -ldl -lpthread -lz -o hello -framework CoreFoundation
