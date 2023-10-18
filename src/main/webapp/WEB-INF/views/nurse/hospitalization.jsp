<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 

<link href="/resources/css/demo.css" rel="stylesheet"/> 

<style>
   .su{
      float: left;
      margin-bottom: 0;
   }
   #btn{
      float: right;
   }
   #ii{

	width: 100%;
	height: 50%;
   }
   .form-control-sm {
	border: none;
}
.choice{
	width : 35px;
	height: 20px;
	font-size: 11px;
	text-align: center;
	padding : 0px;
	margin : 0px 0px 0px 5px;
	
}
.ftable{
	margin : 0px;
	height: 100%;
}
.ftable th, .ftable td{
	height : 40px;
	padding : 0px 0px 5px 0px;
	text-align: center;
	
}
.ftable td{
	width: 10px;
	
}
.grid2{
	margin:0px;
}
/* 첫번째 */
.gs-id-0 > .grid-stack-item[gs-h="5"] {
    height: 790px;
}
.gs-12>.grid-stack-item[gs-w="2"] {
    width: 296px;
 }
/*두번째*/
 .gs-id-0 > .grid-stack-item[gs-x="2"] {
    left: 297px;
}
.gs-id-0 > .grid-stack-item[gs-h="3"] {
    height: 416px;
}
.gs-12>.grid-stack-item[gs-w="3"] {
    width: 422px;
}
.gs-12>.grid-stack-item[gs-w="5"] {
    width: 790px;
}
.gs-12>.grid-stack-item[gs-w="7"] {
    width: 1171px;
}
.gs-id-0 > .grid-stack-item[gs-y="3"] {
    top: 407px;
}
.gs-id-0 > .grid-stack-item[gs-x="5"] {
    left: 702px;
}
.gs-id-0 > .grid-stack-item[gs-x="7"] {
    left: 58%;
}
</style>

<script>

//시작하자마자 보이기

$(function() {
	hospWait();
	table3F();
	table4F();
	
}); //$(function(){}) 끝

// $("#btn3F").on("click",function(){
$(document).on("click","#btn3F",function(){
	//alert("안녕");
	console.log("개똥이3");
	table3F();
});

// $("#btn4F").on("click",function(){
$(document).on("click","#btn4F",function(){
	//alert("4층");
	console.log("개똥이4");
	table4F();
});

// 3층 병상 표
function table3F(){
let roomList = $("#f3");
	$.ajax({
		url : "/nurse/selectRoom",
		type : "get",
		dataType : 'JSON',
		success : function(rslt){
			console.log("방결과 (번호)" , rslt);
			console.log("rslt[0]" , rslt[0]);
			console.log("rslt[0].sckrmNo",rslt[0].sckrmNo);
			textRoom = "";
			   for (let i = 0; i < rslt.length; i++) {
				   if (rslt[i].sckrmNo >= 300 && rslt[i].sckrmNo < 400) {
					   
					   console.log("rslt[i].sckrmNo",rslt[i].sckrmNo);
					   let sckrmTypeOcc = rslt[i].sckrmTypeOcc;
	                   let tdWidth = setTdWidth(sckrmTypeOcc);
	                   
					   console.log("방 넓이 " ,tdWidth);
			        textRoom += `
			            <p class="card-header" style="text-align:left; padding:17px 0px 0px 10px;font-size: 11px;">
			                \${rslt[i].sckrmNo}호(\${rslt[i].sckrmTypeOcc}인실)
			            </p>
			             <div class="table-responsive text-nowrap tableDiv"style="height:83px; width:100%;">
			       		 <table class="table table-bordered ftable"style="font-size: 11px;">
			       			<thead>
			       
			       	         <tr>
			       	         `;
			  for(let j=1;j<=rslt[i].sckrmTypeOcc; j++){
				  textRoom += `  <th style="width: \${tdWidth}px !important;">\${j}번병상<button id="\${rslt[i].sckrmNo}\${j}" type="button"  class="btn btn-secondary choice"  onclick="hospitRoom(\${j},\${rslt[i].sckrmNo},this)">선택</button></th>`;
				  }
			  textRoom += ` </tr>
	       	       			</thead>
	       	     			 <tbody class="table-border-bottom-0 ptable">
	       		      		 <tr>`;
	       		for(let j=1;j<=rslt[i].sckrmTypeOcc; j++){
	       		  textRoom += `
	       		  
	       		  		<td style="width: \${tdWidth}px;"></td>
	       		  `;
	       		}
	       		
	       		
	       		 textRoom += ` 	        
			       	         </tr>				    		       
			       			</tbody>
			       	    	</table>
			       		   </div>   
			             `;
			    }

	
			   }
			roomList.html(textRoom);
			
			selectHsptlzstatus();
		},
		error: function (xhr, status, error) {
    	     console.log("code: " + xhr.status);
    	     console.log("message: " + xhr.responseText);
    	     console.log("error: " + error);
  	    }
	})
}
//4층병상 표 
function table4F(){
	console.log("table4F");
	let roomList = $("#f4");
	$.ajax({
		url : "/nurse/selectRoom",
		type : "get",
		dataType : 'JSON',
		success : function(rslt){
			console.log("방결과 (번호)" , rslt);
			console.log("rslt[0]" , rslt[0]);
			//console.log("rslt[0].sckrmNo",rslt[0].sckrmNo);
			textRoom = "";
			   for (let i = 0; i < rslt.length; i++) {
				   if (rslt[i].sckrmNo >= 400) {
					   
					   let sckrmTypeOcc = rslt[i].sckrmTypeOcc;

	                    setTdWidth(sckrmTypeOcc);
					  console.log("rslt[i].sckrmNo",rslt[i].sckrmNo)
			        textRoom += `
			            <p class="card-header" style="text-align:left; padding:17px 0px 0px 10px;font-size: 11px;">
			                \${rslt[i].sckrmNo}호(\${rslt[i].sckrmTypeOcc}인실)
			            </p> 
			             <div class="table-responsive text-nowrap tableDiv"style="height:83px; width:100%;">
			       		 <table class="table table-bordered ftable"style="font-size: 11px;">
			       			<thead>
			       
			       	         <tr>
			       	         `;
			  for(let j=1;j<=rslt[i].sckrmTypeOcc; j++){
				  textRoom += `  <th >\${j}번병상<button id="\${rslt[i].sckrmNo}\${j}"  type="button" class="btn btn-secondary choice" onclick="hospitRoom(\${j},\${rslt[i].sckrmNo})" >선택</button></th>`;
				  }
			  textRoom += ` </tr>
	       	       			</thead>
	       	     			 <tbody class="table-border-bottom-0 ptable">
	       		      		 <tr>`;
   		      	for (let j = 1; j <= rslt[i].sckrmTypeOcc; j++) {
   		          textRoom += `
   		              <td></td>
   		          `;
   		      }
	       		 textRoom += ` 	        
			       	         </tr>				    		       
			       			</tbody>
			       	    	</table>
			       		   </div>   
			             `;
			    }
			   }
			roomList.html(textRoom);
			selectHsptlzstatus();
		},
		error: function (xhr, status, error) {
    	     console.log("code: " + xhr.status);
    	     console.log("message: " + xhr.responseText);
    	     console.log("error: " + error);
  	    }
	})
}
function setTdWidth(sckrmTypeOcc) {
    let tdWidth = 100; // 기본 너비 (기본적으로 100px로 설정)
    
    if (sckrmTypeOcc === 2) {
        tdWidth = 60;
    } else if (sckrmTypeOcc === 4) {
        tdWidth = 40;
    } else if (sckrmTypeOcc === 6) {
        tdWidth = 30;
    }

    console.log("방 크기 td ", tdWidth);
    return tdWidth;
}

// 상태 업데이트
function hospitRoom(sckBdNo, sckrmNo,pThis) {
	
    //let vId = $('#'+sckrmNo+sckBdNo);
	console.log(sckrmNo, sckBdNo);
	console.log("환자 이름" , patName);
	console.log("의사의사" ,empNm);
	console.log("체킁:",$("#" + sckrmNo + sckBdNo).closest("table").find("tr").eq(1)[0]);
	let btnRoom = $("#" + sckrmNo + sckBdNo);
	let tdText = "환자명 : "+patName+"  담당의 : "+empNm;
	//btnRoom.closest("table").find("tr").eq(1).eq(sckBdNo-1).text(tdText);
	
	//$("#" + rslt[i].sckrmNo + rslt[i].sckBdNo).closest("table").find("tr").eq(1).children().eq(rslt[i].sckBdNo-1).html(patientInfo);
    if(patCode==''){
    	Swal.fire({
			icon: 'warning',
			title: '환자를 선택해 주세요',
			text: '',
			});
		return
    }
    console.log("patCode" , patCode);
        
    $.ajax({
    	type :"get",
    	url:"/nurse/updatehospitStatus/"+patCode+"/"+sckrmNo+"/"+sckBdNo,
    	//dataType:"JSON",
    	success: function(rslt){
    		
    		if(patName==""){
    			Swal.fire({
    				icon: 'error',
    				title: '환자를 선택해 주세요',
    				text: '',
    				});
    			return
    		}else{
    			Swal.fire({
    				icon: 'success',
    				title: '입원등록완료되었습니다.',
    				text: '',
    				});
			hospWait(); 
			patCode = '';
    		}
    	},
    	error: function (xhr, status, error) {
   	     console.log("code: " + xhr.status);
   	     console.log("message: " + xhr.responseText);
   	     console.log("error: " + error);
 	    }
    });
    
    $.ajax({
    	type:"get",
    	url:"/nurse/updateBdCondition/"+sckrmNo+"/"+sckBdNo,
		success: function(rslt){
		    console.log("rslt")	
    		
 
    	},
   		error: function (xhr, status, error) {
		   	     console.log("code: " + xhr.status);
		   	     console.log("message: " + xhr.responseText);
		   	     console.log("error: " + error);
		}
    })
}
// 입원환자 목록 출력
function selectHsptlzstatus(){
	let htable = $(".htable");
	let btnList = $(".choice");
    let patientInfo="";
    console.log("patCode" , patCode);
// 	for(let i=0; i<btnList.length; i++){
// 		btnList[0].removeAttr("disabled");
// 	}
	$.ajax({
		url :"/nurse/selectHsptlzstatus",
		type : 'get',
		dataType : 'JSON',
		success : function(rslt){
    		console.log("didididi",rslt);
    		text ="";
    		let tdText="";
    		let tbtextout ="";
    		for (let i = 0; i < rslt.length; i++) {
    			
    			console.log('상태가 4가 아니면 퇴출',rslt[i].patHsptlzStatus)
    			console.log('아오',rslt[i].hsptlzInDate);
    			console.log('아오',rslt[i].hsptlzOutDate);
    			console.log('아오',rslt[i].patHsptlzInDate);
    			console.log('아오',rslt[i].patHsptlzOutPlan);
    			if (rslt[i].patHsptlzStatus === '4') { // 환자 상태가 4인 경우 (입원 상태인 경우)
                    patientInfo = "환자명: " + rslt[i].patName + "<br />담당의: " + rslt[i].empNm
                    console.log(patientInfo);
                    text += `
                        <tr>
                            <td></td>
                            <td>\${rslt[i].patCode}</td>
                            <td>\${rslt[i].patName}</td>
                            <td>\${rslt[i].sckrmNo}호</td>
                            <td>\${rslt[i].sckBdNo}번 병상</td>
                            <td>\${rslt[i].patHsptlzInDate}</td>
                            <td>\${rslt[i].patHsptlzOutPlan}</td>
                        </tr>`;
                    


  					// 환자 정보를 해당 <td>에 추가하고 버튼을 비활성화
  					console.log("체킁:",$("#" + rslt[i].sckrmNo + rslt[i].sckBdNo).closest("table").find("tr").eq(1)[0]);
  					
                    tdText = $("#" + rslt[i].sckrmNo + rslt[i].sckBdNo).closest("table").find("tr").eq(1).children().eq(rslt[i].sckBdNo-1).html(patientInfo);
                    console.log("tdtext값 " , tdText.text());
                    
                   	$("#" + rslt[i].sckrmNo + rslt[i].sckBdNo).attr("disabled", "disabled");
                   	tdText.html(patientInfo);
                    tdText="";
	            	htable.html(text);
                    }else if(rslt[i].patHsptlzStatus === '5'){
                    	 console.log("else확인체크",rslt[i].patHsptlzStatus);
                    	 
                    	 updateBdConditionEmpt(rslt[i].sckrmNo ,rslt[i].sckBdNo);
                    	 
                    	$("#" + rslt[i].sckrmNo + rslt[i].sckBdNo).attr("disabled", false);
                    }
			}
				

	        },
	        error: function (xhr, status, error) {
	            console.log("code: " + xhr.status);
	            console.log("message: " + xhr.responseText);
	            console.log("error: " + error);
	        }
	    });
}
// function deleteRoom (sckrmNo,sckBdNo){
// 	onsole.log("확인하자  ",sckrmNo,sckBdNo);
// 	 $.ajax({
// 	    	type:"get",
// 	    	url:"/nurse/deleteRoom/"+sckrmNo+"/"+sckBdNo,
// 			success: function(rslt){
// 			    console.log("rslt" ,rslt)	
	    		
	 
// 	    	},
// 	   		error: function (xhr, status, error) {
// 			   	     console.log("code: " + xhr.status);
// 			   	     console.log("message: " + xhr.responseText);
// 			   	     console.log("error: " + error);
// 			}
// 	    })
// 	}
function updateBdConditionEmpt(sckrmNo,sckBdNo){
	
	console.log("확인하자  --",sckrmNo,sckBdNo);
	 $.ajax({
	    	type:"get",
	    	url:"/nurse/updateBdConditionEmpt/"+sckrmNo+"/"+sckBdNo,
			success: function(rslt){
			    console.log("rslt 확인되나?" ,rslt)	
	    		
	 
	    	},
	   		error: function (xhr, status, error) {
			   	     console.log("code: " + xhr.status);
			   	     console.log("message: " + xhr.responseText);
			   	     console.log("error: " + error);
			}
	    })
	}

</script>

<div class="grid-stack"></div>
<script type="text/javascript">




	// 그리드 스택 아이템 정의
	let gridStack1 = `<div id="div1" style=" height:100%; padding:0px; overflow: none;">
						<div class="tab-content" style="height : 650px; background-color:white; padding:0px;" id="gr1Content">
							</div>
					     </div>`;
					     
	let gridStack2 = `<div class="nav-align-top mb-4 grid2">
     					 <ul class="nav nav-tabs" role="tablist">
       						 <li class="nav-item" role="presentation">
          						<button type="button"  id="btn3F" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#f3" aria-controls="f3" aria-selected="true">3층</button>
        					 </li>
        					 <li class="nav-item" role="presentation">
         						 <button type="button" id="btn4F"  class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#f4" aria-controls="f4" aria-selected="false" tabindex="-1">4층</button>
        					 </li>
      					 </ul>
						 <div class="tab-content" style="padding:0px;">
							<div class="tab-pane fade show active" id="f3" role="tabpanel">
							</div>
							<div class="tab-pane fade" id="f4" role="tabpanel">
							
							</div>
						 </div>
					   </div>`;
				
	
    let gridStack3 = `<div id="prescriptionList" style="width:100%; height:100%; padding:20px 20px 20px 20px; background-color:white;">
					    	<div class="card" style="height:100%;">
					    	
					    		<div style="display:flex"> 
					    			
									<h5 class="pb-2 border-bottom mb-4" style="text-align:left; font-weight: bold;">입원환자 목록</h5>
									
					    		</div>
									 <div class="table-responsive text-nowrap"style="height:100%;">
					 				 <table class="table table-hover"style="font-size: 11px;">
					    				<thead>
					    		          <tr>
					    		            <th></th>
					    		            <th>환자코드</th>
					    		            <th>환자명</th>
					    		            <th>병실</th>
					    		            <th>병상</th>
					    		            <th>입원일</th>
					    		            <th>퇴원일(예정)</th>
					    		          </tr>
					    		        </thead>
					    		       <tbody class="table-border-bottom-0 htable">
					    		       
		             			</tbody>
			                 	</table>
			            	   </div>
			            	 </div>
					</div>`;
						
// 그리드 스택 아이템 배열
var items = [
    { w: 2, h: 5, float: false, content: gridStack1 },
    { w: 5, h: 5, float: false, content: gridStack2 },
    { w: 5, h: 5, float: false, content: gridStack3 }

];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
</script>

<script>
const hospWaitList = $('#gr1Content');

// 대기환자 목록 출력
function hospWait(){
	$.ajax({
		url :"/nurse/hospWait",
		type : 'get',
		dataType : 'JSON',
		success : function(rslt){
			
			console.log("결과 나와??" , rslt);
			var text = '';

	 		text += `
				<table class="table table-hover"style="text-align : left;">
				 <thead>
					 <tr> 
					 	<th style="text-align : center;">
			 				<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
								<div style="display:flex; width:177px;">
				 		
				 					<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
				 					<p style="margin: 8px 0px 0px 6px;">입원대기 :\${rslt.length}명</p>
				 		
			 					</div>
								</h5>
								<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: 0px 117px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;"> 간호사    | 담당 : ${empVO.empNm}</span>
							</th>
						</tr> 
					</thead>
 		`;
		$.each(rslt, function(i,item){	
				text += `
						<tbody>
		 					<tr>
			 					<td style="padding:1rem;">
					       		 <h5 class="mb-0"><strong>\${item.patName}</strong> <small></small></h5>

					       	
						        	<div style="display: flex; justify-content: space-between; align-items: center;">
									<div>
										<h6 class="mb-0"><small> \${item.patBrthdy} | \${item.patGen} | \${item.patFirst} </small></h6>
									</div>
						            <div style="margin-right: 56px;">
						            <button id="${item.patCode}" class="btn btn-xs btn-info" style="margin-bottom:10px;" onclick="waitClick('\${item.patName}',\${item.patCode},\${item.treatNo},\${item.detailNo},'\${item.empNm}')">
			 						\${item.patHsptlzStatus === "3" ? "입원등록" : item.patHsptlzStatus}</button>
						            </div>
						        </div>
					   		</td>						
			 					</tr>`;
		})
	 			text += `		
	 					</tbody>
				</table>`;
			
					hospWaitList.html(text);
					selectHsptlzstatus();
		},
		error: function (xhr, status, error) {
     	     console.log("code: " + xhr.status);
     	     console.log("message: " + xhr.responseText);
     	     console.log("error: " + error);
   	    }
	})
}
let patCode="";
let empNm ="";
let patName ="";
function waitClick(patName1,patCode1,treatNo,detailNo,empNm1){

	patCode= patCode1;
	empNm = empNm1;
	patName = patName1;
	console.log("선택된 환자코드",patCode);
	console.log("선택된 접수코드",treatNo);
	console.log("선택된 환자차트",detailNo);
	console.log("선택된 환자의 담당의 " , empNm);
	console.log("선택된 환자의 이름 " , patName);
	Swal.fire({
		icon: 'success',
		title: '입원등록 하시겠습니까?',
		text: '',
		});
}



function fMessage() { // 받는쪽에 작성
	let serverMsg = JSON.parse(event.data);
	console.log("serverMsg", serverMsg);
	
	if (serverMsg.cmd == "alarm") {
		getNotiList();
	}
	// 임원 대기
	if (serverMsg.cmd == "okHosp") {
		hospWait();
	}

}

</script>
