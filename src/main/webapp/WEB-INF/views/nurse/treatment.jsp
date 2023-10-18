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
/* 첫번째 */
.gs-id-0 > .grid-stack-item[gs-h="5"] {
    height: 790px;
}
.gs-id-0 > .grid-stack-item[gs-h="2"] {
    height: 382px;
}
.gs-12>.grid-stack-item[gs-w="2"] {
    width: 296px;
 }
/*두번째*/
 .gs-id-0 > .grid-stack-item[gs-x="2"] {
    left: 287px;
}
.gs-id-0 > .grid-stack-item[gs-h="3"] {
    height: 416px;
}
.gs-12>.grid-stack-item[gs-w="3"] {
    width: 441px;
}
.gs-12>.grid-stack-item[gs-w="7"] {
    width: 1160px;
}
.gs-id-0 > .grid-stack-item[gs-y="3"] {
    top: 407px;
}
.gs-id-0 > .grid-stack-item[gs-x="5"] {
    left: 720px;
}
.gs-12>.grid-stack-item[gs-x="6"] {
    left: 901px;
}
.gs-12>.grid-stack-item[gs-w="6"] {
    width: 979px;
}
</style>

<div class="grid-stack"></div>

<script type="text/javascript">
$(function() {
	treatmentWait();

});


	// 그리드 스택 아이템 정의
	let gridStack1 = `<div id="div1" style=" height:100%; padding:0px; overflow: none;">
						<div class="tab-content" style="height : 650px; background-color:white; padding:0px;" id="gr1Content">
							</div>
					  </div>`;
					     
	let gridStack2 = `<div style="background-color:white; width:100%; height:100%;">
		<div class="card-body" style="width:100%; height:100%; padding:20px 0px 20px 20px;">
		<div style="display:flex;">
	    <div>
	        <h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold;">환자정보 </h5>
	    </div>
	    </div>
	    <div class="info-container"style="width:100%;">
        <div class="row">
        <div class="col-md-6" style="width:100%;">
          <ul class="list-unstyled"  style="text-align : left;">
            
          <li class="mb-3"> 
            <input type="hidden" name="rceptNo" class="form-control form-control-sm" id="rceptNo0" style="border:none;">
               <span class="fw-medium me-2" style="display:inline-block; width:80px;margin-left: 7px;" >환자코드</span>
               <input type="text" name="patCode" class="form-control form-control-sm" id="patCode0" style="width:67%;" readonly>
             
            </li>
            <li class="mb-3">
               <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">이름</span>
               <input type="text" name="patName" class="form-control form-control-sm " id="patName0" style="width:67%;" readonly>

            
            </li>
            <li class="mb-3">
	           <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">연락처</span>
               <input type="text" name="patTel" class="form-control form-control-sm" id="patTel0" style="width:67%;" readonly>
              
            </li>

            <li class="mb-3">
               <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">최초내원일</span>
               <input type="text" name="patFirstDate" class="form-control form-control-sm" id="patFirstDate0" style="width:67%;" readonly>
            </li>
            <li class="mb-3">
            	<span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">최근내원일</span>
           		<input type="text" name="patLastDate" class="form-control form-control-sm" id="patLastDate0" style="width:67%;" readonly>
            </li>
            <li class="mb-3">
            <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">기본주소</span>
            <input type="text" name="patAddr" class="form-control form-control-sm" id="patAddr0" style="width:67%;" readonly>

            </li>
            
            <li class="mb-3">
            <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px">상세주소</span>
            <input type="text" name="patDtlAddr" class="form-control form-control-sm" id="patDtlAddr0" style="width:67%;" readonly><br>
            </li>

          </ul>
          </div>
          </div>
        </div>
      </div>
      </div>`;
	
	
    let gridStack3 = `<div id="prescriptionList" style="width:100%; height:100%; padding:20px 20px 20px 20px;background-color:white;">
					    	<div class="card" style="height:87%;">
							<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:1024px; font-weight: bold;">처방등록 </h5>
									 <div class="table-responsive text-nowrap"style="height:300px;">
					 				 <table class="table table-hover"style="font-size: 11px;">
					    				<thead>
					    		          <tr>
					    		            <th>NO.</th>
					    		            <th>약품코드</th>
					    		            <th>약품명</th>
					    		            <th>먀약성여부</th>
					    		            <th>투약량</th>
					    		            <th>투약횟수</th>
					    		            <th>투약일수</th>
					    		            <th>재고(단위)</th>
					    		            <th></th>
					    		          </tr>
					    		        </thead>
					    		       <tbody class="table-border-bottom-0 ptable">
					    		       
				             			</tbody>
					                 	</table>
					            	   </div>
					            	 </div>
					         <button type="button" id="presbtn" onclick="fPresBtn()" class="btn btn-primary" style= "margin:20px 10px 10px 0px; position: absolute; bottom: 0; right: 0;">완료</button>
					</div>`;
						
		let gridStack4 = `<div style="background-color:white; width:100%; height:100%; padding:20px 20px 20px 20px;">
							<div class="card" style="height:100%;">
							<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:423px; font-weight: bold;">마약성 약품 이력 </h5>
							
									 <div class="table-responsive text-nowrap"style="height:300px;">
										 <table class="table table-hover"style="font-size: 11px;">
						   				<thead>
						   		          <tr>
						   		            <th>약품 코드</th>
						   		            <th>약품 명</th>
						   		            <th>수량</th>
						   		            <th>날짜</th>
						   		          </tr>
						   		        </thead>
						   		       <tbody class="table-border-bottom-0 nartable">
						   		       
						           			</tbody>
						                	</table>
						           	   </div>
							
			
						</div>`;
		let gridStack5 = `<div id="treatmentList"style="width:100%; height:100%; padding:20px 20px 20px 20px;background-color:white;"">
						<div class="card" style="height:87%;">
						<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:840px; font-weight: bold;">처치 등록</h5>
								 <div class="table-responsive text-nowrap"style="height:300px;">
				 				 <table class="table table-hover"style="font-size: 11px;">
				    				<thead>
				    		          <tr>
				    		            <th>No.</th>
				    		            <th>처치코드</th>
				    		            <th>처치내용</th>
				    		            <th>처치메모</th>
				    		            <th></th>
				    		          </tr>
				    		        </thead>
				    		       <tbody class="table-border-bottom-0 ttable">
				    		       
			             			</tbody>
				                 	</table>
				            	   </div>
				            	   </div>
				    		      <button type="button" id="treatbtn" onclick="fTreatbtn()"  class="btn btn-primary" style= "margin:20px 10px 10px 0px; position: absolute; bottom: 0; right: 0;">완료</button>
					</div>`;
	
// 그리드 스택 아이템 배열
var items = [
    { w: 2, h: 5, float: false, content: gridStack1 },
    { w: 3, h: 3, float: false, content: gridStack2 },
    { w: 7, h: 3, float: false, content: gridStack3 },
    { w: 4, h: 2, float: false, content: gridStack4 },
    { w: 6, h: 2, float: false, content: gridStack5 }

];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
const treatWaitList = $('#gr1Content');

function treatmentWait (){
	$.ajax({
		url :`/nurse/treatmentWait`,
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
					 					<p style="margin: 8px 0px 0px 6px;">처방대기 : \${rslt.length}명</p>
					 		
				 					</div>
									</h5>
									<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: 0px 117px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;"> 간호사    | 담당 : ${empVO.empNm}</span>
								</th>
							</tr> 
						</thead>
							<tbody>
	 		`;
			$.each(rslt, function(i,item){
				let buttonText = "처치대기"; // 기본 버튼 텍스트
				let buttonClass = "btn btn-xs btn-info"; // 기본 버튼 클래스
				console.log("item.patWait", item.patWait);
				if (item.patWait == '처치중') {
					buttonText = "처치중";
					buttonClass = "btn btn-xs btn-secondary";
				}
				
					text += `
			 					<tr>
				 					<td style="padding:1rem;">
						       		 <h5 class="mb-0" style="margin-left:5px; margin-top:5px;"><strong>\${item.patName}</strong> <small>| \${item.patBrthdy}</small></h5>
							        	<div style="display: flex; justify-content: space-between; align-items: center;">
										<div>
											<h6 class="mb-0" style="margin-left : 6px;"><small>\${item.patGen} | \${item.patFirst} | \${item.patHsptlzStatus} </small></h6>
										</div>
							            <div style="margin-right: 5px; margin-top:5px;">
								            <button id="\${item.patCode}" class="\${buttonClass}" style="margin-bottom:10px; margin-right:55px; margin-top : -20px;" onclick="waitClick(\${item.patCode},\${item.treatNo},\${item.detailNo})">
								            \${buttonText}</button>
							            </div>
							        </div>
						   		</td>						
 			 					</tr>`;
			})
		 			text += ` </tbody>
						</table>`;
					treatWaitList.html(text);
		},
		error: function (xhr, status, error) {
     	     console.log("code: " + xhr.status);
     	     console.log("message: " + xhr.responseText);
     	     console.log("error: " + error);
   	    }
	})
}
let treatNoUp = "";
function waitClick(patCode,treatNo,detailNo){
	var callButton = event.target;
	let tablePre =$(".ptable");
	let tableTre =$(".ttable");
	let tableNar =$(".nartable");
	let button = $("#"+patCode);
	console.log("버튼 확인 되냐궁", callButton);
	console.log("버튼 확인 되냐궁", button);
	treatNoUp = treatNo;
    // 버튼의 스타일을 변경합니다.
    
  	// 버튼의 클래스를 변경합니다.

  	
	console.log("내가선택한 환자 코드 입니다.",patCode);
	console.log("내가선택한 환자 접수 번호 입니다.",treatNo);
	console.log("내가선택한 환자 접수 번호 입니다222.",treatNoUp);
	console.log("내가선택한 환자 차트  번호 입니다.",detailNo);
	Swal.fire({
		icon: 'success',
		title: '환자를 호출했습니다.',
		text: '',
		});
	$.ajax({
		url :"/nurse/waitpatClick/"+patCode+"/"+treatNo+"/"+detailNo,
		type : 'get',
		dataType : 'JSON',
		success : function(rslt){
			console.log("뭐 나와 ? ",rslt.patientVO);
			console.log("뭐 나와 ? ",rslt.treatmentMediVOList[0]);
			console.log("뭐 나와 ? ",rslt.treatmentListVOList[0]);
			console.log("나오냐아아?",rslt.prescriptionVOList[0]);
			$("#patCode0").val(rslt.patientVO.patCode); 		// 환자코드
			$("#patTel0").val(rslt.patientVO.patTel);	  		// 연락처
			$("#patDtlAddr0").val(rslt.patientVO.patDtlAddr);	// 상세 주소
			let frgnrYn;
			if(rslt.patientVO.patFrgnryn=='부'){
				frgnrYn = '내국인';
			}else{
				frgnrYn = '외국인';	
			}
			let patName = rslt.patientVO.patName;
			let genCode = rslt.patientVO.patGenCode;
			let Brthdy = rslt.patientVO.patBrthdy;
			let patHsptlzStatus = rslt.patientVO.patHsptlzStatus;
			
			// 이름 | 생년월일 | 성별 | 국내외 | 진료 구분|
			let textPat = patName + " " + "|" + " " + Brthdy + " " + "|" + " " +genCode + " " + "|" + " " +frgnrYn + " " + "|" + " " +patHsptlzStatus;
			$("#patName0").val(textPat);
			
			let patAddr = rslt.patientVO.patAddr;
			let patZip = rslt.patientVO.patZip;
			var AddrZip = patAddr + " " + "(" + patZip + ")";
			$("#patAddr0").val(AddrZip);
			
			 $("#patFirstDate0").val(rslt.patientVO.patFirstDate);
             $("#patLastDate0").val(rslt.patientVO.patLastDate);
             let textPres = '';
             for(let i =0; i<rslt.treatmentMediVOList.length; i++){
            	 console.log("강혁쳌",rslt.treatmentMediVOList[i]);
            	 if(rslt.treatmentMediVOList[i].narcoticYn == 'Y'){
            		 
            	 textPres +=`
			            	 <tr>
			                     <td>\${i+1}</td>
			                     <td>\${rslt.treatmentMediVOList[i].mediItemCode}</td>
			                     <td>\${rslt.treatmentMediVOList[i].mediItemName}</td>
			                     <td>\${rslt.treatmentMediVOList[i].narcoticYn}</td>
			                     <td>\${rslt.treatmentMediVOList[i].prscrptnAmount}</td>
			                     <td>\${rslt.treatmentMediVOList[i].prscrptnCount} </td>
			                     <td>\${rslt.treatmentMediVOList[i].prscrptnDays} </td>
			                   `;
			           if(rslt.treatmentMediVOList[i].mediItemInvrQty<=rslt.treatmentMediVOList[i].mediItemLeastQty){
			            	  textPres +=`<td style="color:red;">\${rslt.treatmentMediVOList[i].mediItemInvrQty}( \${rslt.treatmentMediVOList[i].mediItemUnit} )</td>`;
			             }else{
			            	 textPres +=`<td>\${rslt.treatmentMediVOList[i].mediItemInvrQty}( \${rslt.treatmentMediVOList[i].mediItemUnit} )</td>`;
			             }
			    textPres+=`<td><button type="button" onclick="OKbtn(\${rslt.treatmentMediVOList[i].mediItemCode},\${rslt.treatmentMediVOList[i].prscrptnTotal},\${rslt.treatmentMediVOList[i].mediItemInvrQty})" class="btn btn-primary okPbtn" style="font-size : 11px;">확인</button></td>
			                 </tr>
			                 `;
            	 }
             }
             let textTre ='';
             for(let i=0; i<rslt.treatmentListVOList.length; i++){
            	 console.log("처치등록 리스트",rslt.treatmentListVOList[i]);
            	 textTre +=`
            		 <tr>
                     <td>\${i+1}</td>
                     <td>\${rslt.treatmentListVOList[i].treCode}</td>
                     <td>\${rslt.treatmentListVOList[i].treContent}</td>
                     <td>\${rslt.treatmentListVOList[i].treMemo}</td>
                     <td><button type="button" onclick="OKbtnitem()" class="btn btn-primary okTbtn" style="font-size : 11px;">확인</button></td>
            	 `;
             }
             let textNar = '';
             if(rslt.prescriptionVOList.length  > 0 ){
             	for(let i=0; i<rslt.prescriptionVOList.length; i++){
             		
            	 	 console.log("마약성이력 약품" , rslt.prescriptionVOList[i]);
            		 console.log(" 있을때 마약성이력 수 확인",rslt.prescriptionVOList[i].length);
	            	 textNar += `
	            		 <tr>
	                     <td>\${rslt.prescriptionVOList[i].mediItemCode}</td>
	                     <td>\${rslt.prescriptionVOList[i].mediItemName}</td>
	                     <td>\${rslt.prescriptionVOList[i].calculatedValue}</td>
	                     <td>\${rslt.prescriptionVOList[i].detailRegDateStr}</td>
	            	 `;
             		}
	            	 
            	 }else{
            		 console.log("마약성이력 수 확인", rslt.prescriptionVOList.length);
            		 textNar += `<td style="padding:20px; text-align:center; " colspan="4"> 마약성 약품 이력이 없습니다. </td>`;
            	 }
				
             tablePre.html(textPres);
             tableTre.html(textTre);
             tableNar.html(textNar);
             updateTreatSttusIng();
             let msg = {
  					to: "원무",
  					from: "간호",
  					cmd: "ingTreat"
  			}
             webSocket.send(JSON.stringify(msg));
             console.log(msg, "처방중");
		},
		error: function (xhr, status, error) {
    	     console.log("code: " + xhr.status);
    	     console.log("message: " + xhr.responseText);
    	     console.log("error: " + error);
    	 }
	})
}

function updateTreatSttusIng(){
	$.ajax({
		url : "/nurse/updateTreatSttusIng/"+treatNoUp,
		type : "get",
		dataType : "JSON",
		success : function(rslt){
			console.log("rslt " , rslt);
			if(rslt == 1 ){
				console.log("조심히가세요");
			}
			treatmentWait();
		},
		error: function(xhr, status, error) {
    	    console.log("code: " + xhr.status);
    	    console.log("message: " + xhr.responseText);
    	    console.log("error: " + error);
    	}
	});	
}
	function OKbtn(fmediItemCode,fprscrptnTotal,mediItemInvrQty){
		var OKbtn = event.target;
		var table = $(OKbtn).closest("tr");
		var td = table.find("td:eq(7)");
		var tdText = td.text();
		
 		console.log("OKbtntr", tdText);
		console.log("약품 수량 update",fmediItemCode,fprscrptnTotal,mediItemInvrQty);
		var index = tdText.indexOf('(');
	 		
		if(fprscrptnTotal>mediItemInvrQty){
			Swal.fire({
				icon: 'error',
				title: '',
				text: '수량이부족합니다.',
				});
			return
		}else if (index !== -1) {
		    let substring = tdText.substring(index); // 처음부터 괄호 직전까지의 문자열을 자릅니다
		    let total =(mediItemInvrQty-fprscrptnTotal)+substring;
		    td.text(total);
		}{
			
		mediQty(fmediItemCode,fprscrptnTotal);
		OKbtn.className = "btn btn-secondary";
		OKbtn.innerHTML = "완료";
		 if (OKbtn.innerHTML === "완료") {
		        OKbtn.className = "btn btn-secondary";
		        OKbtn.disabled = true; // Disable the button
		    }
		}
	}
	function OKbtnitem(){
		var OKbtnitme = event.target;
		OKbtnitme.className = "btn btn-secondary";
		OKbtnitme.innerHTML = "완료";
		 if (OKbtnitme.innerHTML === "완료") {
			 OKbtnitme.className = "btn btn-secondary";
		        OKbtn.disabled = true; // Disable the button
		    }
	}
	//약품 수량 줄이기 
	function mediQty (fmediItemCode,fprscrptnTotal){
		console.log("약품 코드 들어옴 ?",fmediItemCode);
		console.log("약품 수량 들어옴 ?",fprscrptnTotal);
		
		let mediItemCode = fmediItemCode;
		let prscrptnTotal = fprscrptnTotal;
		
		
 		$.ajax({
 			url : "/nurse/mediQty/"+mediItemCode+"/"+prscrptnTotal,
 			type : "get",
 			dataType : "JSON",
 			success : function(rslt){
 				console.log("rslt " , rslt);
 				if(rslt == 1 ){
		
 				console.log("처방 수량  - ");
 				}else{
 					Swal.fire({
 						icon: 'error',
 						title: '',
 						text: '실패하였습니다.',
 						});
 				}
// 여기서 리스트 다시 뽑아서 수량 줄어든거 보이고 싶음
 			},
 			error: function(xhr, status, error) {
         	    console.log("code: " + xhr.status);
         	    console.log("message: " + xhr.responseText);
         	    console.log("error: " + error);
         	}
 		})
	}
	
	function fPresBtn(){
		let okPbtn = document.querySelectorAll('.okPbtn');
		for(let i = 0; i< okPbtn.length; i++){
			let flag = okPbtn[i].innerHTML;
			if(flag != "완료"){
				Swal.fire({
					icon: 'error',
					title: '',
					text: '모두 확인해주세요',
					});
				return;
			}	
		}
		Swal.fire({
			icon: 'success',
			title: '완료!',
			text: '처리되었습니다.',
			});
		clearPTable();
	}
	
	// 환자 상세 정보 input 지우는 함수
	function clearInputFields() {
	    
	    $(".col-md-6 input").each(function () {
	        $(this).val(""); // 각 input 빈 문자열
	    });
	}
	// 테이블 안의 tr td 지우는 함수 
	function clearPTable() {
	    var ptable = $(".ptable");
	    ptable.find("tr").remove(); // Remove all tr elements
	}
	//  테이블의 모든 tr 및 td 내용을 지우는 함수
// 	function clearTTable() {
// 	    var ttable = $(".ttable"); 
// 	    ttable.each(function () {
// 	        var rows = $(this).find("tr");

// 	    rows.each(function () {
// 	        var cells = $(this).find("td"); 
// 	        cells.empty(); 
// 	    });
// 	   });
// 	}
	function clearTTable() {
		var ttable = $(".ttable");
		ttable.find("tr").remove();
		}
	function clearNTable() {
		var nartable = $(".nartable");
		nartable.find("tr").remove();
		}
	function fTreatbtn(){
		let okTbtn = document.querySelectorAll('.okTbtn');
		for(let i = 0; i< okTbtn.length; i++){
			let flag = okTbtn[i].innerHTML;
			if(flag != "완료"){
				Swal.fire({
					icon: 'error',
					title: '',
					text: '모두 확인해주세요',
					});
				return;
			}
		}		
			//여기에 간호사 진행 상태 update 하기 
			$.ajax({
				url : "/nurse/updateTreatSttus/"+treatNoUp,
				type : "get",
				dataType : "JSON",
				success : function(rslt){
					console.log("rslt " , rslt);
					if(rslt == 1 ){
						Swal.fire({
							icon: 'success',
							title: '완료되었습니다.',
							text: '',
						});
					let msg = {
						to: "간호사",
						from: "원무과",
						cmd: "endClinic"
					}
					webSocket.send(JSON.stringify(msg));

					console.log(msg, "처방 완료");
					}else{
						Swal.fire({
							icon: 'error',
							title: '',
							text: '실패하였습니다.',
							});
					}
					clearInputFields();
					clearTTable();
					clearNTable();
					treatmentWait();
				},
				error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
			});	
	}
	
	
	function fMessage() { // 받는쪽에 작성
		let serverMsg = JSON.parse(event.data);
		console.log("serverMsg", serverMsg);
		if (serverMsg.cmd == "alarm") {
			getNotiList();
		}
		// 처방/ 처치 대기
		if (serverMsg.cmd == "endPhysio") {
			treatmentWait();
		}

	}
</script>



