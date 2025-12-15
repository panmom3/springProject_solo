<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
		<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
		<link href="${ctp}/css/styles.css" rel="stylesheet" />
		<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <title>관리자페이지</title>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/include/adtop.jsp" />
<div id="layoutSidenav">
<jsp:include page="/WEB-INF/views/include/adnav.jsp" />
	<div id="layoutSidenav_content">
	    <main>
	        <div class="container-fluid px-4">
	            <h1 class="mt-4">관리자메뉴</h1>
	            <ol class="breadcrumb mb-4">
	                <li class="breadcrumb-item active">관리자메뉴</li>
	            </ol>
	            <div class="row">
	                <div class="col-xl-3 col-md-6">
	                    <div class="card bg-primary text-white mb-4">
	                        <div class="card-body">회원리스트</div>
	                        <div class="card-footer d-flex align-items-center justify-content-between">
	                            <a class="small text-white stretched-link" href="#">View Details</a>
	                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-xl-3 col-md-6">
	                    <div class="card bg-warning text-white mb-4">
	                        <div class="card-body">Warning Card</div>
	                        <div class="card-footer d-flex align-items-center justify-content-between">
	                            <a class="small text-white stretched-link" href="#">View Details</a>
	                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-xl-3 col-md-6">
	                    <div class="card bg-success text-white mb-4">
	                        <div class="card-body">Success Card</div>
	                        <div class="card-footer d-flex align-items-center justify-content-between">
	                            <a class="small text-white stretched-link" href="#">View Details</a>
	                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                        </div>
	                    </div>
	                </div>
	                <div class="col-xl-3 col-md-6">
	                    <div class="card bg-danger text-white mb-4">
	                        <div class="card-body">Danger Card</div>
	                        <div class="card-footer d-flex align-items-center justify-content-between">
	                            <a class="small text-white stretched-link" href="#">View Details</a>
	                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="row">
	                <div class="col-xl-12">
	                    <div class="card mb-4">
	                        <div class="card-header">
	                            <i class="fas fa-chart-area me-1"></i>
	                            주간 방문현황
	                        </div>
	                        <div class="card-body"><canvas id="myAreaChart" width="100%" height="20"></canvas></div>
	                    </div>
	                </div>
	                <!-- <div class="col-xl-6">
	                    <div class="card mb-4">
	                        <div class="card-header">
	                            <i class="fas fa-chart-bar me-1"></i>
	                            Bar Chart Example
	                        </div>
	                        <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
	                    </div>
	                </div> -->
	            </div>
	            <!-- <div class="card mb-4">
	                <div class="card-header">
	                    <i class="fas fa-table me-1"></i>
	                    DataTable Example
	                </div>
	                <div class="card-body">
	                    <table id="datatablesSimple">
	                        <thead>
	                            <tr>
	                                <th>Name</th>
	                                <th>Position</th>
	                                <th>Office</th>
	                                <th>Age</th>
	                                <th>Start date</th>
	                                <th>Salary</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <tr>
	                                <td>Tiger Nixon</td>
	                                <td>System Architect</td>
	                                <td>Edinburgh</td>
	                                <td>61</td>
	                                <td>2011/04/25</td>
	                                <td>$320,800</td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	            </div> -->
	        </div>
	    </main>
			<jsp:include page="/WEB-INF/views/include/adfooter.jsp" />
	</div>
</div> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<%-- <script src="${ctp}/js/chart-area-demo.js"></script>
<script src="${ctp}/js/chart-bar-demo.js"></script> --%>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${ctp}/js/datatables-simple-demo.js"></script>
<script>
	//Set new default font family and font color to mimic Bootstrap's default styling
	Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
	Chart.defaults.global.defaultFontColor = '#292b2c';
	
	// Area Chart Example
	var ctx = document.getElementById("myAreaChart");
	var myLineChart = new Chart(ctx, {
	  type: 'line',
	  data: {
	    labels: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
	    datasets: [{
	      label: "Sessions",
	      lineTension: 0.3,
	      backgroundColor: "rgba(2,117,216,0.2)",
	      borderColor: "rgba(2,117,216,1)",
	      pointRadius: 5,
	      pointBackgroundColor: "rgba(2,117,216,1)",
	      pointBorderColor: "rgba(255,255,255,0.8)",
	      pointHoverRadius: 5,
	      pointHoverBackgroundColor: "rgba(2,117,216,1)",
	      pointHitRadius: 50,
	      pointBorderWidth: 2,
	      data: [10, 20, 30, 50, 20, 30, 70],
	    }],
	  },
	  options: {
	    scales: {
	      xAxes: [{
	        time: {
	          unit: 'date'
	        },
	        gridLines: {
	          display: false
	        },
	        ticks: {
	          maxTicksLimit: 7
	        }
	      }],
	      yAxes: [{
	        ticks: {
	          min: 0,
	          max: 100,
	          maxTicksLimit: 5
	        },
	        gridLines: {
	          color: "rgba(0, 0, 0, .125)",
	        }
	      }],
	    },
	    legend: {
	      display: false
	    }
	  }
	});
</script>
</body>
</html>