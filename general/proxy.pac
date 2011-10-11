function FindProxyForURL(url, host){
    PROXY = "PROXY 127.0.0.1:8123";
    DEFAULT = "PROXY 127.0.0.1:3128";
    DEFAULT = "DIRECT";

    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?redhat\.com/i.test(url)) return DEFAULT;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?google\.com/i.test(url)) return DEFAULT;
    if(/^[\\-]+:\/+(?!\/)(?:[^\/]+\.)?youtu\.be/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?youtube\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?ytimg\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?googleusercontent\.com/i.test(url)) return DEFAULT;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?flashget\.com/i.test(url)) return DEFAULT;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?uptime.netcraft\.com/i.test(url)) return DEFAULT;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?twitter\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?facebook\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?fbcdn\.net/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?bbc\.co\.uk/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?bbcimg\.co\.uk/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?mail-archive\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?friendfeed\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?ff\.im/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wordpress\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?twitpic\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?peacehall\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wikimedia\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?plurk\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wikipedia\.org/i.test(url)) return DEFAULT;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wikiquote\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?tweetmeme\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?imageshack\.us/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?dw-world\.de/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?zuola\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?voanews\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?thepiratebay\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?fc2\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?libertytimes\.com\.tw/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?boxun\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)meme\.yahoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?rfa\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?bullogger\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?xys\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)tw\.rd\.yahoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wretch\.cc/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)ping\.fm/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?rfi\.fr/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?dwnews\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?twitgoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)www\.chinagfw\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?posterous\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wenxuecity\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)hellotxt\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)cache\.saurik\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?img\.ly/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)desmond\.yfrog\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?twiyia\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?foursquare\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?aboluowang\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?tumblr\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?mobypicture\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?dropbox\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?pixnet\.net/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?dongtaiwang\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?wujie\.net/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?liuchuan\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)dabr\.co\.uk/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?pict\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?tinypic\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?hootsuite\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?blogspot\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?im\.tv/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?blogger\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?botcyb\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?t66y\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?bit\.ly/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?1bao\.org/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?mediafire\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?chengmingmag\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?pbworks\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?quantserve\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?tweetwawa\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?tw\.yahoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)tw\.reg\.yahoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)tw\.login\.yahoo\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?photobucket\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?destroytwitter\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)www\.echofon\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?androidenea\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?android\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)(?:[^\/]+\.)?isaacmao\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)farm5\.static\.flickr\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)feeds\.feedburner\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)spreadsheets\.google\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)mashable\.com/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)cdnews\.com\.tw/i.test(url)) return PROXY;
    if(/^[\w\-]+:\/+(?!\/)ftchinese\.com/i.test(url)) return PROXY;
    if(/t\.co/i.test(url)) return PROXY;


    return DEFAULT;
}

