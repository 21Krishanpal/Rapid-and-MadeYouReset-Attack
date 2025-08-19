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

```
<img width="953" height="81" alt="image" src="https://github.com/user-attachments/assets/4ef6aa05-7b2d-461c-98e1-9155eb6cf4cb" />

<img width="947" height="60" alt="image" src="https://github.com/user-attachments/assets/ec134ec6-b141-4a2f-9166-36b09cbe43c4" />

<img width="940" height="225" alt="image" src="https://github.com/user-attachments/assets/0a86cf39-f054-4910-a407-a101c4d93933" />

<img width="950" height="330" alt="image" src="https://github.com/user-attachments/assets/e79f92a7-1d66-45e0-a24d-09c609a73156" />

### Flags

- `requests`: Number of requests to send (default is 5)

- `url`: Server URL (`https://example.com:443`)

- `wait`: Wait time in milliseconds between starting workers (default is 0)

- `delay`: Delay in milliseconds between sending HEADERS and RST_STREAM frames (default is 0)

- `concurrency`: Maximum number of concurrent workers (default is 0)

### Example

Send 20 HTTP/2 requests (HEADERS and RST_STREAM frames) over a single connection to https://example.com using 5 workers, a 10 ms delay between sending HEADERS and RST_STREAM frames, and a wait time of 100 ms between each invocation.

## Contact Me

-  Krishan Pal
-  https://krishanpal21.pythonanywhere.com/



