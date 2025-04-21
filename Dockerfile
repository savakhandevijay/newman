FROM postman/newman:latest

RUN cd /etc/newman && npm install -g newman-reporter-html newman-reporter-htmlextra newman-reporter-htmlextra-extended newman-reporter-csv