implement ChatServer;

include "sys.m";
include "styx.m";
include "keyring.m";

Sys: import sys;
Styx: import styx;
Keyring: import keyring;

ChatServer: module {
    PATH: con "/dis/chat/chatserver.dis";
    init: fn(ctxt: ref Draw->Context, args: list of string);
};

users: list of ref Sys->Connection;

init(ctxt: ref Draw->Context, args: list of string)
{
    sys = load Sys Sys->PATH;
    styx = load Styx Styx->PATH;
    keyring = load Keyring Keyring->PATH;

    sys->print("ChatServer started\n");

    # Initialisation du serveur Styx
    listener := sys->announce("tcp!*!4242", nil);
    if(listener == nil)
        sys->fatal("Impossible d'ouvrir le port 4242\n");

    users = nil;
    for(;;) {
        conn := sys->accept(listener, nil);
        if(conn != nil) {
            sys->print("Nouvelle connexion: %s\n", conn.dir);
            users = sys->cons(conn, users);
            spawn handleConnection(conn);
        }
    }
}

handleConnection(conn: ref Sys->Connection)
{
    key := "supersecretdonottell";
    encrypted := load Keyring Keyring->encrypt;

    for(;;) {
        msg := sys->read(conn, 1024);
        if(msg == nil) break;

        decrypted_msg := keyring->decrypt(msg, key);
        sys->print("Message reçu: %s\n", decrypted_msg);

        broadcastMessage(decrypted_msg, conn);
    }
    sys->close(conn);
    users = sys->delete(conn, users);
}

broadcastMessage(msg: string, sender: ref Sys->Connection)
{
    for(conn in users) {
        if(conn != sender) {
            sys->write(conn, msg);
        }
    }
}
