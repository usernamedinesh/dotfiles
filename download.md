# install yt-dlp
# install aria2 -> help in downloading fast

* yt-dlp <video-url> __It directly download the video__
* yt-dlp -f "bestvideo+bestaudio" <video-url> __download the best available video and audio__
* yt-dlp --format mp4 <video-url>
* yt-dlp --get-url <video-url> __Extract url without downlading__

# fast downlading

* aria2-> is an external downloader 
- yt-dlp --external-downloader aria2c --external-downloader-args "-x 16 -k 1M" <video-url>
*  yt-dlp --external-downloader aria2c --external-downloader-args "-x 8 -k 1M" <video-url> __8 conection for 5mbps speed and 1mbps chunk__
