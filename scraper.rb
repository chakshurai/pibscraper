#!/usr/bin/env python
import scraperwiki
import lxml.html
baselink = "http://pib.nic.in/newsite/erelease.aspx?relid="
for releaseid in range(0,5000):
    url = baselink+str(releaseid)
    html = scraperwiki.scrape(url)
    root = lxml.html.fromstring(html)
    date = root.cssselect("div#ministry.mddiv span")
    if not date:
        continue
    data = {
       'releasenumber' : releaseid,
       'date' : root.cssselect("div#ministry.mddiv span")[0].text_content(),
       'ministry' : root.cssselect("div#ministry.mddiv")[0].text,
       'title' : root.cssselect("div.contentdiv tr")[0].text_content(),
       'content' : lxml.html.tostring(root.cssselect("div.contentdiv")[0])
       }
    print releaseid
    scraperwiki.sql.save(unique_keys=['releasenumber'], data=data)
