/**
 * 
 */
 $(function(){
	
	$("#bar-chart-weekly").hide();
	$("#bar-chart-monthly").hide();
	
	$("#daily_btn").click(function(){
		$("canvas[id != 'bar-chart-daily']").hide();
		$("#bar-chart-daily").show();
	})
	$("#weekly_btn").click(function(){
		$("canvas[id != 'bar-chart-weekly']").hide();
		$("#bar-chart-weekly").show();
	})
	$("#monthly_btn").click(function(){
		$("canvas[id != 'bar-chart-monthly']").hide();
		$("#bar-chart-monthly").show();
	})
	
	
})


	



 
 //일별 매출 그래프
 window.onload = function() {
	let today = new Date();
	let year = today.getFullYear();
	let month = today.getMonth()+1;
	let date = today.getDate();
	console.log(today);
	console.log(year);
	console.log(month);
	console.log(date);
	
	
	new Chart(document.getElementById("bar-chart-daily"), {
	    type: 'bar',
	    
	    data: {
	
	      labels: [
					 month + '월' + (date-6)+"일 : "+$("#sale1").val()+"￦",
					 month + '월' + (date-5)+"일 : "+$("#sale2").val()+"￦",
					 month + '월' + (date-4)+"일 : "+$("#sale3").val()+"￦",
					 month + '월' + (date-3)+"일 : "+$("#sale4").val()+"￦",
					 month + '월' + (date-2)+"일 : "+$("#sale5").val()+"￦",
					 month + '월' + (date-1)+"일 : "+$("#sale6").val()+"￦",
					 month + '월' + (date)+"일 : "+$("#sale7").val()+"￦",
	      			],
	      			
	      datasets: [
	        {
	          label: "매출",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850","red","yellow"],
	          data: [
						$("#sale1").val(),
						$("#sale2").val(),
						$("#sale3").val(),
						$("#sale4").val(),
						$("#sale5").val(),
						$("#sale6").val(),
						$("#sale7").val()
					]
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '최근 일주일 일별 매출현황'
	      }
	    }
	});//END-daily sales
	
	
	new Chart(document.getElementById("bar-chart-monthly"), {
	    type: 'bar',
	    
	    data: {
	
	      labels: [
					"1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"
	      			],
	      			
	      datasets: [
	        {
	          label: "매출",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850","red","yellow","green","blue","orange","pink","indigo"],
	          data: [
						$("#monthly_sale1").val(),
						$("#monthly_sale2").val(),
						$("#monthly_sale3").val(),
						$("#monthly_sale4").val(),
						$("#monthly_sale5").val(),
						$("#monthly_sale6").val(),
						$("#monthly_sale7").val(),
						$("#monthly_sale8").val(),
						$("#monthly_sale9").val(),
						$("#monthly_sale10").val(),
						$("#monthly_sale11").val(),
						$("#monthly_sale12").val()
						
					]
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '월별 매출현황'
	      }
	    }
	});//END-weekly sales
	
	
	new Chart(document.getElementById("bar-chart-weekly"), {
	    type: 'bar',
	    
	    data: {
	
	      labels: [
					"Four Weeks Ago","Three Weeks Ago","Two Weeks Ago","A Week Ago","This Week"
	      			],
	      			
	      datasets: [
	        {
	          label: "매출",
	          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
	          data: [
						$("#weekly_sale1").val(),
						$("#weekly_sale2").val(),
						$("#weekly_sale3").val(),
						$("#weekly_sale4").val(),
						$("#weekly_sale5").val(),
						
					]
	        }
	      ]
	    },
	    options: {
	      legend: { display: false },
	      title: {
	        display: true,
	        text: '주별 매출현황'
	      }
	    }
	});//END-weekly sales
	
	}//END-window.onload