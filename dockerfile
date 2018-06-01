#选择基础镜像openjdk
FROM openjdk

#指定外部文件夹挂载到容器内的/tmp文件夹
#We added a VOLUME pointing to "/tmp" because that is where a Spring Boot application creates working directories 
#for Tomcat by default. The effect is to create a temporary file on your host under "/var/lib/docker" 
#and link it to the container under "/tmp". This step is optional for the simple app that we wrote here, 
#but can be necessary for other Spring Boot applications if they need to actually write in the filesystem.
VOLUME /tmp

#设置参数名为JAR_FILE，在build镜像时可以使用--build-arg<varname>=<value>来指定参数值，本次将打包好的项目文件为变量值
ARG JAR_FILE

#将${JAR_FILE}文件，即打包好的项目文件，复制为镜像中的app.jar文件
ADD ${JAR_FILE} app.jar

#在镜像中运行指定的指令
RUN bash -c 'touch /app.jar'

#暴露端口8800
EXPOSE 8800

#设置启动时的默认命令java -Djava.security.egd=file:/dev/./urandom -jar /app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]