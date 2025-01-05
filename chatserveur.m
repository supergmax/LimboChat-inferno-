implement ChatServer;

include "sys.m";
include "styx.m";
include "keyring.m";

ChatServer: module {
    PATH: con "/dis/chat/chatserver.dis";
    init: fn(ctxt: ref Draw->Context, args: list of string);
};
