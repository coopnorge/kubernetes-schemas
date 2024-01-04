# kubernetes-schemas

Here we can host schemas of the api's in our kubernetes clusters. This is useful 
for validating manifests.

To update the schema's, check if the schemas are defined in `fetch-schemas.sh`.
Then build the docker image:

```
docker build -t python-bats .
```

Then run 

```
docker docker run -v $(pwd):/src -it python-bats bash
```

in the container run

```
 ./fetch-schemas-api-platform.sh <dest>
```
