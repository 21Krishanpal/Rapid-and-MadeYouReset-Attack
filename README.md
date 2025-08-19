# Rapid and MadeYou Reset Attack

Rapid and MadeYouReset script is a testing tool for the Rapid/MadeYouReset DDoS attack. It uses a minimal HTTP/2 client that connects over TLS, skips certificate checks, and sends rapid HEADERS and RST_STREAM frames to check if a server is vulnerable. 

## Prerequisites

- [Go](https://golang.org/dl/)

Tested on go1.21.3 on arm64.  

## Installation

### Clone the Repository

```
git clone https://github.com/21Krishanpal/Rapid-and-MadeYouReset-Attack.git
```

### Installing

```
cd rapidresetclient
chmod +x rapid.sh
./rapid.sh

<img width="953" height="81" alt="image" src="https://github.com/user-attachments/assets/4ef6aa05-7b2d-461c-98e1-9155eb6cf4cb" />



```

### Flags

- `requests`: Number of requests to send (default is 5)

- `url`: Server URL (default is `https://localhost:443`)

- `wait`: Wait time in milliseconds between starting workers (default is 0)

- `delay`: Delay in milliseconds between sending HEADERS and RST_STREAM frames (default is 0)

- `concurrency`: Maximum number of concurrent workers (default is 0)

### Example

Send 10 HTTP/2 requests (HEADERS and RST_STREAM frames) over a single connection to https://example.com using 5 workers, a 10 ms delay between sending HEADERS and RST_STREAM frames, and a wait time of 100 ms between each invocation.

## Contact Me

-  Krishan Pal
-  https://krishanpal21.pythonanywhere.com/



