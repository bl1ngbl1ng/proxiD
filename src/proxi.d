import std.stdio;
import std.net.curl;

import std.algorithm : canFind;

const i = "(*)";
const s = "(+)";
const e = "(-)";

auto types = ["http", "socks5", "socks", "mix"];

void main(string[] args) {
	if (args.length != 2) {
	       	writefln("%s invalid argument usage.\nusage: %s <type>", e, args[0]);
	} else {
		if (types.canFind(args[1])) {
			scrape(args[1]);
		} else {
			writefln("%s invalid proxy type.\nproxy types available: http socks socks5 mix", e);
		}
	}
}

void scrape(string type) {
	writefln("%s type: %s", i, type);
	writefln("%s beginning scrape..", s);

	if (type == "http") {
		download("https://api.proxyscrape.com/v2/?request=getproxies&protocol=http&timeout=10000&country=all&ssl=all&anonymity=all", "http.txt");
	} else if (type == "socks") {
		download("https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks4&timeout=10000&country=all&ssl=all&anonymity=all", "socks.txt");
	} else if (type == "socks5") {
		download("https://api.proxyscrape.com/v2/?request=getproxies&protocol=socks5&timeout=10000&country=all&ssl=all&anonymity=all", "socks5.txt");
	} else {
		download("https://api.proxyscrape.com/v2/?request=getproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all", "mixed.txt");
	}
	writefln("%s finished exporting proxies to disk!", s);
}
