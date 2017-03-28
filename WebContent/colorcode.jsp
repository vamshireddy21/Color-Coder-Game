<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Color Code Game</title>
<style>
#upperDiv
{
margin: 0% 40% 0% 30%;
}

h1
{
font-color:#FF4500;
}
tr
{
padding: 1px;
}
td
{
padding: 3px;
}
table
{
padding: 5px;
}
.blue
{
	background-color: #3498DB;
	border-bottom: 5px  #2980B9;
	border-radius: 10%;
}

body
{
border-color:red;
}

a {
    color: hotpink;
}

a:link {
    color: red;
}

/* visited link */
a:visited {
    color: green;
}

/* mouse over link */
a:hover {
    color: hotpink;
}

/* selected link */
a:active {
    color: blue;
}

</style>
<script type="text/javascript"> 
//document.write("Test<br>");
//document.write(document.getElementById('b').innerHTML==document.getElementById('b').innerHTML  );

function check(guess)
{
	//alert(document.getElementById('score').innerHTML);
	var findMe = document.getElementById('findme');
	var findMeHTML = findMe.innerHTML;
	var guessHTML = guess.innerHTML;
	var level = document.getElementById('levelValue').value;
	//var currentName = document.getElementById('name').value;
	//if(!sessionStorage.getItem('name') )
		//{
		//document.getElementById('score').innerHTML = '0';
		//sessionStorage.setItem('name',currentName);
		//}
	//alert(findMeHTML);
	//alert(guessHTML);
		//alert(guess.getAttribute(color));
	
	var score = document.getElementById('score').innerHTML;
    var findMeColor = window.getComputedStyle(findMe).getPropertyValue('background-color');
    var guessColor = window.getComputedStyle(guess).getPropertyValue('background-color');
    //alert(findMeColor);
    //alert(guessColor);
    //alert(findMe.isEqualNode(guess));
	if( (findMeHTML.trim() === guessHTML.trim() ) && ( findMeColor === guessColor ))
		{
		//alert("Correct guess! Congrats");
		document.getElementById('score').innerHTML++;//updatedScoreValue;
		document.getElementById('clickText').innerHTML = "Correct guess! Congrats";
		score++;
		if( score %10 === 0 && (level !=7))
			{
			 level++;
			 alert("Congrats! Level up ");
			}
		}
	else
		{
		//alert("Wrong guess! Sorry");
		if((score %10 === 0) && (level>=1))
			{
			 level--;
			 alert("Sorry! level Down");
			}
		document.getElementById('score').innerHTML--;//updatedScoreValue;
		document.getElementById('clickText').innerHTML  = "Sorry! Wrong guess";
		
		}
	 
	if(level<=1)
		{
		//alert("destroy");
		level = 1;
		}
	

	
	 sessionStorage.setItem('score',document.getElementById('score').innerHTML);
	 sessionStorage.setItem('clickText',document.getElementById('clickText').innerHTML);
	 
	 
	 //alert("score "+score);
	 //var loctn ;
	 //if(sessionStorage.getItem('levelChangeScore') )
	 //{}
	 //else
	 //{
	 //locationStorage.setItem('levelChangeScore','0'); 
	 //}
	 //alert(sessionStorage.getItem('levelChangeScore') );
	 
	 
	
	 //alert(level);
	console.log(level);
	 var loctn = location.href.replace(/.$/,level);
	 //alert(loctn);
	 window.location.href = loctn;
	//}
	// window.location.reload(true);
	
	
}
function updateScore()
{
	//alert("update score");
	if(sessionStorage.getItem('score'))
	document.getElementById('score').innerHTML = sessionStorage.getItem('score');
	if(sessionStorage.getItem('clickText'))
	document.getElementById('clickText').innerHTML = sessionStorage.getItem('clickText');
//	alert(sessionStorage.getItem('levelChangeScore') );
}

var count=10;

var counter=setInterval(timer, 1000); //1000 will  run it every 1 second



function timer()
{
  count=count-1;
  if (count <= 0)
  {
     clearInterval(counter);
     location.reload(true);
     sessionStorage.setItem('clickText','No click! No Gain No pain');
     return;
  }

 document.getElementById("timer").innerHTML=count ;// watch for spelling
}

function restart()
{
	location.reload(true);
	sessionStorage.setItem('score','0');
	sessionStorage.setItem('clickText','');
}
</script>
</head>
<body onload="updateScore()">
<%
String colors[] = {"white","gray","yellow","green","blue","orange","pink"};
Random random = new Random();
String color;
int allowedColors = Integer.parseInt(request.getParameter("level"));
String name = request.getParameter("name");

%>
<input id="levelValue" type="hidden" value="<%=allowedColors %>" />
<%-- <input id="name" type="hidden" value="<%=name %>" /> --%>
<center ><h1>Color code Game</h1>

<h3> Level <%=allowedColors %> Game</h3>
<div id="upperDiv">
<span style="float:left">
<a href="colorcodewelcompage.html"> Change level</a>
</span>
<span style="float:right">
<button onclick="restart()">
Restart
</button>
</span>
</div>
<br>
<br>



<div style="margin:1% 40% 0% 30%">
	
<div id="firstDiv">



<div style="margin:"0% 40% 0% 40%; padding:"2% 5% 0% 5%">
<span id="scoreDiv" class="blue" style="float:left">Score
<button id="score">
0
</button>
</span>
<%
int findeMeColor = random.nextInt(allowedColors);
char findMeChar = (char)(random.nextInt(26) + 'A');
%>
<span>Find me
<button id="findme" style="background-color:<%=colors[findeMeColor]%>">
<%
out.print(findMeChar);
%>
</button>

</span>

<span id="timerDiv"  class="blue" style="float:right">
Timer
<button id="timer">
10 
</button>
</span>
</div>
<br>
<br>
<table border="1" >
<%
char c ='A';
for(int  i=1;i<=100;i++)
{
	if(i==1)
	out.println("<tr>");
	
	color = colors[random.nextInt(allowedColors)];
	
	if(c==findMeChar && random.nextBoolean())
		color = colors[findeMeColor];
	
%>	
<td><button  style="background-color:<%=color%>"  onclick="check(this)"> <% out.print(c); %> </button></td>
	
<% 
	if(i==100)
	out.println("</tr>");	
	else if(i%10 ==0)
	out.println("</tr><tr>");
	c++;
	
	if(c==('Z'+1))
	c='A';
}

%>



</table>
</div>

<div id="secondDiv">
<span id="clickText">
</span>
</div>
</div>
</center>
</body>
</html>