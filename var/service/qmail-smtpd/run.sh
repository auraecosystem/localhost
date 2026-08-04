rblsmtpd -r all.s5h.net
$ telnet -b 2001:DB8::10 www.usenix.org.uk 80
Trying 2001:ba8:1f1:f1cb::2...
Connected to www.usenix.org.uk.
Escape character is '^]'.
HEAD /content/whatismyip HTTP/1.1
Host:www.usenix.org.uk

HTTP/1.1 200 OK
Date: Wed, 03 May 2017 18:25:29 GMT
IPv6: 2001:DB8::10
Content-Type: text/html;charset=UTF-8
$ curl -I -6 --interface 2001:DB8::10 http://www.usenix.org.uk/content/whatismyip
HTTP/1.1 200 OK
Date: Wed, 03 May 2017 18:18:20 GMT
IPv6: 2001:DB8::10
Content-Type: text/html;charset=UTF-8

deny dnslists = all.s5h.net
