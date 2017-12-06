<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8" /> 
		<title>js读取摄像头02</title>
		<script type="text/javascript" src="resources/js/jquery-1.7.2.min.js"></script>
		<style>
			html,body{
				width:100%;
				heigth:100%;
			}
			body{
				background: url(resources/images/background.jpg) center;
				overflow: hidden
			}
			video {
			    border: 1px solid #ccc;
			    display: block;
			    margin: 0 0 20px 0;
			    float:left;
			}
			canvas {
			    margin-top: 20px;
			    border: 1px solid #ccc;
			    display: block;
			}
		</style>
	</head>
	<body>
		<video width="640" height="480" id="myVideo"></video>
		<canvas width="640" height="480" id="myCanvas"></canvas>
		<button id="myButton">截图</button>
		<button id="myButton2">预览</button>
		<button id="myButton3">
			<a download="video.png">另存为</a>
		</button>
	</body>
	<script>
		window.addEventListener(
			'DOMContentLoaded',
			function(){
				var cobj=document.getElementById('myCanvas').getContext('2d');
				var vobj=document.getElementById('myVideo');
				getUserMedia(
					{video:true},//使用摄像头对象
					function(stream){
						vobj.src=stream;
						vobj.play();
					},
					function(){}
				);
				document.getElementById('myButton').addEventListener(
					'click',
					function(){
						cobj.drawImage(vobj,0,0,640,480); //绘制canvas图形
						document.getElementById('myButton3').children[0].href=cobj.canvas.toDataURL("image/png"); //把canvas图像转为img图片
					},
					false
				);
				document.getElementById('myButton2').addEventListener(
					'click',
					function(){
						window.open(cobj.canvas.toDataURL("image/png"),'_blank');
					},
					false
				);
			},
			false
		);
		
		function getUserMedia(obj,success,error){
			if(navigator.getUserMedia){
				getUserMedia=function(obj,success,error){
					navigator.getUserMedia(obj,function(stream){
						success(stream);
					},error);
				}
			}else if(navigator.webkitGetUserMedia){
				getUserMedia=function(obj,success,error){
					navigator.webkitGetUserMedia(obj,function(stream){
						var _URL=window.URL || window.webkitURL;
						success(_URL.createObjectURL(stream));
					},error);
				}
			}else if(navigator.mozGetUserMedia){
				getUserMedia=function(obj,success,error){
					navigator.mozGetUserMedia(obj,function(stream){
						success(window.URL.createObjectURL(stream));
					},error);
				}
			}else{
				return false;
			}
			return getUserMedia(obj,success,error);
		}
	</script>
</html>