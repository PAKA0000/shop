<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shop - 통계 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.5.0"></script>
</head>

<body>
	<h1>📊 매출 및 주문 통계</h1>

	<!-- 직원 메뉴 include -->
	<c:import url="/WEB-INF/view/inc/empMenu.jsp"></c:import>
	<hr>

	<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
	
	<label>기간 선택 :</label>
	<input type="text" id="fromYM" value="2025-01-01">
	
	<input type="text" id="toYM" value="2025-12-31">
	
	<br><br>
	
	<!-- ===== 통계 버튼 ===== -->
	<button type="button" id="totalOrderBtn">특정년도의 월별 주문횟수(누적) : 선 차트</button>
	<button type="button" id="totalPriceBtn">특정년도의 월별 주문금액(누적) : 선 차트</button>
	<button type="button" id="orderBtn">특정년도의 월별 주문수량 : 막대 차트</button>
	<button type="button" id="monthPriceBtn">특정년도의 월별 주문금액 : 막대 차트</button>
	<br><br>
	<button type="button" id="top10OrderCntBtn">고객별 주문횟수 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="top10OrderPriceBtn">고객별 총금액 1위 ~ 10위 : 막대 차트</button>
	<br><br>
	<button type="button" id="top10ProductCntBtn">상품별 주문횟수 1위 ~ 10위 : 막대 차트</button>
	<button type="button" id="top10ProductPriceBtn">상품별 주문금액 1위 ~ 10위 : 막대 차트</button>
	<br><br>
	<button type="button" id="genderOrderBtn">성별 총주문 금액 : 파이 차트</button>
	<button type="button" id="genderCntBtn">성별 총주문 수량 : 파이 차트</button>

	<hr>

	<!-- 차트 출력 영역 -->
	<canvas id="myChart" style="width:100%;max-width:800px"></canvas>
	<canvas id="top10ReviewChart" style="width:100%;max-width:800px"></canvas>
	<script>
		let myChart = null;

		// 그래프 초기화
		function resetChart() {
			if (myChart != null) {
				myChart.destroy();
				console.log('canvas 초기화');
			}
		}

		/* ✅ 1. 성별 총주문 금액 (파이 차트) */
		$('#genderOrderBtn').click(function () {
			$.ajax({
				url: $('#contextPath').val() + '/emp/genderOrder',
				type: 'get',
				success: function (result) {
					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m) {
						xValues.push(m.gender);
						yValues.push(m.cnt);
					});
					
					resetChart();
					myChart = new Chart("myChart", {
					  type: "pie",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: ["#b91d47", "#00aba9"],
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      title: {
					        display: true,
					        text: "성별 총 주문금액"
					      }
					    }
					  }
					});
				}
			});
		});


		/* ✅ 2. 특정년도의 월별 주문수량 (막대 차트) */
		$('#orderBtn').click(function () {
			$.ajax({
				url: $('#contextPath').val() + '/emp/order',
				type: 'get',
				data: {
					fromYM: $('#fromYM').val(),
					toYM: $('#toYM').val()
				},
				success: function (result) {
					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m) {
						xValues.push(m.ym);
						yValues.push(m.cnt);
					});
					
					resetChart();
					myChart = new Chart("myChart", {
					  type: "bar",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: ["red", "green","blue","orange","brown", "yellow"],
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      title: {
					        display: true,
					        text: "월별 주문수량"
					      }
					    }
					  }
					});
				}
			});
		});


		/* ✅ 3. 특정년도의 월별 주문금액(누적) (선 차트) */
		$('#totalPriceBtn').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalPrice',
				type: 'get',
				data: {
					fromYM: $('#fromYM').val(),
					toYM: $('#toYM').val()
				},
				success: function(result){
					let x = [];
					let y = [];
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalPrice);
					});
					
					resetChart();
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
					      text: "총 판매금액(누적)",
					      data: y,
					      borderColor: "#0000FF",
					      fill: false
					    }]
					  }
					});
				}
			});
		});


		/* ✅ 4. 특정년도의 월별 주문횟수(누적) (선 차트) */
		$('#totalOrderBtn').click(function(){
			$.ajax({
				url: $('#contextPath').val()+'/emp/totalOrder',
				type: 'get',
				data: {
					fromYM: $('#fromYM').val(),
					toYM: $('#toYM').val()
				},
				success: function(result){
					let x = [];
					let y = [];
					
					result.forEach(function(m){
						x.push(m.ym);
						y.push(m.totalOrder);
					});
					
					resetChart();
					myChart = new Chart("myChart", {
					  type: "line",
					  data: {
					    labels: x,
					    datasets: [{
					      label: "총 주문량(누적)",
					      data: y,
					      borderColor: "red",
					      fill: false
					    }]
					  }
					});
				}
			});
		});


		/* ✅ 5. 특정년도의 월별 주문금액 (비누적 막대 차트) */
		$('#monthPriceBtn').click(function(){
    $.ajax({
        url: $('#contextPath').val() + '/emp/monthlyPrice',
        type: 'get',
        data: {
            year: $('#fromYM').val().substring(0,4) // "2025"만 전달
        },
        success: function(result){
            console.log(result); // JSON이 제대로 내려오는지 확인

            let x = [];
            let y = [];
            result.forEach(function(m){
                x.push(m.ym);
                y.push(m.totalPrice);
            });

            resetChart();
            myChart = new Chart("myChart", {
                type: "bar",
                data: {
                    labels: x,
                    datasets: [{
                        label: "월별 주문금액",
                        data: y,
                        backgroundColor: "rgba(0,123,255,0.6)"
                    }]
                },
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: "월별 주문금액"
                        }
                    }
                }
            });
        }
    });
});



		/* ✅ 6. 고객별 주문횟수 TOP10 */
		$('#top10OrderCntBtn').click(function(){
            $.ajax({
                url: $('#contextPath').val() + '/emp/top10OrderCnt',
                type: 'get',
                success: function(result){
                    let x = [];
                    let y = [];
                    result.forEach(function(m){
                        x.push(m.customerName); // DAO에서 반환되는 키 이름 확인 필요
                        y.push(m.cnt);
                    });

                    resetChart();
                    myChart = new Chart("myChart", {
                        type: "bar",
                        data: {
                            labels: x,
                            datasets: [{
                                label: "주문횟수",
                                data: y,
                                backgroundColor: "rgba(255,99,132,0.6)"
                            }]
                        },
                        options: {
                            plugins: {
                                title: {
                                    display: true,
                                    text: "고객별 주문횟수 TOP10"
                                }
                            },
                            scales: {
                                x: { ticks: { autoSkip: false } },
                                y: { beginAtZero: true }
                            }
                        }
                    });
                }
            });
        });


		/* ✅ 7. 고객별 총금액 TOP10 */
		$('#top10OrderPriceBtn').click(function() {
    $.ajax({
        url: $('#contextPath').val() + '/emp/top10OrderPrice',
        type: 'get',
        success: function(result) {
            let x = [];
            let y = [];
            result.forEach(function(m){
                x.push(m.customerName);
                y.push(m.totalPrice);
            });

            resetChart();
            myChart = new Chart("myChart", {
                type: "bar",
                data: {
                    labels: x,
                    datasets: [{
                        label: "총 주문금액",
                        data: y,
                        backgroundColor: "rgba(75,192,192,0.6)"
                    }]
                },
                options: {
                    plugins: {
                        title: {
                            display: true,
                            text: "고객별 총 주문금액 TOP10"
                        }
                    },
                    scales: {
                        x: { ticks: { autoSkip: false } }
                    }
                }
            });
        }
    });
});


		/* ✅ 8. 상품별 주문횟수 TOP10 */
		$('#top10ProductCntBtn').click(function(){
        $.ajax({
            url: $('#contextPath').val() + '/emp/top10ProductCnt',
            type: 'get',
            success: function(result){
                let x = [];
                let y = [];
                result.forEach(function(m){
                    x.push(m.productName);
                    y.push(m.cnt);
                });
                
                resetChart();
                myChart = new Chart("myChart", {
                    type: "bar",
                    data: {
                        labels: x,
                        datasets: [{
                            label: "주문횟수",
                            data: y,
                            backgroundColor: "rgba(255,159,64,0.6)"
                        }]
                    },
                    options: {
                        plugins: {
                            title: {
                                display: true,
                                text: "상품별 주문횟수 TOP10"
                            }
                        },
                        scales: {
                            x: { ticks: { autoSkip: false } }
                        }
                    }
                });
            }
        });
    });


		/* ✅ 9. 상품별 주문금액 TOP10 */
		$('#top10ProductPriceBtn').click(function(){
    $.ajax({
        url: $('#contextPath').val() + '/emp/top10ProductPrice',
        type: 'get',
        success: function(result){
            console.log(result);

            if(!result || result.length === 0){
                alert("데이터가 없습니다!");
                return;
            }

            let labels = result.map(m => m.goodssName);  // ⚠ key 수정
            let data = result.map(m => m.totalPrice);

            if(myChart != null){
                myChart.destroy();
            }

            const ctx = document.getElementById("myChart").getContext("2d");
            myChart = new Chart(ctx, {
                type: "bar",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "총 주문금액",
                        data: data,
                        backgroundColor: "rgba(54,162,235,0.6)"
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: "상품별 주문금액 TOP10"
                        }
                    },
                    scales: {
                        x: { ticks: { autoSkip: false } },
                        y: { beginAtZero: true }
                    }
                }
            });
        }
    });
});
		
		
		document.addEventListener("DOMContentLoaded", function() {
		    const canvas = document.getElementById('top10ReviewChart');
		    if (!canvas) {
		        console.error("❌ <canvas id='top10ReviewChart'> 요소가 없습니다!");
		        return;
		    }

		    const ctx = canvas.getContext('2d');

		    fetch("${pageContext.request.contextPath}/emp/top10Review")
		        .then(response => response.json())
		        .then(data => {
		            if (!Array.isArray(data) || data.length === 0) {
		                console.warn("⚠️ 데이터가 없습니다.");
		                return;
		            }

		            const labels = data.map(item => item.goodsName || item.goodsCode || '상품없음');
		            const scores = data.map(item => item.avgScore || 0);

		            new Chart(ctx, {
		                type: 'bar',
		                data: {
		                    labels: labels,
		                    datasets: [{
		                        label: '평균 리뷰 평점',
		                        data: scores,
		                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
		                        borderColor: 'rgba(75, 192, 192, 1)',
		                        borderWidth: 1
		                    }]
		                },
		                options: {
		                    responsive: true,
		                    scales: {
		                        y: {
		                            beginAtZero: true,
		                            max: 5,
		                            title: { display: true, text: '평균 평점 (0~5)' }
		                        },
		                        x: {
		                            title: { display: true, text: '상품명 또는 코드' }
		                        }
		                    },
		                    plugins: {
		                        legend: { display: false },
		                        tooltip: {
		                            callbacks: {
		                                label: ctx => `평균 점수: ${ctx.parsed.y}`
		                            }
		                        }
		                    }
		                }
		            });
		        })
		        .catch(err => console.error("🚨 fetch 실패:", err));
		});


		/* ✅ 11. 성별 총 주문수량 (파이 차트) */
			$('#genderOrderBtn').click(function () {
			$.ajax({
				url: $('#contextPath').val() + '/emp/genderOrder',
				type: 'get',
				success: function (result) {
					let xValues = [];
					let yValues = [];
					
					result.forEach(function (m) {
						xValues.push(m.gender);
						yValues.push(m.cnt);
					});
					
					resetChart();
					myChart = new Chart("myChart", {
					  type: "pie",
					  data: {
					    labels: xValues,
					    datasets: [{
					      backgroundColor: ["#b91d47", "#00aba9"],
					      data: yValues
					    }]
					  },
					  options: {
					    plugins: {
					      title: {
					        display: true,
					        text: "성별 총 주문금액"
					      }
					    }
					  }
					});
				}
			});
		});
	
    </script>
</body>
</html>
