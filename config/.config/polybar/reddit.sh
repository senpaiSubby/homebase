#!/bin/bash

# Type Reddit JSON URL from
# https://www.reddit.com/prefs/feeds/
# Click "your inbox" > "unread messages" > "JSON" and copy the link

url='https://www.reddit.com/message/unread/.json?feed=5b6521c02d256e58a20069862bc5e945d7d584c3&user=UrbanThaKid'

# Set prefix icon

icon=' '

# Set prefix icon color with and without unread messages
unreadColor='#e06c75'
readColor='#e0e0e0'

unread=$(curl -s -A "Linux:com.ss132ikl.polybarinbox:v1.0.0 by /u/132ikl" $url | jq '.["data"]["children"] | length ')
(( "$unread" > "0" )) && echo "%{F$unreadColor}$icon $unread" || echo "%{F$readColor}$icon $unread"
