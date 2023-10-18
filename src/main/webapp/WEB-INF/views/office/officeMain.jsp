<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 
<link href="../resources/css/demo.css" rel="stylesheet"/> 
<style>
.mygrid{
	border : 1px solid black;
}
.mygrid-title{
	text-align : right;
	font-size : 0.8 rem;
}

</style>

<div class="grid-stack"></div> 
<script type="text/javascript">


$(function(){

	getPatList();
	
});
	var gr1 = 
		`
		<div style="background-color : #e7e9ed; height : 100%;"> <strong><p id="gr1">1진료실</p></strong>    
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			        	<button class="nav-link" style="background-color: #fff;" id="gr1Btn"></button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr1Content">
			        

			        
			    </div>
			</div>
		</div>
		`;
	var gr2 = 
		`
<div style="background-color : #e7e9ed; height : 100%;"> <strong><p id="gr2">2진료실</p></strong>
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			        	<button class="nav-link" style="background-color: #fff;" id="gr2Btn"></button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr2Content">
			        

			        
			    </div>
			</div>
		</div>
		`;
	var gr3 = 
		`
		<div style="background-color : #e7e9ed; height : 100%;"> <strong><p id="gr3">3진료실</p></strong>
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			        	<button class="nav-link" style="background-color: #fff;" id="gr3Btn"></button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr3Content">
			        

			        
			    </div>
			</div>
		</div>
		`;
	var gr4 = 
		`
		<div style="background-color : #e7e9ed; height : 100%;"> <strong><p id="gr4">4진료실</p></strong>
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			        	<button class="nav-link" style="background-color: #fff;" id="gr4Btn"></button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr4Content">
			        

			        
			    </div>
			</div>
		</div>
		`;
	var gr5 = 
		`
		<div style="background-color : #e7e9ed; height : 100%;"> <strong><p>오더수행중</p></strong>
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			            <button class="nav-link" style="background-color: #fff;" id="gr5Btn">대기(3)</button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr5Content">
			    </div>
			</div>
		</div>
		`;
	var gr6 = 
		`
		<div style="background-color : #e7e9ed; height : 100%;"> <strong><p>수납</p></strong>
			<div class="nav-align-top mb-3" ><br>
			    <ul class="nav nav-tabs" role="tablist">
			        <li class="nav-item" role="presentation">
			        	<button class="nav-link" style="background-color: #fff;" id="gr6Btn">대기(3)</button>
			        </li>
			    </ul>
			    <div class="tab-content" style="height : 650px;" id="gr6Content">
			    </div>
			</div>
		</div>
		`;
	
    var items = [ 
	   {w: 2, h:5, x:0, y:0, content: gr1}, 
	   {w: 2, h:5, x:2, y:0, content: gr2},
	   {w: 2, h:5, x:4, y:0, content: gr3},
	   {w: 2, h:5, x:6, y:0, content: gr4},
	   {w: 2, h:5, x:8, y:0, content: gr5},
	   {w: 2, h:5, x:10, y:0, content: gr6}
   ];
   
    var grid = GridStack.init(); grid.load(items);
	const $gr1 = $('#gr1');
	const $gr2 = $('#gr2');
	const $gr3 = $('#gr3');
	const $gr4 = $('#gr4');
	const $gr5 = $('#gr5');
	const $gr6 = $('#gr6');
	const $gr1Content = $('#gr1Content');
	const $gr2Content = $('#gr2Content');
	const $gr3Content = $('#gr3Content');
	const $gr4Content = $('#gr4Content');
	const $gr5Content = $('#gr5Content');
	const $gr6Content = $('#gr6Content');
	const $gr1Btn = $('#gr1Btn');
	const $gr2Btn = $('#gr2Btn');
	const $gr3Btn = $('#gr3Btn');
	const $gr4Btn = $('#gr4Btn');
	const $gr5Btn = $('#gr5Btn');
	const $gr6Btn = $('#gr6Btn');
	function getPatList(){
		$.ajax({
			url : "/office/patList",
			type : "get",
			dataType : "json",
			success : function(result){
				console.log("제발용",result);
				let txt1 = "";
				let txt2 = "";
				let txt3 = "";
				let txt4 = "";
				let txt5 = "";
				let txt6 = "";
				let c1 = 0;
				let c2 = 0;
				let c3 = 0;
				let c4 = 0;
				let c5 = 0;
				let c6 = 0;
				for(let i =0; i<result.length; i++){
					let r = result[i];
					let rDate = r.receptTime.substring(0, 10);
					console.log("rDate",rDate);
					console.log("rrrrr",r);
					if(r.patWait == '진료대기'){
						if(r.hosFcName == '1진료실'){
							c1 += 1;
							txt1 += `
					        	<table style="width : 100%; text-align : left; border-bottom : 1px solid lightgray; margin-bottom : 15px;">
					    			<tr>
					    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%;"><strong>\${r.patName}</strong><span style="font-size : 0.7rem;">(\${r.patAge})<span></td>
					    				<td style="text-align : right;"><button onclick="cancelClinic('\${r.treatNo}')" style="height : 25px; padding : 3px 7px;" class="btn btn-xs btn-secondary">X</button></td>
					    			</tr>
					    			<tr>
					    				<td style="width : 65%;"><span style="font-size : 0.7rem;">\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}<span></td>
					    				<td style="text-align : right;"><button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button></td>
					    			</tr>
				   				</table>
							`;
						}
						if(r.hosFcName == '2진료실'){
							c2 += 1;
							txt2 += `
						    	<table style="width : 100%; text-align : left; border-bottom : 1px solid lightgray; margin-bottom : 15px;">
					    			<tr>
					    				<td onclick="tClick('\${r.patCode}','\${r.treatNo}','\${rDate}')"style="width : 65%;"><strong>\${r.patName}</strong><span style="font-size : 0.7rem;">(\${r.patAge})<span></td>
					    				<td style="text-align : right;"><button onclick="cancelClinic('\${r.treatNo}')" style="height : 25px; padding : 3px 7px;" class="btn btn-xs btn-secondary">X</button></td>
					    			</tr>
					    			<tr >
					    				<td style="width : 65%;"><span style="font-size : 0.7rem;">\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}<span></td>
					    				<td style="text-align : right;"><button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button></td>
					    			</tr>
			   					</table>
							`;
						}
						if(r.hosFcName == '3진료실'){
							c3 += 1;
							txt3 += `
						    	<table style="width : 100%; text-align : left; border-bottom : 1px solid lightgray; margin-bottom : 15px;">
					    			<tr>
					    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%;"><strong>\${r.patName}</strong><span style="font-size : 0.7rem;">(\${r.patAge})<span></td>
					    				<td style="text-align : right;"><button onclick="cancelClinic('\${r.treatNo}')" style="height : 25px; padding : 3px 7px;" class="btn btn-xs btn-secondary">X</button></td>
					    			</tr>
					    			<tr>
					    				<td style="width : 65%;"><span style="font-size : 0.7rem;">\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}<span></td>
					    				<td style="text-align : right;"><button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button></td>
					    			</tr>
			   					</table>
							`;
						}
						if(r.hosFcName == '4진료실'){
							c4 += 1;
							txt4 += `
						    	<table style="width : 100%; text-align : left; border-bottom : 1px solid lightgray; margin-bottom : 15px;">
					    			<tr>
					    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%;"><strong>\${r.patName}</strong><span style="font-size : 0.7rem;">(\${r.patAge})<span></td>
					    				<td style="text-align : right;"><button onclick="cancelClinic('\${r.treatNo}')" style="height : 25px; padding : 3px 7px;" class="btn btn-xs btn-secondary">X</button></td>
					    			</tr>
					    			<tr>
					    				<td style="width : 65%;"><span style="font-size : 0.7rem;">\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}<span></td>
					    				<td style="text-align : right;"><button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button></td>
					    			</tr>
			   					</table>
							`;
						}
					}else if(r.patWait == '진료중'||r.patWait == '검사중'||r.patWait =='검사완료'||r.patWait =='검사대기'){
						if(r.hosFcName == '1진료실'){
							c1 += 1;
							txt1 += `
								<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
				    			<tr>
				    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%; padding:0px;">
				    					<strong>\${r.patName}</strong>
				    					<span style="font-size : 0.7rem;">(\${r.patAge})<span>
				    					<div style="display : flex; justify-content: space-between;">
				    						<div style="font-size:11px; margin:5px 0px 0px 0px;">
				    							\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
				    						</div>
				    						<div style="margin: 0px 5px 10px 0px;">
				    							<button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button>
				    						</div>
				    					</div>
				    				</td>
				    			</tr>
		   					</table>
							`;
						}
						if(r.hosFcName == '2진료실'){
							c2 += 1;
							txt2 += `
								<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
				    			<tr>
				    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%; padding:0px;">
				    					<strong>\${r.patName}</strong>
				    					<span style="font-size : 0.7rem;">(\${r.patAge})<span>
				    					<div style="display : flex; justify-content: space-between;">
				    						<div style="font-size:11px; margin:5px 0px 0px 0px;">
				    							\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
				    						</div>
				    						<div style="margin: 0px 5px 10px 0px;">
				    							<button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button>
				    						</div>
				    					</div>
				    				</td>
				    			</tr>
		   					</table>
							`;
						}
						if(r.hosFcName == '3진료실'){
							c3 += 1;
							txt3 += `
								<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
				    			<tr>
				    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%; padding:0px;">
				    					<strong>\${r.patName}</strong>
				    					<span style="font-size : 0.7rem;">(\${r.patAge})<span>
				    					<div style="display : flex; justify-content: space-between;">
				    						<div style="font-size:11px; margin:5px 0px 0px 0px;">
				    							\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
				    						</div>
				    						<div style="margin: 0px 5px 10px 0px;">
				    							<button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button>
				    						</div>
				    					</div>
				    				</td>
				    			</tr>
		   					</table>
							`;
						}
						if(r.hosFcName == '4진료실'){
							c4 += 1;
							txt4 += `
						    	<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
					    			<tr>
					    				<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%; padding:0px;">
					    					<strong>\${r.patName}</strong>
					    					<span style="font-size : 0.7rem;">(\${r.patAge})<span>
					    					<div style="display : flex; justify-content: space-between;">
					    						<div style="font-size:11px; margin:5px 0px 0px 0px;">
					    							\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
					    						</div>
					    						<div style="margin: 0px 5px 10px 0px;">
					    							<button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button>
					    						</div>
					    					</div>
					    				</td>
					    			</tr>
			   					</table>
							`;
						}
					} else if(r.patWait =='치료대기'||r.patWait =='치료중'||r.patWait =='치료완료'||r.patWait =='처치중') {
						c5 += 1;
						txt5 += `
				        	<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
				    			<tr>
					    			<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%;  padding:0px;">
					    				<strong>\${r.patName}</strong>
					    				<span style="font-size : 0.7rem;">(\${r.patAge})  | \${r.empNm}<span>
					    				<div style="display : flex; justify-content: space-between;">
					    					<div style="font-size:11px; margin:5px 0px 0px 0px;">
					    						\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
					    					</div>
					    					<div style="margin: 0px 5px 10px 0px;">
					    						<button class="btn btn-xs btn-secondary" "disabled" style="font-size : 0.7rem;">\${r.patWait}</button>
					    					</div>
					    					</div>
					    			</td>
				    			</tr>
			   				</table>
						`;
					} else if(r.patWait == '진료완료' && r.patHsptlzStatus !='4' && r.patHsptlzStatus !='5'){
						c6 += 1;
						txt6 += `
				        	<table class="table table-hover" style="width : 100%; text-align : left; border-bottom : 1px solid black;">
				    			<tr>
					    			<td onclick="tClick(\${r.patCode},\${r.treatNo},'\${rDate}')" style="width : 65%; padding:0px;">
					    				<strong>\${r.patName}</strong>
					    				<span style="font-size : 0.7rem;">(\${r.patAge})  | \${r.empNm}</span>
				    					<div style="display : flex; justify-content: space-between;">
				    						<div style="font-size:11px; margin:5px 0px 0px 0px;">
				    							\${r.patBrthdy} | \${r.patGen} | \${r.patFirst}
				    						</div>
				    						<div  style="margin: 0px 5px 10px 0px;">
				    							<button class="btn btn-xs btn-info" "disabled">\${r.patWait}</button>
				    						
				    						</div>
				    					</div>
				    				</td>
				    			</tr>
			   				</table>
						`;
					}
					
				}
// 				console.log("txt1",txt1);
// 				console.log("txt2",txt2);
// 				console.log("txt3",txt3);
// 				console.log("txt4",txt4);
// 				console.log("txt5",txt5);
// 				console.log("txt6",txt6);
				
				$gr1Content.html(txt1);
				$gr2Content.html(txt2);
				$gr3Content.html(txt3);
				$gr4Content.html(txt4);
				$gr5Content.html(txt5);
				$gr6Content.html(txt6);
				$gr1Btn.text("대기("+c1+")");
				$gr2Btn.text("대기("+c2+")");
				$gr3Btn.text("대기("+c3+")");
				$gr4Btn.text("대기("+c4+")");
				$gr5Btn.text("대기("+c5+")");
				$gr6Btn.text("대기("+c6+")");
				getSchedule();
			}
		});
	}
	function getSchedule(){
		$.ajax({
			url : "/office/scheduleList",
			type : "get",
			dataType : "json",
			success : function(result){
				console.log(result);
				for(let i = 0; i<result.length; i++){
					let r = result[i];
					let room = r.hosFcName;
					let empNm = r.empNm;
					if(room == '1진료실'){
						$gr1.text(room + "-" + empNm);
					}else if(room == '2진료실'){
						$gr2.text(room + "-" + empNm);
					}else if(room == '3진료실'){
						$gr3.text(room + "-" + empNm);
					}else if(room == '4진료실'){
						$gr4.text(room + "-" + empNm);
					}
				}
			}
		});
	}
	
	const rNo = $('#rNo');
	const pNo = $('#pNo');
	const rceptMemo = $('#rceptMemo');	
	const receiptDiv = $('#receiptDiv');
	const rDate = $('#rDate');
	const pInfo = $('#pInfo');
	const pIdhNum = $('#pIdhNum');
	const pAddr = $('#pAddr');
	const pTel = $('#pTel');
	const selSchd = $('#selSchd');
	const rceptFirstExamCode = $("input[name = rceptFirstExamCode]");
	const rceptDayCode     =   $("input[name = rceptDayCode]");
	const rceptPathCode    =   $("select[name = rceptPathCode]");
	const sDiv             =   $('#searchDiv1');
	const insDiv = $('#insDiv');
	const dtlDiv = $('#dtlDiv');
	const insModal = $('#insertModal');
	const dateTable = $('#dateTable');
	const cInfoDiv = $('#cInfoDiv');
	const rInfoDiv = $('#rInfoDiv');
	const detailNo = $('#detailNo');
	const treCont = $('#treCont');
	const physioCont = $('#physioCont');
	const inspcCont = $('#inspcCont');
	const mediCont = $('#mediCont');
	const patHsptlzStatus = $('#patHsptlzStatus');
	const rceptFirstExam = $('#rceptFirstExam');
	const rceptDay = $('#rceptDay');
	const dissName = $('#dissName');
	const doctor = $('#doctor');
	const rcptTbody = $('#rcptTbody');
	const rcptTbody2 = $('#rcptTbody2');
	const tNo = $('#tNo'); 
$('#submitRpt').on('click',function(){
		
		let currentDate = new Date();
		let year = currentDate.getFullYear().toString();
		let month = (currentDate.getMonth() + 1).toString().padStart(2, '0'); 
		let day = currentDate.getDate().toString().padStart(2, '0');
		let formattedDate = year+"/"+month+"/"+day;
		
		
		let data = {
			"rceptNo" : rNo.html(),
			"patCode" : pNo.html(),
 			"rceptPathCode" : rceptPathCode.val(),
 			"rceptFirstExamCode" : $("input[name = rceptFirstExamCode]:checked").val(),
 			"rceptDayCode" : $("input[name = rceptDayCode]:checked").val(),
			"rceptMemo" : rceptMemo.val() ,
 			"schdNo" : selSchd.val(),
			"receptTime" : formattedDate
		}
		console.log("체체체크",data);
		
		$.ajax({
			url: `/receipt/insert/`,
		 	type : 'POST',
		 	data : JSON.stringify(data),
		  	dataType : 'JSON',
		  	contentType : 'application/json; charset=utf-8',
		  	success : function(result){
		  		console.log(result);
		  		if(result>0){
		  			Swal.fire({
		  				icon: 'success',
		  				title:'완료!',
		  				text:'접수 등록이 완료되었습니다!',	
		  				});
		  			receiptDiv.css("display","none");
		  			//접수 후 의사에게 message
		  			let msg = {
							to: "의사", 
							from: "원무",
					        cmd: "receiptPat"  
						}
					webSocket.send(JSON.stringify(msg));
		  			
		  			
		  			
		  			
		  			
		  		}else{
		  			Swal.fire({
		  				icon: 'error',
		  				title:'실패!',
		  				text:'접수 등록 실패!',	
		  				});
		  		}
		  		getPatList();
		  	}
			
		});
	});
	
function receipt(patCode){
	receiptDiv.css("display","block");
	insDiv.css("display","block");
	dtlDiv.css("display","none");
  console.log("patCode1",patCode);
  $.ajax({
	  url: `/office/setPat/\${patCode}`,
	  type : 'GET',
	  dataType : 'JSON',
	  success : function(result){
		  selSchd.empty();
		  rceptPathCode.empty();
		  rceptMemo.removeAttr("readonly");
		  rceptMemo.val("");
		  console.log("결과아아아아",result);
		  console.log("결과아아아아22",result.patientVO.patCode);
		  let birthdate = result.patientVO.patBrthdy;
		  let currentDate = new Date();
		  let month = currentDate.getMonth() + 1;
			if (month < 10) {
			  month = "0" + month;
			}
		  let rCurrentDate = currentDate.getFullYear() + '-' + month + '-' + currentDate.getDate();
		  let age = currentDate.getFullYear() - birthdate.substring(0,4);
		  let gend = "";
		  if(result.patientVO.patGenCode == 'F'){
			  gend = "여";
		  }else{
			  gend = "남";
		  }
		  console.log(result.patientVO);
		  pNo.text(result.patientVO.patCode);       
		  pInfo.text(result.patientVO.patName+"("+gend+", "+age+"세)");          
		  pTel.text(result.patientVO.patTel);           
		  pAddr.text(result.patientVO.patAddr+" "+result.patientVO.patDtlAddr);                  
		  rNo.text(result.rcptNo);
		  rDate.html(rCurrentDate);
		  pIdhNum.text(result.patientVO.patIhidnum);
		  let txt ="";
		  let sList = JSON.parse(JSON.stringify(result.schList));
		  for(let i =0; i< sList.length; i++){
			  txt += "<option value="+sList[i].schdNo+">"+sList[i].hosFcName + "-" + sList[i].empNm +"</option>";
		  }
		  let txt2 ="";
		  let comList = JSON.parse(JSON.stringify(result.comList));
		  for(let i = 0; i<comList.length; i++){
			  txt2 += "<option value="+comList[i].comCode+">"+comList[i].comCodeName+"</option>";
		  }
			  selSchd.append(txt);
			  rceptPathCode.append(txt2);
			  sDiv.css("display","none");
			  dateList(result.patientVO.patCode);
	  }

  })
}

function cancel(){
	receiptDiv.css("display","none");
}



function tClick(patCode,treatNo,receptTime){
	
	insDiv.css("display","none");
	dtlDiv.css("display","block");
	console.log(patCode,treatNo,receptTime);
	
	$.ajax({
		url : "/receipt/detailPat/"+patCode+"/"+treatNo+"/"+receptTime,
		type : "get",
		dataType : "JSON",
		success : function(result){
			let pVO = result.patientVO;
			let wVO = result.waitPatVO;
			let cVO = result.cVO;
			let preInspecList = result.preInspecList;
			let preMediList = result.preMediList;
			let prePhysioList = result.prePhysioList;
			let preTreatList = result.preTreatList;
			console.log("pVO",pVO);
			console.log("wVO",wVO);
			console.log("cVO",cVO);
			console.log("preInspecList",preInspecList);
			console.log("preMediList",preMediList);
			console.log("prePhysioList",prePhysioList);
			console.log("preTreatList",preTreatList);
			let currentDate = new Date();
			let birthdate = pVO.patBrthdy;
			let month = currentDate.getMonth() + 1;
			if (month < 10) {
			  month = "0" + month;
			}
			let rCurrentDate = currentDate.getFullYear() + '-' + month + '-' + currentDate.getDate();
			let age = currentDate.getFullYear() - birthdate.substring(0,4);
			let gend = "";
			if(pVO.patGenCode == 'F'){
				gend = "여";
			}else{
				gend = "남";
			}
			
			console.log("tClick!!!",result);
			receiptDiv.css("display","block");
			pNo.text(pVO.patCode);
			pIdhNum.text(pVO.patIhidnum);
			pInfo.text(pVO.patName+"("+gend+", "+age+"세)");          
			pTel.text(pVO.patTel);           
			pAddr.text(pVO.patAddr+" "+pVO.patDtlAddr);   
			if(wVO != null){
				rNo.text(wVO.rceptNo);
				tNo.html(wVO.treatNo);
				rceptFirstExamCode.empty();
				rceptFirstExamCode.append("<option selected>" + wVO.patFirst + "</option>");
				rceptDayCode.empty();
				rceptDayCode.append(`<option selected>\${wVO.patDay}</option>`);
				rceptPathCode.empty();
				rceptPathCode.append(`<option selected>\${wVO.patPath}</option>`);
				selSchd.empty();
				selSchd.append("<option selected>"+wVO.hosFcName +"-" + wVO.empNm+"</option>");
				rDate.html(wVO.receptTime);
				rceptMemo.val(wVO.rceptMemo);
				rceptMemo.attr("readonly","readonly");
				
			}
			dateList(pVO.patCode);
			detailNo.html("");
			treCont.val("");
			physioCont.val("");
			inspcCont.val("");
			mediCont.val("");
			patHsptlzStatus.val("");
			rceptFirstExam.val("");
			rceptDay.val("");
			dissName.val("");
			doctor.val("");	
			
			if(cVO != null){
				detailNo.html(cVO.detailNo);
				treCont.val(cVO.treContent);
				physioCont.val(cVO.physioContent);
				inspcCont.val(cVO.inspcType);
				mediCont.val(cVO.mediItemName);
				patHsptlzStatus.val(cVO.patHsptlzStatus);
				rceptFirstExam.val(cVO.rceptFirstExamCode);
				rceptDay.val(cVO.rceptDayCode);
				dissName.val("("+cVO.dissCodeNo+") " + cVO.dissKorName);
				doctor.val(cVO.empNm);
			}
			let ptxt = `<tr style="height : 25px;">
			<td>진찰료</td>
			<td>\${wVO.treatNo}</td>
			<td>진찰비용</td>
			<td style="text-align : right;">15,000</td>
			<td></td>
			<td></td>
			<td style="text-align : right;">15,000</td>
			<td style="text-align : right;">6,000</td>
			<td style="text-align : right;">9,000</td>
		</tr>`;
			let pTotal = 0;
			if(preInspecList != null){
				for(let i = 0; i<preInspecList.length; i++){
					let p = preInspecList[i];
					let price = new Intl.NumberFormat('ko-KR').format(p.inspcCost);
					let qty = 1;
					let day = 1;
					let total = new Intl.NumberFormat('ko-KR').format(p.inspcCost * qty * day);
					let self = new Intl.NumberFormat('ko-KR').format(p.inspcCost * qty * day * 0.4);
					let corporation = new Intl.NumberFormat('ko-KR').format(p.inspcCost * qty * day * 0.6);
					pTotal += parseInt(p.inspcCost);
					ptxt += 
						`<tr style="height : 25px;">
							<td>검사</td>
							<td>\${p.inspcCode}</td>
							<td>\${p.inspcType}</td>
							<td style="text-align : right;">\${price}</td>
							<td style="text-align : right;">\${qty}</td>
							<td style="text-align : right;">\${day}</td>
							<td style="text-align : right;">\${total}</td>
							<td style="text-align : right;">\${self}</td>
							<td style="text-align : right;">\${corporation}</td>
						</tr>`;
				}
			}
			if(preMediList !=null){
				for(let i = 0; i<preMediList.length; i++){
					let p = preMediList[i];
					let price = new Intl.NumberFormat('ko-KR').format(p.mediItemPrice);
					let qty = p.prscrptnAmount;
					let day = p.prscrptnCount;
					let total = new Intl.NumberFormat('ko-KR').format(p.mediItemPrice * qty * day);
					let self = new Intl.NumberFormat('ko-KR').format(p.mediItemPrice * qty * day * 0.4);
					let corporation = new Intl.NumberFormat('ko-KR').format(p.mediItemPrice * qty * day * 0.6);
					pTotal += parseInt(p.mediItemPrice);
					ptxt += 
						`<tr style="height : 25px;">
							<td>처방</td>
							<td>\${p.mediItemCode}</td>
							<td>\${p.mediItemName}</td>
							<td style="text-align : right;">\${price}</td>
							<td style="text-align : right;">\${qty}</td>
							<td style="text-align : right;">\${day}</td>
							<td style="text-align : right;">\${total}</td>
							<td style="text-align : right;">\${self}</td>
							<td style="text-align : right;">\${corporation}</td>
						</tr>`;
				}
			}
			if(prePhysioList !=null){
				for(let i = 0; i<prePhysioList.length; i++){
					let p = prePhysioList[i];
					let price = new Intl.NumberFormat('ko-KR').format(p.physioCost);
					let qty = 1;
					let day = 1;
					let total = new Intl.NumberFormat('ko-KR').format(p.physioCost * qty * day);
					let self = new Intl.NumberFormat('ko-KR').format(p.physioCost * qty * day * 0.4);
					let corporation = new Intl.NumberFormat('ko-KR').format(p.physioCost * qty * day * 0.6);
					pTotal += parseInt(p.physioCost);
					ptxt += 
						`<tr style="height : 25px;">
							<td>물리치료</td>
							<td>\${p.physioCode}</td>
							<td>\${p.physioContent}</td>
							<td style="text-align : right;">\${price}</td>
							<td style="text-align : right;">\${qty}</td>
							<td style="text-align : right;">\${day}</td>
							<td style="text-align : right;">\${total}</td>
							<td style="text-align : right;">\${self}</td>
							<td style="text-align : right;">\${corporation}</td>
						</tr>`;
				}
			}
			if(preTreatList !=null){
				for(let i = 0; i<preTreatList.length; i++){
					let p = preTreatList[i];
					let price = new Intl.NumberFormat('ko-KR').format(p.treCosts);
					let qty = 1;
					let day = 1;
					let total = new Intl.NumberFormat('ko-KR').format(p.treCosts * qty * day);
					let self = new Intl.NumberFormat('ko-KR').format(p.treCosts * qty * day * 0.4);
					let corporation = new Intl.NumberFormat('ko-KR').format(p.treCosts * qty * day * 0.6);
					pTotal += parseInt(p.treCosts);
					ptxt += 
						`<tr style="height : 25px;">
							<td>처치</td>
							<td>\${p.treCode}</td>
							<td>\${p.treContent}</td>
							<td style="text-align : right;">\${price}</td>
							<td style="text-align : right;">\${qty}</td>
							<td style="text-align : right;">\${day}</td>
							<td style="text-align : right;">\${total}</td>
							<td style="text-align : right;">\${self}</td>
							<td style="text-align : right;">\${corporation}</td>
						</tr>`;
				}
			}
			rcptTbody.html(ptxt)
			pTotal = pTotal + 15000;
			let pTotalVal = new Intl.NumberFormat('ko-KR').format(pTotal);
			let selfVal = new Intl.NumberFormat('ko-KR').format(Math.floor(pTotal * 0.4));
			let corpVal = new Intl.NumberFormat('ko-KR').format(Math.ceil(pTotal * 0.6));
			console.log("pTotal:",pTotal);
			let ptxt2 = 
				`<tr style="text-align : right; height : 25px;">
     				<td id="pTotal" pdx="\${pTotal}">\${pTotalVal}</td>
     				<td>\${selfVal}</td>
     				<td>\${corpVal}</td>
     				<td>\${selfVal}</td>
	        	</tr>`
	        rcptTbody2.html(ptxt2);
		}
	
	})
// 	dateList(patCode);
}





//진료대기 목록에서 삭제
function cancelClinic(treatNo){
	console.log(treatNo);
	let xhr = new XMLHttpRequest();
	let url = "/receipt/delWait/"+treatNo;
	xhr.open("GET",url,true);
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			let result = xhr.responseText;
			console.log(result);
			Swal.fire({
				icon: 'success',
				title:'성공!',	
				text:'진료가 취소되었습니다!',	
				});
  			let msg = {
					to: "의사", 
					from: "원무",
			        cmd: "receiptPat"  
				}
			webSocket.send(JSON.stringify(msg));
			getPatList();
		}
	}
	xhr.send();
}
function dateList(patCode) {
    let xhr = new XMLHttpRequest();
    let schURL = "/receipt/date/"+patCode
    xhr.open("get",schURL,true);
    xhr.onreadystatechange = () => {
        if(xhr.readyState == 4 && xhr.status == 200){
            let rslt = JSON.parse(xhr.responseText)
            console.log("날짜!!!",rslt);
            let txt ="";
			for(let i=0; i<rslt.length; i++){
	            let yN = "";
	            if(rslt[i].rceptFirstExamCode == 'Y'){
	           		yN = "초진";
	            } else{
	            	yN ="재진";
	            }
	            txt +=`<table style="width: 95%; margin : 5px; border-bottom : 1px solid gray;">
         					<tr>
         						<td>\${rslt[i].receptTime}</td>
         						<td style="text-align : center;">\${rslt[i].empNm}</td>
         					</tr>
         					<tr>
         						<td>\${yN}</td>
         						<td style="text-align : center; margin-bottom : 5px;"><button onclick="tClick(\${rslt[i].patCode},\${rslt[i].treatNo},'\${rslt[i].receptTime}')" class="btn btn-sm btn-primary">상세보기</button></td>
         					</tr>
         				</table>`;
			}
			dateTable.html(txt);
        }
    }
    xhr.send(); 
}



function fReqDoc(btn){
	let vthis = $(btn).html(); //진단서 소견서 여부
	let dtlNo = detailNo.html(); //detail_no 값
	//REQ_DOCUMENT_NO, DETAIL_NO, REQ_DOCUMENT_REG_DATE, REQ_DOCUMENT_STATUS, REQ_DOCUMENT_PAYMENT, DOCUMENT_TYPE
	let docType = "";
	if(vthis == '진단서 요청'){
		docType = "진단서"
	} else if(vthis == '소견서 요청'){
		docType = "소견서"
	}
	let data = {
			"detailNo" : dtlNo,
			"documentType" : docType
	}
	console.log("보낼것!!",data);
	$.ajax({
		url : "/document/insertReq",
		type : "post",
		data : JSON.stringify(data),
		contentType : "application/json; charset=utf-8",
		dataType : "text",
		success : function(result){
			console.log(result);
			if(result>0){
	  			Swal.fire({
	  				icon: 'success',
	  				title:'완료!',
	  				text:'제증명 신청이 완료되었습니다!',	
	  				});
	  			receiptDiv.css("display","none");
	  			let msg = {
	  					to : '원무과',
	  					from : '의사',
	  					cmd : 'plzDocu'
	  				} 
	  											
	  			webSocket.send(JSON.stringify(msg)); 

	  		}else{
	  			Swal.fire({
	  				icon: 'error',
	  				title:'실패!',
	  				text:'제증명 신청 실패!',	
	  				});
	  		}
		}
	})
	
}

function fReceiption(){
	let treatNo = tNo.html();
	let rcivPayment = parseInt($('#pTotal').attr("pdx"));
	console.log("돈",rcivPayment);
	let data = {
			'treatNo' : treatNo,
			'rcivPayment' : rcivPayment
	}
	$.ajax({
		url : "/receiption/insert",
		type : "post",
		data : JSON.stringify(data),
		dataType : "JSON",
		contentType :"application/json;charset=utf-8",  
		success : function(result){
			console.log("fReceiption",result);
			Swal.fire({
  				icon: 'success',
  				title:'완료!',
  				text:'수납이 완료되었습니다.',	
  				});
			receiptDiv.css("display","none");
			getPatList();
		}
	});
}

//--------------------------- 웹소켓-------------------------------------

function fMessage(){ // 받는쪽에 작성
	let serverMsg = JSON.parse(event.data);
	
	if(serverMsg.cmd == "callPat"){
		getPatList();
	}
	if(serverMsg.cmd == "plzInspc"){
		getPatList();
	}
	if(serverMsg.cmd == "plzTreat"){
		getPatList();
	}
	if(serverMsg.cmd == "plzPhysio"){
		getPatList();
	}
	if(serverMsg.cmd == "endInspc"){
		getPatList();
	}
	if(serverMsg.cmd == "endPhysio"){
		getPatList();
	}
	if(serverMsg.cmd == "endClinic"){
		getPatList();
	}
	if(serverMsg.cmd =="alarm"){
		getNotiList();
	}
	if(serverMsg.cmd =="ingInspc"){
		getPatList();
	}
	if(serverMsg.cmd =="ingTreat"){
		getPatList();
	}
	if(serverMsg.cmd =="ingPhysio"){
		getPatList();
	}
	
}

// --------------------------- /웹소켓 ------------------------------------- 

</script>