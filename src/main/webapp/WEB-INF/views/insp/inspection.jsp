<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<c:set var="empNo" value="${empVO.empNo}" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css"
	rel="stylesheet" />
<link href="../resources/css/demo.css" rel="stylesheet" />

<style>
.su {
	margin-bottom: 0;
}

#btn {
	float: right;
}

#ii {
	width: 100%;
	height: 50%;
}

.form-control-sm {
	border: none;
}
/* 첫번째 */
.gs-id-0>.grid-stack-item[gs-h="5"] {
	height: 790px;
}

.gs-12>.grid-stack-item[gs-w="2"] {
	width: 296px;
}
/*두번째*/
.gs-id-0>.grid-stack-item[gs-x="2"] {
	left: 287px;
}

.gs-id-0>.grid-stack-item[gs-h="4"] {
	height: 416px;
}

.gs-id-0>.grid-stack-item[gs-h="2"] {
	height: 383px;
}

.gs-12>.grid-stack-item[gs-w="3"] {
	width: 422px;
}

.gs-12>.grid-stack-item[gs-w="7"] {
	width: 1180px;
}

.gs-id-0>.grid-stack-item[gs-y="4"] {
	top: 407px;
}

.gs-id-0>.grid-stack-item[gs-x="5"] {
	left: 700px;
}

.gs-12>.grid-stack-item[gs-x="6"] {
	left: 901px;
}

.gs-12>.grid-stack-item[gs-w="6"] {
	width: 984px;
}

#filmingModal {
	display: none;
	position: fixed;
	width: 800px;
	height: 500px;
	background-color: white;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	border: 1px solid black;
	overflow: auto;
}
</style>
</head>
<body>
	<div class="modal-content" id="filmingModal" style="width: 500px;">
		<div class="modal-header" style="padding-top: 15px;">
			<h4 class="modal-title" style="margin-left: 2px; margin-top: 2px;">파일
				업로드</h4>
			<input class="form-control" type="file" id="fileInput" multiple
				style="width: 60%; position: absolute; bottom: 449px; right: -10px; margin-right: 35px;">
			<!--         <input type="file" id="fileInput" multiple style="position: absolute; bottom: 450px; right: -10px;" /> -->
			<!--         <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
		</div>

		<div class="modal-body"
			style="margin-bottom: 3px; padding-top: 5px; padding-bottom: 5px;">

			<div class="row mb-1" style="margin-top: 5px;">
				<input type="hidden" id="hFileCode" />
				<table id="a" class="table table-bordered"
					style="text-align: center;">

					<thead>
						<tr>
							<th>파일 순번</th>
							<th>파일 명</th>
						</tr>
					</thead>
					<tbody id="b">

					</tbody>
				</table>
			</div>

		</div>

		<div class="modal-footer" style="padding-bottom: 10px;">
			<button type="reset" class="btn btn-secondary" onclick="closeModal()"
				style="position: absolute; bottom: 0; right: 60px; margin-right: 30px; margin-bottom: 20px;">취소</button>
			<button class="btn btn-primary" id="submit"
				style="position: absolute; bottom: 0; right: 0; margin-right: 20px; margin-bottom: 20px;">등록</button>
		</div>
	</div>




	<div class="grid-stack"></div>

	<script type="text/javascript">
$(function() {
	waitInspection();
});

function closeModal(){
	console.log("닫자");
	$("#filmingModal").css("display","none");
	 $("#a td").remove();
	 $("#fileInput").val("")
}

         //  전역변수를 잘 활용하면 값을 공유할  수 있음!, 넘 많이 쓰면 머리 아픔 적당히!
$('#submit').click(function () {
	
	let inCode2 = hFileCode.val();
	console.log("gg",inCode2);
    const fileInput = $('#fileInput')[0];
    const fileList = fileInput.files;
    console.log(empNo);
    console.log("fileList ==> ", fileList);
  //  console.log("다른 함수에서 inCode 사용:", inCode);
    console.log("다른 함수에서 inCode 사용:", inCode2);
    if (fileList.length === 0) {
    	Swal.fire({
    		icon: 'error',
    		title: '',
    		text: '파일이 하나도 선택되지 않았습니다.',
    		});
        return; // Prevent further processing if no files are selected
    }
    const formData = new FormData();
    // FormData 객체를 생성하여 선택된 파일들을 담습니다.
    formData.append('empNo', empNo);
    formData.append('inCode', inCode2);
    for (let i = 0; i < fileList.length; i++) {
        formData.append('files', fileList[i]);
    }

    // Ajax를 사용하여 파일 업로드 요청을 서버로 전송합니다.
    $.ajax({
        url: '/insp/insertFile', // 서버 측 스크립트 경로를 설정하세요.
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        cache:false,
        success: function (rslt) {
            // 파일 업로드가 성공적으로 완료됐을 때의 처리를 추가하세요.
            console.log(rslt);
            closeModal();
            
            let timerInterval;
            Swal.fire({
              icon: 'warning',
              title: '촬영 사진 업로드 진행 중',
              text: '잠시 기다려주세요.',
              color: '#716add',
              timer: 1000,
              timerProgressBar: true,
              didOpen: () => {
                Swal.showLoading()
              },
              willClose: () => {
                clearInterval(timerInterval)
              }
            }).then((result) => {
              if (result.dismiss === Swal.DismissReason.timer) {
                console.log('I was closed by the timer')
              }
            })
            
            selectFile();
            $("#a td").remove();
       	    $("#fileInput").val("")
       	    
       	 	console.log("사진 띄우기 처음부터",xRay) 
        },
        error: function () {
            // 파일 업로드 실패 처리
            console.log('파일 업로드 실패');
        }
    });
    

});
let detailNo2;
let xRay;
function selectFile(){
	let itable = $(".itable");
	let images = "";
	$.ajax({
		url:"/insp/selectFile/"+detailNo2,
		dataType:"JSON",
		type:"GET",
		success: function(rslt){
			//rslt : List<InspectionVO>
			console.log("확인 ==>",rslt);
			text='';
			$.each(rslt,function(idx,inspectionVO){
				 var date = new Date(inspectionVO.inspectionListVOList[0].inspcDate);
		   	        var year = date.getFullYear();
		   	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
		   	        var day = date.getDate().toString().padStart(2, '0');
		   	        var formattedDate = year + '-' + month + '-' + day;
				text += "<tr><td>"+(idx+1)+"</td><td>"+inspectionVO.inspcCode+"</td><td>"+inspectionVO.inspcType+"</td><td>"
					    +formattedDate+"<td class='fnames' style='text-align:left;'>";
				$.each(inspectionVO.inspectionListVOList[0].fileList,function(idx2,attachFileVO){
					console.log("attachFileVO.fileWebPath==>",attachFileVO.fileWebPath)
					text += `
						<span class="badge bg-label-dark" style="margin:0px 0px 5px 0px;">
						
						<a style="font-size: 10px;" onclick="xrayImg('/resources/upload\${attachFileVO.fileWebPath}');">\${attachFileVO.fileName}</a>
						</span><br/>`;
					//text += `<a data-file-path="${attachFileVO.filePhysicPath}" class="file-link">${attachFileVO.fileName}</a><br />`;
					//text += '<a data-file-path="' + attachFileVO.filePhysicPath + '" class="file-link">' + attachFileVO.fileName + '</a><br />';
					console.log("inspectionVO.inspectionListVOList[0].fileList",inspectionVO.inspectionListVOList[0].fileList);
					console.log("inspectionVO.inspectionListVOList[0].fileList[0].fileWebPath",inspectionVO.inspectionListVOList[0].fileList[0].fileWebPath);
					images = `/resources/upload\${inspectionVO.inspectionListVOList[0].fileList[0].fileWebPath}`;
// 					console.log("이미지스스스스스스" ,images );
					$("#xrayImg").attr("src", images);
				});
				text += "</td></tr>";
			});
			
// 			for(let i=0; i < rslt.length; i++){
// 				console.log("아이 ",i);
				
				
// 				text+= `<tr>
// 						<td>\${i+1}</td>				
// 						<td>\${rslt[i].inspcCode}</td>				
// 						<td>\${rslt[i].inspcType}</td>				
// 						<td>\${rslt[i].inspectionListVOList[0].inspcDate}</td>`;
					
						
// 				text+= `<td class="fnames">\${rslt[i].fileName}</td>				
// 					</tr>`;
// 			}
			itable.html(text);
			console.log("이미지 ? " , images);
		},
		error: function (xhr, status, error) {
   	     console.log("code: " + xhr.status);
   	     console.log("message: " + xhr.responseText);
   	     console.log("error: " + error);
 	    }
	})
}
// $(".fnames").on("click", ".file-link", function () {
//     // 클릭한 링크의 데이터 속성에서 파일 경로를 가져옵니다.
//     const filePath = $(this).data("file-path");
//     console.log("클릭된 파일 경로: " + filePath);
//     // xrayImg 이미지의 src 속성을 파일 경로로 설정합니다.
//    	$("#xarImg").attr("src",filePath);
// });

 function xrayImg(xPath){
	 console.log("xPath==>",xPath);
 	$("#xrayImg").attr("src", xPath);
 }

$('#fileInput').on('change', function () {
    const fileList = this.files; // 선택된 파일 목록을 가져옵니다.
    const fileTableBody = $("#b"); // 파일 목록을 표시할 테이블의 tbody 요소
    
    // 선택된 파일이 있을 경우
    if (fileList.length > 0) {
        let text = '';
        for (let i = 0; i < fileList.length; i++) {
            text += `<tr>
                <td>\${i + 1}</td>
                <td>\${fileList[i].name}</td>
            </tr>`;
        }
        fileTableBody.html(text); // tbody에 파일 목록을 출력합니다.
    } else {
        fileTableBody.empty(); // 파일이 선택되지 않았을 때 테이블을 비웁니다.
    }
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
      
	
	  const img = '/resources/images/영상검색2.png';
      let gridStack3 = `<div id="prescriptionList" style="width:100%; height:100%; padding:20px 0px 20px 20px; background-color:white;">
					      <h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:1040px; font-weight: bold;">X-ray 상세 </h5>
					      <div style="display: flex; height: 85%;">
					          <!-- 왼쪽 컨텐츠 -->
					          <div style="flex: 1; width : 48%; height : 100%; border : 1px solid gray; border:none; margin-top:20px;">
					              <!-- 내용을 원하는대로 추가 -->
					              <img id="xrayImg" src="\${img}" style= "width:100%; height : 100%;  "/>
					          </div>
					
					          <!-- 오른쪽 테이블 -->
					          <div style="flex: 1; padding: 10px;  width : 48%;">
					              <div class="table-responsive text-nowrap" style="height:100%; width:100%;">
					                  <table class="table table-hover" style="font-size: 11px;">
					                      <thead>
					                          <tr>
					                              <th>NO.</th>
					                              <th>촬영코드</th>
					                              <th>촬영부위</th>
					                              <th>촬영일자</th>
					                              <th>촬영</th>
					                          </tr>
					                      </thead>
					                      <tbody class="table-border-bottom-0 itable">
					
					                      </tbody>
					                  </table>
					              </div>
					          </div>
					      </div>
						  <div style="text-align : right; margin-top : 10px;">
					     	 <button type="button" id="presbtn" onclick="iEndBtn()" class="btn btn-primary" style="margin-right:30px;">완료</button>
						  </div>					  
					  </div>`;
						
	let gridStack4 = `<div style="background-color:white; width:100%; height:100%;">
                    <div class="card" style="height:100%; padding: 20px 0px 20px 20px; ">
                        <h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:305px; font-weight: bold;">검사오더 </h5>
                        <div class="table-responsive text-nowrap" style="height:165px;">
                            <table class="table table-hover" style="font-size: 11px;">
                                <thead>
                                    <tr>
                                        <th>NO.</th>
                                        <th>촬영 코드</th>
                                        <th>촬영부위</th>
                                        <th>업로드</th>
                                    </tr>
                                </thead>
                                <tbody class="table-border-bottom-0 insptable">
                                </tbody>
                            </table>
                        </div>
                        <div id="memoTextArea">
                        </div>
                           
                    </div>
                </div>`;
	
	
// 그리드 스택 아이템 배열
var items = [
    { w: 2, h: 5, float: false, content: gridStack1 },
    { w: 3, h: 4, float: false, content: gridStack2 },
    { w: 7, h: 5, float: false, content: gridStack3 },
    { w: 3, h: 2, float: false, content: gridStack4 }

];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
const treatWaitList = $('#gr1Content');
const hFileCode = $('#hFileCode');
// 검사 대기 환자 목록 출력
function waitInspection(){
	$.ajax({
		url:"/insp/waitInspection",
		type : "get",
		dataType:"JSON",
		success:function(rslt){
// 			console.log("나오니", rslt);
			let text = '';
			text += `
				<table class="table table-hover"style="text-align : left;">
				 <thead>
					 <tr> 
					 	<th style="text-align : center;">
			 				<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
								<div style="display:flex; width:177px;">
				 		
				 					<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
				 					<p style="margin: 8px 0px 0px 6px;">검사대기 :\${rslt.length}명</p>
				 		
			 					</div>
								</h5>
								<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: -15px 120px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;"> 영상과    | 담당 : ${empVO.empNm}</span>
							</th>
						</tr> 
					</thead>
 		`;
		$.each(rslt, function(i,item){	
			console.log("item.patWait", item.patWait);
			let buttonText = "검사대기"; // 기본 버튼 텍스트
			let buttonClass = "btn btn-xs btn-info"; // 기본 버튼 클래스
			if (item.patWait == '검사중') {
				buttonText = "검사중";
				buttonClass = "btn btn-xs btn-secondary";
			}
				text += `
						<tbody>
		 					<tr>
			 					<td style="padding:1rem;">
			 					<h5 class="mb-0" style="margin-left:5px; margin-top:5px;"><strong>\${rslt[i].patName}</strong> <small>| \${rslt[i].patBrthdy}</small></h5>
						        	<div style="display: flex; justify-content: space-between; align-items: center;">
									<div>
									<h6 class="mb-0" style="margin-left : 4px;"> <small>\${rslt[i].patGen} | \${rslt[i].patFirst} | \${rslt[i].patHsptlzStatus} </small></h6>
									</div>
									<div style="margin-right: 5px; margin-top:5px;">
							            <button id="${item.patCode}" class="\${buttonClass}" style="margin-bottom:10px; margin-right:50px; margin-top : -20px;" onclick="waitClick(\${item.patCode},\${item.treatNo},\${item.detailNo})">
							            \${buttonText}</button>
						            </div>
						        </div>
					   		</td>						
			 					</tr>
	 					</tbody>`;
			
	})
					text += `</table>`;
			treatWaitList.html(text);
			
			
		},
		error: function (xhr, status, error) {
    	     console.log("code: " + xhr.status);
    	     console.log("message: " + xhr.responseText);
    	     console.log("error: " + error);
  	    }
	})
}
let treatNoUp="";
function waitClick(patCode,treatNo,detailNo){
	//var callButton = event.target;
	let tableinsp =$(".insptable");
	let memo =$("#memoTextArea");
	treatNoUp = treatNo;
    // 버튼의 스타일을 변경합니다.
  	// 버튼의 클래스를 변경합니다.
    //callButton.className = "btn btn-secondary"; // 원하는 클래스 이름으로 변경
    //callButton.innerHTML = "검사중"; // 글자를 "진료중"으로 변경
	console.log("내가선택한 환자 코드 입니다.",patCode);
	console.log("내가선택한 환자 접수 번호 입니다.",treatNo);
	console.log("내가선택한 환자 접수 번호 입니다222.",treatNoUp);
	console.log("내가선택한 환자 차트  번호 입니다.",detailNo);
	
	Swal.fire({
		icon: 'success',
		title: '환자 호출',
		});
	$.ajax({
		url :"/insp/waitpatClick/"+patCode+"/"+treatNo+"/"+detailNo,
		type : 'get',
		dataType : 'JSON',
		success : function(rslt){
			console.log("뭐 나와 ? ",rslt);
			
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
             let textInsp = '';
             let textMemo = '';
            
             for(let i =0; i<rslt.inspListVO.length; i++){
            	console.log("inspListVO확인 ==>",rslt.inspListVO);
             	textInsp += `<tr>
		                    <td>\${i+1}</td>
		                    <td>\${rslt.inspListVO[i].inspcCode}</td>
		                    <td>\${rslt.inspListVO[i].inspcType}</td>
		                    <td><button type="button" onclick="filmingClick('\${detailNo}\${rslt.inspListVO[i].inspcCode}')" class="btn btn-primary okTbtn" style="font-size : 11px;">촬영</button></td></tr>
           	 				`;
             }
             textMemo +=  `
            	 <h6 class="card-header" style="text-align:left; margin-left:-5px; font-weight: bold; padding:10px 0px 5px 25px; ">오더 내용</h6>
             			<textarea class="form-control" name="memo" cols="50" rows="2" id="memotext" style="width:350px; margin-left:15px;" readonly>\${rslt.inspListVO[0].inspcMemo}</textarea>`;
             updateTreatSttusIng();
             waitInspection();
             tableinsp.html(textInsp);
             memo.html(textMemo);
             detailNo2 = detailNo; 
             let msg = {
 					to: "의사,원무",
 					from: "검사",
 					cmd: "ingInspc"
 			}
 			webSocket.send(JSON.stringify(msg));
             
             
		},
		error: function (xhr, status, error) {
    	     console.log("code: " + xhr.status);
    	     console.log("message: " + xhr.responseText);
    	     console.log("error: " + error);
    	 }
	})
}
function filmingClick(fileCode){
	var filming = event.target;
	filmingModal.style.display = "block";
	hFileCode.val(fileCode);
	console.log("오점뭐",fileCode);
	filming.className = "btn btn-secondary";

		
}

function updateTreatSttusIng(){
	$.ajax({
		url : "/insp/updateInspSttusIng/"+treatNoUp,
		type : "get",
		dataType : "JSON",
		success : function(rslt){
			console.log("rslt " , rslt);
			if(rslt == 1 ){
				console.log("촬영중");
			}
		},
		error: function(xhr, status, error) {
    	    console.log("code: " + xhr.status);
    	    console.log("message: " + xhr.responseText);
    	    console.log("error: " + error);
    	}
	});	
}

function iEndBtn(){
	$("#xrayImg").attr("src", img);
	$("#patCode0").val(""); 		// 환자코드
	$("#patTel0").val("");	  		// 연락처
	$("#patDtlAddr0").val("");	// 상세 주소
	$("#patName0").val("");
	$("#patAddr0").val("");
	$("#patFirstDate0").val("");
    $("#patLastDate0").val("");
    $(".insptable tr").remove();
    $("#memotext").val("");
    $(".itable tr").remove();
	$.ajax({
		url : "/insp/updateInspSttusEnd/"+treatNoUp,
		type : "get",
		dataType : "JSON",
		success : function(rslt){
			console.log("rslt " , rslt);
			if(rslt == 1 ){
				Swal.fire({
					icon: 'success',
					title: '검사가 완료되었습니다.',
					});
			}
			let msg = {
					to: "검사",
					from: "의사",
					cmd: "endInspc"
			}
			webSocket.send(JSON.stringify(msg));
			
			console.log(msg, "파일 완료");
			waitInspection();
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
	// 검사 대기
	if (serverMsg.cmd == "plzInspc") {
		waitInspection();
	}

}
</script>
</body>
</html>



