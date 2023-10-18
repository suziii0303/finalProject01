<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet"/> 
<link href="/resources/css/demo.css" rel="stylesheet"/> 
<style>
#autoCompleteBtnS {
    height: 25px;
    display: flex; 
    justify-content: center;
     align-items: center;
}
</style>
<!-- sms 자동완성 문구 CRUD모달 시작 -->
<div class="card mb-4" id="smsModal">
      <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">SMS 문구</h5>
        <button type="button" id="autoCompleteBtnS" class="btn btn-xs btn-dark" onclick="autoComplBtnS()">자동완성</button>
      </div>
      <div class="card-body">
        <form>
          <input type="hidden" id="smsNm"/>
          <div class="mb-3">
            <label class="form-label" for="smsSj">문구 이름</label>
            <input type="text" style="width : 80%;" class="form-control" id="smsSj" placeholder="문구 명을 입력하세요.">
          </div>
          <div class="mb-3">
            <label class="form-label" for="smsCn">문구 내용</label>
            <textarea cols="30" rows="9" id="smsCn" style="width:100%;"></textarea>           
          </div>
        </form>
        <div style="text-align : right;">
	        <div id="detailSms">
	          <button type="button" onclick="upBtn()" class="btn btn-primary">수정</button>
	          <button type="button" onclick="delSms()" class="btn btn-secondary">삭제</button>
	          <button type="button" onclick="closeBtn()" class="btn btn-primary">닫기</button>
	        </div>
	        <div id="upSms">
	          <button type="button" onclick="modSms()" class="btn btn-primary">저장</button>
	          <button type="button" onclick="cancelBtn()" class="btn btn-secondary">취소</button>
	        </div>
	        <div id="insertSms">
	          <button type="button" onclick="insSms()" class="btn btn-primary">등록</button>
	          <button type="button" onclick="closeBtn()" class="btn btn-primary">닫기</button>
	        </div>
	      </div>
      </div>
</div>
<!-- sms 자동완성 문구 CRUD모달 끝 -->
<!-- 환자 검색 모달 시작 -->
<div class="modal-content" id="searchPatModal">
		<div class="modal-header">
			<h3 class="modal-title" >환자검색</h3>
		</div>
		<div class="col mb-3" style="text-align : right;">
			<input type="text" id="searchPatValue" class="form-control">
			<button type="button" class="btn btn-primary me-3" onclick="searchPat()">검색</button>
		</div>
		<div id="patList" style="width : 100%; height : 75%;">
	 	<h5 class="pb-2 border-bottom mb-4"  style="font-weight: bold;">검색결과</h5>
        <table class="table table-hover">
	        <thead>
		        <tr>
		        <th>번호</th>
		        <th>환자코드</th>
		        <th>환자명</th>
				<th>생년월일</th>
		        </tr>
	        </thead>
	        <tbody class="table-border-bottom-0" id="sResultTbody">
	        
			</tbody>
	    </table>
		</div>
		<!--  //modal-body끝 -->
		<div class="modal-footer" style="text-align : right; padding : 15px 0px;">
			<button type="button" class="btn btn-secondary me-3"
				data-bs-dismiss="modal" style="margin : 0px !important;" onclick="modalClose()">닫기</button>
		</div>
	</div>
<!-- 환자 검색 모달 끝 -->
	<div class="grid-stack"></div>
 <style>
 #smsModal {
	position: fixed;
	width: 470px;
	height: 450px;
	background-color: white;
	display: none;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	box-shadow: 5px 5px 5px 5px gray;
}
 
 .smsPat{
 	color : black;
 	padding : 0 0 0 3px;
 }
 #searchPatModal{
 	position: fixed;
	width: 500px;
	height: 800px;
	background-color: white;
	display: none;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid black;
	overflow: auto;
 }
 /* grid 1, 2 */
 .gs-12>.grid-stack-item[gs-w="6"] {
    width: 50%;
}
.gs-id-0 > .grid-stack-item[gs-h="3"] {
    height: 390px;
}
.gs-id-0 > .grid-stack-item[gs-y="3"] {
    top: 390px;
}
.gs-id-0 > .grid-stack-item[gs-h="6"] {
    height: 780px;
}

 </style>
  <script>

  $(function(){
	  getSmsList(); 
  });
      const $searchPatModal = $('#searchPatModal');
      const $patList = $('#patList');
      const $searchPatValue = $('#searchPatValue');
      const $sResultTbody = $('#sResultTbody');
  	  var gr1 = 
  		  `
    	  <div>
  	  			<div style="text-align : left; margin : 20px; margin-bottom : 0px;">
  	  				<div>
  	  					<div style="display : inline-block;">
  	  						<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:91px;">문자매크로</h5>
	  	  				</div>
  	  					<div style="float : right; display : inline-block;">
		  					<button onclick="insertSMS()" class="btn btn-primary" style="margin: 0 20px; text-align : right;" id="smsAddBtn">추가</button>
		  				</div>
  	  				</div>
	  	  			<table class="table table-hover">
				  	    <thead>
					  	    <tr>
						  	    <th style="width:100px;">번호</th>
						  	    <th style="width:150px;">이름</th>
						  	    <th >내용</th>
						  	    <th style="width:100px;">상세</th>
					  	    </tr>
				  	    </thead>
				  	    <tbody id="smsTbody" class="table-border-bottom-0" style="height:40px;">
				  	    </tbody>
			  	    </table>
		  	    </div>
  	  	  </div>
  		  `;
  		  
      var gr2 =
    	  `
    	  <div>
  	  			<div style="text-align : left; margin : 20px; margin-bottom : 0px;">
  	  				<div>
  	  					<div style="display : inline-block;">
							<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:119px;">문자전송내역</h5>
	  	  				</div>
  	  				</div>
	  	  			<table class="table table-hover">
				  	    <thead>
					  	    <tr>
						  	    <th style="width : 100px;">번호</th>
						  	    <th style="width : 150px;">수신인</th>
						  	    <th >내용</th>
						  	    <th style="width : 200px;">발송일</th>
					  	    </tr>
				  	    </thead>
				  	    <tbody id="smsHisTbody" class="table-border-bottom-0">
					  	   
				  	    </tbody>
			  	    </table>
		  	    </div>
  	  	  </div>
    	  `;
  	  var gr3 = 
  		  `
  			<div>
  	  			<div style="text-align : left; margin : 20px; margin-bottom : 0px;">
  	  				<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:41px;">내용</h5>
  	  			</div>
  	  			<div style="width:100%;margin-left: 20px;">
  	  				<div style="display : flex; height : auto;">
	  	  				<div style="margin : 5px 20px 20px 20px;">
	  	  					<textarea id="smsCn2" name="smsCn2" cols ="75", rows ="18" style="height:500px;" placeholder="[Web발신]\n내용을 입력하세요."></textarea>
	  	  				</div>
	  	  				<div style="margin : 20px;" id="smsDiv">
	  	  				
	  	  				</div>
  	  				</div>
  	  			</div>
  	  		</div>
  	  		<div style="text-align : left; margin : 20px; margin-bottom : 0px;">
  	  			<h5 class="pb-2 border-bottom mb-4" style="text-align:left;margin-right:120px;font-weight:bold;width:41px;">발송</h5>
			</div>
  	  		<div style="display : flex; width: 100%;">
  	  			<div style="width : 659px; margin : 0px 20px 20px 20px;">
		  	  		<div class="input-group" style="width:790px;">
				        <span onclick="searchSMSPat()" class="input-group-text" style="background:#8592A3;color:white;">검색</span>
				        <div id="selectedPatDiv" class="form-control" style="display : flex; text-align : left; margin-right : 0px">
				        </div>
		     		</div>
	     		</div>
		        <div style="margin: 0 0 0 118px;">
		        	<button class="btn btn-primary me-3" onclick="sendSMS()">전송</button>
		        </div>
	     	</div>
  		  `;
      var items = [ 
	   {w: 6, h:3, x:0, y:0, content: gr1}, 
	   {w: 6, h:3, x:0, y:3, content: gr2}, 
	   {w: 6, h:6, x:6, y:0, content: gr3},
  		];
  
    var grid = GridStack.init(); grid.load(items);



	const $smsCn2 = $('#smsCn2');
	const $smsCn = $('#smsCn');
	const $smsSj = $('#smsSj');
	const $smsNm = $('#smsNm');
	function sendSMS(){
		let smsReceiver = [];
		$('input[name="smsReceiver"]').each(function() {
			smsReceiver.push($(this).val());
		});
		let smsReceiverName = [];
		$('input[name="smsPatName"]').each(function() {
			smsReceiverName.push($(this).val());
		});		
	
		
		console.log("받는사람:"+smsReceiver);
		console.log("받는사람이름:"+smsReceiverName);
		console.log("내용:" + $smsCn2.val());
	   let data = [];
	   for(let i = 0; i< smsReceiver.length; i++){
	   		data.push({
			"smsHisReceiver" : smsReceiver[i],
			"smsHisCn" : $smsCn2.val(),
			"smsHisReceiverName" : smsReceiverName[i]
		});
		   
	   }
	   console.log("마!!!!!이야!" + JSON.stringify(data));
	   
 	   	$.ajax({
 	   		url : "/sms/send",
 	   		dataType : "text",
 	   		contentType : 'application/json; charset=utf-8',
	   		type : "post",
 	   		data : JSON.stringify(data),
 	   		success : function(result){
 	   			if(result > 0){
 	   				Swal.fire({
					   icon: 'success',
					   title: '성공!',
					   text: '문자 전송 완료.'
					});
 	   				$smsCn2.val("");
 	   				$selectedPatDiv.empty();
 	   			    getSmsHisList();
 	   			}else{
	 	   			Swal.fire({
					   icon: 'error',
					   title: '실패!',
					   text: '문자 전송 실패.'
					});
 	   			}
 	   		}
 	   	})
   }
   
   function searchSMSPat(){
	   $searchPatModal.css("display","block");
   }
   
	function delSmsPat(patCode){
		console.log("파라미터는",patCode);
		// 클릭된 요소를 찾아 삭제
	    let $clickedElement = $('div.smsP input[name="smsPatCode"][value="' + patCode + '"]').closest('div.smsP');
	    $clickedElement.remove();
		let index = selectedPatCodes.indexOf(patCode);
		console.log("인덱스는",index);
		if (index !== -1) {
   			selectedPatCodes.splice(index, 1);
   			Swal.fire({
				   icon: 'success',
				   title: '성공!',
				   text: '삭제 완료.'
			});
		}
		console.log("제거된 후 :",selectedPatCodes);
		}
   
   function modalClose(){
	   $searchPatModal.css("display","none");
	   $sResultTbody.empty();
	   $searchPatValue.val("");
   }
   function searchPat(){
	   let patName = $searchPatValue.val();
	   $.ajax({
		 url : "/office/searchPat/"+patName,
		 type : "get",
		 success : function(result){
			 console.log(result);
				let txt = "";
			 	
	            for (let i = 0; i < result.length; i++) {
	            	let r = result[i];
	            	let no = i + 1;
	                txt += `<tr onclick="selectPat(\${r.patCode})">`;
	                txt += `<td>\${no}</td>`;
	                txt += `<td>\${r.patCode}</td>`;
	                txt += `<td>\${r.patName}</td>`;
	                txt += `<td>\${r.patBrthdy}</td>`;
	                txt += `</tr>`;
	            }
	          
	            $sResultTbody.html(txt);
		 }
		   
	   })
   }
   
   const $selectedPatDiv = $('#selectedPatDiv');
   
   // 이미 선택된 환자를 저장할 배열
   let selectedPatCodes = [];
   function selectPat(patCode){
	  
	  console.log("현재:",selectedPatCodes);
	  $.ajax({
		url : "/office/getPat/"+patCode,
		type : "get",
		success : function(result){
			console.log(result);
			let tel = result.patTel.replace(/-/g, '');
			 // 중복 체크
            if (!selectedPatCodes.includes(result.patCode)) {
            	selectedPatCodes.push(result.patCode);
				console.log(tel);
				let txt = 
					`
					<div style="display : flex;" class="smsP">
						<input type="hidden" name="smsPatName" value="\${result.patName}"/>
						<input type="hidden" name="smsPatCode" value="\${result.patCode}"/>
			        	<input type="hidden" name="smsReceiver" value="\${tel}"/>
				        <p class="smsPat btn btn-xs" style="margin-bottom : 0px;">
				        	 \${result.patName}
				        </p>
			        	<a onclick="delSmsPat('\${result.patCode}')" style="margin-left : 5px; color : red;"class="btn-close">
			        	</a>
			        	&nbsp
					</div>
					`;
				$selectedPatDiv.append(txt);
				Swal.fire({
					   icon: 'success',
					   title: '성공!',
					   text: '환자 선택 완료.'
				});
				modalClose();
			} else {
				Swal.fire({
					   icon: 'error',
					   title: '실패!',
					   text: '이미 선택된 환자입니다.'
				});
            }
		}
	  });
   }
   const $smsDiv = $('#smsDiv');
   const $smsTbody = $('#smsTbody');
   function getSmsList(){
	   $.ajax({
		   url : "/sms/list",
		   type : "get",
		   success : function(result){
			   console.log(result);
			   let txt = "";
			   let txt2 = "";
			   for(let i=0; i<result.length; i++){
				   txt += 
					   `
					    <tr style="font-size:13px;">
					  	    <td>\${i+1}</td>
					  	    <td>\${result[i].smsSj}</td>
					  	    <td>\${result[i].smsCn}</td>
					  	    <td>
					  	    	<button class="btn btn-secondary" onclick="detailSms('\${result[i].smsNm}')"
					  	    		style="font-size:12px;width:43px;height:27px;padding:0 0 0 0;">상세</button>
					  	    </td>
				  	    </tr>
					   `;
			   		txt2 +=
			   			`
			   			<a onclick="setSms('\${result[i].smsNm}')" class="btn btn-info" style="margin-bottom:10px;width:7vw;color:white;">\${result[i].smsSj}</a><br>
			   			`;
			   }
			   $smsTbody.html(txt);
			   $smsDiv.html(txt2);
			   getSmsHisList();
		   }
	   });
   }
   function setSms(smsNm){
	   $smsCn2.val("");
	   $.ajax({
		   url : "/sms/getSms/"+smsNm,
		   type : "get",
		   dataType : 'json',
		   success : function(result){
			   
			   console.log("sms하나가져오기"+result.smsCn);
			   
			   $smsCn2.val(result.smsCn);
		   }
	   })
   }
   const $smsModal = $('#smsModal');
   const $detailSms = $('#detailSms');
   const $upSms = $('#upSms');
   const $insertSms = $('#insertSms');
   function insertSMS(){
	  $detailSms.css("display","none");
	  $upSms.css("display","none");
	  $smsModal.css("display","block");
	  $insertSms.css("display","block");
	  $smsCn.removeAttr("readonly");
	  $smsSj.removeAttr("readonly");
   }
   function closeBtn(){
	   $smsModal.css("display","none");
	   clearSmsModal();
   }
   function clearSmsModal(){
	   $smsSj.val("");
	   $smsCn.val("");
   }
   function detailSms(smsNm){
	   $smsModal.css("display","block");
	   $detailSms.css("display","block");
	   $upSms.css("display","none");
	   $insertSms.css("display","none");
	   $.ajax({
		   url : "/sms/getSms/" + smsNm,
	       type : "get",
	       success : function(result){
	    	   console.log(result);
	    	   $smsNm.val(result.smsNm);
	    	   $smsCn.val(result.smsCn);
	    	   $smsSj.val(result.smsSj);
	    	   $smsCn.attr("readonly","readonly");
	    	   $smsSj.attr("readonly","readonly");
	       }
	   })
   }
   function upBtn(){
	   $detailSms.css("display","none");
	   $upSms.css("display","block");
	   $insertSms.css("display","none");
	   $smsCn.removeAttr("readonly");
	   $smsSj.removeAttr("readonly");
   }
   function modSms(){
	   let data = {
			   smsNm : $smsNm.val(),
			   smsSj : $smsSj.val(),
			   smsCn : $smsCn.val()
	   }
	   console.log(JSON.stringify(data));
	   $.ajax({
		   url : "/sms/modSms",
	       type : "post",
	       data : JSON.stringify(data),
	       contentType : 'application/json; charset=utf-8',
	       success : function(result){
	    	   getSmsList();
	    	   detailSms($smsNm.val());
	       }
	   })
   }
   function insSms(){
	   let data = {
			   smsSj : $smsSj.val(),
			   smsCn : $smsCn.val()
	   }
	   console.log(JSON.stringify(data));
	   $.ajax({
		   url : "/sms/insSms",
	       type : "post",
	       data : JSON.stringify(data),
	       contentType : 'application/json; charset=utf-8',
	       success : function(result){
	    	   console.log(result);
  				Swal.fire({
					   icon: 'success',
					   title: '성공!',
					   text: '등록 완료.'
				});
  				closeBtn();
  				getSmsList(); 
	       }
	   })
   }
   function cancelBtn(){
	   detailSms($smsNm.val()); 
   }
   function delSms(){
	   let smsNm = $smsNm.val();
	   $.ajax({
		   url : "/sms/delSms/"+smsNm,
	       type : "get",
	       success : function(result){
	    	   console.log(result);
	    	   Swal.fire({
				   icon: 'success',
				   title: '성공!',
				   text: '삭제 완료.'
			   });
	    	   closeBtn();
 			   getSmsList(); 
	    	   
	       }
	   })
   }
   const $smsHisTbody = $('#smsHisTbody');
   function getSmsHisList(){
	   $.ajax({
		   url : "/sms/getSmsHis",
	   	   type : "get",
	   	   success : function(result){
	   		   console.log(result);
			   let txt = "";
			   for(let i=0; i<result.length; i++){
				   txt += 
					   `
					    <tr style="font-size:13px;">
					  	    <td>\${i+1}</td>
					  	    <td>\${result[i].smsHisReceiverName}</td>
					  	    <td>\${result[i].smsHisCn}</td>
					  	    <td>\${result[i].smsHisSendDate}</td>
				  	    </tr>
					   `;
			   }
			   $smsHisTbody.html(txt);
	   	   }
	   })
	   
   }
   
 //--------------------------- 웹소켓-------------------------------------

   function fMessage(){ // 받는쪽에 작성
   	let serverMsg = JSON.parse(event.data);

   	if(serverMsg.cmd =="alarm"){
   		getNotiList();
   	}
   }
   // --------------------------- /웹소켓 ------------------------------------- 
   
	//자동완성버튼
	function autoComplBtnS(){
		$("#smsSj").val("입원 안내");
		$("#smsCn").val("[아작(나)스 병원] 입원 수납이 완료되었습니다.");  
	}

</script>