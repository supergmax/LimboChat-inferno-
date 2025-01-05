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

    for(;;) {
        conn := sys->accept(listener, nil);
        if(conn != nil) {
            sys->print("Nouvelle connexion: %s\n", conn.dir);
            spawn handleConnection(conn);
        }
    }
}

handleConnection(conn: ref Sys->Connection)
{
    sys->print("Gestion de la connexion\n");
    for(;;) {
        msg := sys->read(conn, 1024);
        if(msg == nil) break;

        sys->print("Message reçu: %s\n", msg);
        # Envoi de la réponse
        sys->write(conn, "Message reçu.\n");
    }
    sys->close(conn);
}
