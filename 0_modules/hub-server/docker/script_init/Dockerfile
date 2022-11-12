FROM ubuntu:20.04
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
# Set the working directory to /usr/src/app
WORKDIR /usr/src/app
# Copy the current directory contents into the container at /usr/src/app
COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt
COPY checkScript.py checkScript.py
ENTRYPOINT [ "python3" ]
CMD [ "checkScript.py" ]