FROM integralsw/osa-python

ADD $REPO_PATH/requirements.txt /requirements.txt
RUN mkdir -pv /home/oda; export HOME_OVERRRIDE=/home/oda; source /init.sh;  \
    pip install --upgrade pip; \
    pip install -r /requirements.txt

ADD ./ /repo
RUN useradd -ms /bin/bash oda; chown oda:oda /repo

#USER oda
WORKDIR /workdir

