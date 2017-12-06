<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>js读取摄像头01</title>
    </head>
    <body>
        <video id="video" width="640" height="480" autoplay></video>
        <button id="snap">Snap Photo</button>
        <canvas id="canvas" width="640" height="480"></canvas>
    </body>
    <script type="text/javascript">
        // Put event listeners into place
        window.addEventListener("DOMContentLoaded", function() {
            // Grab elements, create settings, etc.
            var canvas = document.getElementById("canvas"),
                context = canvas.getContext("2d"), //getContext唯一合法值2d
                video = document.getElementById("video"),
                videoObj = {
                    "video": true,//使用摄像头对象
                    "audio": true //不适用音频
                },
                errBack = function(error) {
                    console.log("Video capture error: ", error.code);
                };

            // Put video listeners into place
            //navigator.getUserMedia =  navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
            if (navigator.getUserMedia) { // Standard 如果用户允许打开摄像头
                //stream为读取的视频流
                navigator.getUserMedia(videoObj, function(stream) {
                    video.src = stream;
                    video.play();
                }, errBack);
            } else if (navigator.webkitGetUserMedia) { // WebKit-prefixed  根据不同的浏览器写法不同
                navigator.webkitGetUserMedia(videoObj, function(stream) {
                    video.src = window.webkitURL.createObjectURL(stream);
                    video.play();
                }, errBack);
            } else if (navigator.mozGetUserMedia) { // Firefox-prefixed
                navigator.mozGetUserMedia(videoObj, function(stream) {
                    video.src = window.URL.createObjectURL(stream);
                    video.play();
                }, errBack);
            }
            document.getElementById("snap").addEventListener("click", function() {
                context.drawImage(video, 0, 0, 640, 480);//绘制canvas图形
            });
        }, false);
    </script>
</html>