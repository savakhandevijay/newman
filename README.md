# Newman
Newman API testing tool 
## Step to setup and install
- docker engine must be installed
- go to dockerfile folder
- build newman docker image using below command `docker build -t newman:staging -f Dockerfile . --build-arg NEWMAN_VERSION="full semver version"`;
- we have added support for HTML & CSV extension
- Check the newman run options [ref](https://learning.postman.com/docs/collections/using-newman-cli/newman-options/)
- docker newman artifacts makes available /etc/newman directory for mouting, we can store our postman collections, env's file, can generate and store report to this directory. for more detail can refer offical docker image readme section [ref](https://hub.docker.com/r/postman/newman)

## How to run and genrate report
- `docker run -it newman:staging run {options} {collections_path}`
- To add this docker image on existing network use `--network=cex` flag, where cex is the network name
- To do volume mounting use `-v ./collections:/etc/newman` where ./collection is the local source path mapping to `/etc/newman` of the docker image path
- Here in out collection report we are using local docker wss repo for API endpoint which runs locally having docker image ip address `172.19.0.3`. newman docker image needs to know the domain details hence we are adding here hosts entry. for public domain its not required.
- Passign enviornment variable using `-e DEVWSS.postman_environment.json` flag
- you can run certain resource/folder from the collection rather running entire collection everytime. using `--folder Apps -k`, Where `k` is for ignore SSL certificate of the domain which needs to access while running collection
- add reporter format using `-r option`, e,g `-r cli,htmlextra` this will display cli summary of report as well as create htmlfile for the report. this is multiple reporter option way to set
- `reports` is the report directory relative path to `/etc/newman` where it will generate the report
- Last option is for collection path again relative to `/etc/newman` here
- Full example for html output 
`docker run --network=cex -v ./collections:/etc/newman --add-host dev-wss2.cex.uk.webuy.test:172.19.0.3 -it newman:staging run -e DEVWSS.postman_environment.json --folder Apps -k -r cli,htmlextra --reporter-htmlextra-export reports WSS.postman_collection_10042025.json`
- Full example for CSV report
`docker run --network=cex -v ./collections:/etc/newman --add-host dev-wss2.cex.uk.webuy.test:172.19.0.3 -it newman:staging run -e DEVWSS.postman_environment.json --folder Apps -k -r cli,csv --reporter-csv-includeBody --reporter-csv-export reports WSS.postman_collection_10042025.json`
