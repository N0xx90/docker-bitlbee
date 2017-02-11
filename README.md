#Bitlbee Docker with libpurple and telegram

```bash
docker build -t bitlbee .
docker run -ti --name bitlbee -p 127.0.0.1:6667:6667 -d -v $(pwd)/lib:/var/lib/bitlbee bitlbee
```
