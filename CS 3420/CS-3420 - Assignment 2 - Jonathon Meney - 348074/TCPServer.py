from socket import *

server_port = 8000
server_socket = socket(AF_INET, SOCK_STREAM)
server_socket.bind(('127.0.0.1', server_port))
server_socket.listen(1)

print('The server is ready to receive')

while True:
    connection_socket, connection_address = server_socket.accept()

    try:
        request = connection_socket.recv(1024).decode('utf-8')

        # second item will be path in url
        request_file = request.split()[1]

        # just prefix with a dot to search from current directory down whatever path was given
        # if the file isn't found will throw an exception
        with open('.' + request_file) as file:
            # if we found the file we'll send it back along with proper headers
            header = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n"
            response = header.encode('utf-8')
            connection_socket.send(response)

            for line in file:
                connection_socket.send(line.encode('utf-8'))
            connection_socket.send("\r\n".encode())

    except:
        # in the event of a bad path given throw 404 Not Found
        connection_socket.send("HTTP/1.1 404 Not Found\r\n".encode())

    connection_socket.close()
