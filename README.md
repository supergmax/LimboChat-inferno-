# LimboChat-inferno-
Serveur de Chat Sécurisé (limbo, inferno)

A chat application written in Limbo for the Inferno operating system. This project demonstrates the use of Limbo's concurrency model, network communication via Styx, and encryption using the Keyring module.

## Features

- **Server-Client Architecture**: A server manages multiple clients concurrently.
- **Encrypted Communication**: Messages are encrypted and decrypted for secure transmission.
- **Support for Multiple Clients**: The server broadcasts messages to all connected clients.
- **Graphical Client Interface**: Basic graphical interface for chat interaction using `draw.m`.

## File Structure

```
.
├── chatserverV2.b      # Implementation of the chat server
├── chatserverV2.m      # Interface definition for the chat server
├── chatclient.b        # Implementation of the chat client
├── chatserveur.m       # Alternate server interface file
```

## Prerequisites

Before running the application, ensure you have the following:

1. **Inferno Environment**: Set up Inferno OS on your system.
2. **Limbo Compiler**: Ensure `limbo` is installed and accessible in your environment.

## Installation

1. Clone this repository or copy the files to your Inferno environment.
2. Navigate to the project directory where the files are located.

## Compilation

To compile the server and client:

```sh
# Compile the server
limbo -g chatserverV2.b

# Compile the client
limbo -g chatclient.b
```

## Running the Application

### Starting the Server

1. Run the server with the following command:

   ```sh
   emu chatserverV2.dis
   ```

2. The server will start listening for connections on port `4242`.

### Starting the Client

1. Run the client using:

   ```sh
   emu chatclient.dis
   ```

2. A graphical interface will appear. Use the input field to send messages and view received messages in the display area.

## Usage

1. Start the server first.
2. Launch one or more clients.
3. Clients can send messages to the server, and the server will broadcast these messages to all connected clients.

## Future Improvements

- Add user authentication.
- Enhance the graphical interface.
- Implement message logging on the server side.
- Support for private messages between clients.

## License

This project is licensed under the MIT License.
