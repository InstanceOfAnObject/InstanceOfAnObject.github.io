---
layout: default
title: About
categories: about
permalink: /about/
---

<h1>
	<img class="profile-picture" src="http://www.gravatar.com/avatar/eada57c6441e30a5337fbb1e877216cb" />
	<div style="float: right;">About me</div>
</h1>

<div id="chartContainer" style="height: 300px; width: 100%;"></div>








<script type="text/javascript" src="/assets/scripts/canvasjs.min.js"></script>
<script type="text/javascript">
	window.onload = function () {
		var currentYear = new Date().getYear(),
		    getYearSpan = function(from, to){
		        if(!to){
		            return new Date().getYear() - new Date(from.y,from.m,from.d).getYear();
		        } else {
		            return new Date().getYear(to.y,to.m,to.d) - new Date(from.y,from.m,from.d).getYear();
		        }
		    },
		    chart = new CanvasJS.Chart("chartContainer", {

			title:{
				text:"Technology experience"				

			},
            animationEnabled: true,
			axisX:{
				interval: 1,
				gridThickness: 0,
				labelFontSize: 10,
				labelFontStyle: "normal",
				labelFontWeight: "normal",
				labelFontFamily: "Lucida Sans Unicode"

			},
			axisY2:{
				interlacedColor: "rgba(1,77,101,.2)",
				gridColor: "rgba(1,77,101,.1)"

			},

			data: [
			{     
				type: "bar",
                name: "companies",
				axisYType: "secondary",
				color: "#014D65",				
				dataPoints: [
    				{y: getYearSpan({y:2002,m:11,d:1}), label: ".Net Framework" },
    				{y: getYearSpan({y:2002,m:11,d:1}), label: "T-SQL" },
    				{y: getYearSpan({y:2012,m:08,d:1}, {y:2015,m:01,d:1}), label: "JAVA" }
				]
			}
			
			]
		});

    chart.render();
}
</script>
