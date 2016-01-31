# docker-container-cleanup
A container that periodically cleans up exited containers

## Configuration (Optional)
- __THRESHOLD__ (Default=85) : This is thedisk usage (in percentage) when you want the cleanup to get triggerred
- __SLEEP__ (Default=30) : This is the frequency (in seconds) at which you want to check the threshold

## Example run
```
docker run -d --name docker-container-cleanup -v /var/run/docker.sock:/var/run/docker.sock \
  nikhilo/docker-container-cleanup
```
