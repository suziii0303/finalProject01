<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
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
.gs-12>.grid-stack-item[gs-w="2"] {
    width: 296px;
 }
/*grid 2, 3*/
 .gs-id-0 > .grid-stack-item[gs-x="2"] {
    left: 291px;
}
.gs-id-0 > .grid-stack-item[gs-h="3"] {
    height: 412px;
}
.gs-12>.grid-stack-item[gs-w="3"] {
    width: 422px;
}
.gs-12>.grid-stack-item[gs-w="7"] {
    width: 1163px;
}
.gs-id-0 > .grid-stack-item[gs-y="3"] {
    top: 405px;
}
.gs-id-0 > .grid-stack-item[gs-x="5"] {
    left: 706px;
}

/*grid 4,5 */
 .gs-id-0 > .grid-stack-item[gs-x="2"] {
    left: 291px;
}
.gs-id-0 > .grid-stack-item[gs-h="2"] {
    height: 385px;
}
.gs-12>.grid-stack-item[gs-w="3"] {
    width: 422px;
}
.gs-12>.grid-stack-item[gs-w="7"] {
    width: 1163px;
}
.gs-id-0 > .grid-stack-item[gs-y="3"] {
    top: 405px;
}
.gs-id-0 > .grid-stack-item[gs-x="5"] {
    left: 706px;
}
    
.bedImg{
   width:80px; 
   height:80px; 
   margin-left:30px; 
   margin-right:30px;
}
#bedModal{
   display:none;
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
<body>

<div class="grid-stack"></div>

<script type="text/javascript">



$(function() {
   //침상  체크박스 임시저장인척하는 폼 초기화
   $("#pTempBtn").on("click",function(){
      
	  let formData = new FormData();
	   
	  //TB_BED_STATUS
	  //PHYSIO_CODE, BED_NO
	  let bedNo = $("#bedNo2").val();
// 	  console.log("bedNo : " + bedNo);
	  
	  formData.append("bedNo",bedNo);
	  
	  let chkStr = "";
	  
	  $("input[name='physioContent']").each(function(i){
         if($(this).is(":checked")){
            chkStr += $(this).val() + ",";
			  formData.append("physioCodes",$(this).val());
         }
      });
	  
// 	  console.log("physioCode : " + chkStr);
	   
      //alert("해당 내용을 저장하시겠습니까?");
//       Swal.fire({
// 	         icon: 'success',
// 	         title: '치료내용 저장완료',
// 	         text: '치료내용이 저장되었습니다.',
// 	      });
      $("#bedDiv input").val('');
      
      var physioContentArea = $("#physioContentArea"); 
      physioContentArea.empty(); // 기존 내용 지우기
       
      $.ajax({
    	  url:"/physio/bedStatusUpdate",
		  processData:false,
		  contentType:false,
		  data:formData,
		  type:"post",
		  dataType:"json",
		  success:function(result){
		      Swal.fire({
		         icon: 'success',
		         title: '치료내용 저장완료',
		         text: '치료내용이 저장되었습니다.',
		      });
		  }
      });
      
   });
   physiotherapyWait();
   
   //침상배정을 DB로부터 불러오기
   $.ajax({
      url:"/physio/bedStatusList",
      dataType:"json",
      type:"post",
      success:function(result){
         //result : List<BedVO>
//          console.log("result : " + JSON.stringify(result));
         
         $.each(result,function(i,bedVO){
//             console.log("bedNo : " + bedVO.bedNo + ", bedStat : " + bedVO.bedStat);
            
            if(bedVO.bedStat=='EMPT'){
               $("#bed"+bedVO.bedNo).attr("src","/resources/images/bed.png");
            }else{
               $("#bed"+bedVO.bedNo).attr("src","/resources/images/blackBed.jpg");
            }
         });
      }
   });
   
   // 치료현황을 DB로부터 불러오기
   $.ajax({
       url: "/physio/physioStat",
       type: "post",
       dataType: "json",
       success: function (res) {
//            console.log("치료현황 찍어보자 : ", res);
   
           if (res.length === 0) {
              $("#physioStatArea").html("<p>치료현황이 존재하지 않습니다.</p>");
           } else {
               let newRow = physioStatTH();
   
               newRow += "<tbody>";
               $.each(res, function (index, item) {
                   newRow += "<tr>";
                   newRow += "<td style='width:10%'>" + item.bedNo + "</td>";
                   newRow += "<td style='width:15%'>" + item.patCode + "</td>";
                   newRow += "<td style='width:10%'>" + item.patName + "</td>";
                   newRow += "<td style='width:15%'>" + item.patBrthdy + "</td>";
                   newRow += "<td style='width:22%'>" + item.physioCode + "</td>";
                   newRow += "<td style='width:22%'>" + item.physioContent + "</td>";
                   if (item.clnicSttusCode == "PING") {
                        newRow += "<td style='width:20%'>진행중</td>";
                      } else {
                        newRow += "<td style='width:20%'>" + item.clnicSttusCode + "</td>";
                      }
                   newRow += "</tr>";
               });
               newRow += "</tbody>";
   
               $("#physioStatArea").html(newRow);
           }
       },
       error: function (xhr, status, error) {
           console.log("code: " + xhr.status);
           console.log("message: " + xhr.responseText);
           console.log("error: " + error);
       }
   });
});


   // 그리드 스택 아이템 정의
   /////////////////////////////// 대기환자 목록  시작 /////////////////////////////////////
   let gridStack1 = 
      `
		<div class="table-responsive text-nowrap" style="overflow:hidden;">
		    <table class="table table-hover" style="text-align : left;">
		      <thead>
		        <tr> 
		          <th style="text-align : center;" id="waitTotal"></th>
		        </tr>
		     </thead> 
		      <tbody class="table-border-bottom-0" id="waitTBody" style="border-bottom: 2px solid #d9dee3;">     
		      </tbody>
		    </table> 
	  	</div>
      `;
   /////////////////////////////// 대기환자 목록  끝 /////////////////////////////////////
      
   /////////////////////////////// 환자 정보 시작 /////////////////////////////////////
   let gridStack2 = 
      `<div style="background-color:white; width:100%; height:100%;">
      <div id="patInfoDiv" class="card-body" style="width:100%; height:100%; padding:20px 0px 20px 20px;">
      <div style="display:flex;margin-bottom:-5px;">
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
               <span class="fw-medium me-2" style="display:inline-block; width:80px;margin-left: 7px;" >환자코드  </span>
               <input type="text" name="patCode" class="form-control form-control-sm" id="patCode0" style="width:67%;" readonly>
             
            </li>
            <li class="mb-3">
               <span class="fw-medium me-2" style="display:inline-block; width:80px;margin-left: 7px;" >환자명  </span>
               <input type="text" name="patName" class="form-control form-control-sm " id="patName0" style="width:67%;" readonly>
            </li>
            
            <li class="mb-3">
              <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px;">연락처  </span>
               <input type="text" name="patTel" class="form-control form-control-sm" id="patTel0" style="width:67%;" readonly >
            </li>

            <li class="mb-3">
               <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px;">최초내원일  </span>
               <input type="text" name="patFirstDate" class="form-control form-control-sm" id="patFirstDate0" style="width:67%;" readonly>
            </li>
            
            <li class="mb-3">
               <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px;">최근내원일  </span>
                 <input type="text" name="patLastDate" class="form-control form-control-sm" id="patLastDate0" style="width:67%;" readonly>
            </li>
            
            <li class="mb-3">
            <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px;">주소  </span>
            <input type="text" name="patAddr" class="form-control form-control-sm" id="patAddr0" style="width:67%;" readonly>
            </li>
            
            <li class="mb-3">
            <span class="fw-medium me-2" style="display:inline-block;width:80px;margin-left: 7px;">상세주소  </span>
            <input type="text" name="patDtlAddr" class="form-control form-control-sm" id="patDtlAddr0" style="width:67%;" readonly ><br>
            </li>
            
            <input type="hidden" name="patGenCode" id="patGenCode0" >
            <input type="hidden" name="patAge0" id="patAge0" >
          </ul>
          </div>
          </div>
          <div class="d-flex justify-content-center pt-3">        
          </div>
        </div>
      </div>
      </div>`;
   /////////////////////////////// 환자정보  끝 /////////////////////////////////////
   
   /////////////////////////////// 침상 배정  시작 /////////////////////////////////////
  
    let gridStack3 = `
         <div class="card-body" style="width:100%; height:100%; padding:20px 0px 20px 20px;">
         <div style="display:flex;">
          <div>
              <h5 class="pb-2 border-bottom mb-1" style="text-align:left; margin-right:120px; font-weight: bold;">침상배정 </h5>
          </div>
          </div>
                  <div style="display:flex;"> 
                <div>
                     <div style="display: flex;">
                        <div>
                         <div><img class="bedImg" id="bed1" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('1')"/></div>
                         <div style="font-size : 12px;">침상 1번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed2" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('2')"/></div>
                         <div style="font-size : 12px;">침상 2번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed3" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('3')"/></div>
                         <div style="font-size : 12px;">침상 3번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed4" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('4')"/></div>
                         <div style="font-size : 12px;">침상 4번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed5" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('5')"/></div>
                         <div style="font-size : 12px;">침상 5번</div>
                         </div>
                     </div>
                     
                     <div style="display: flex;">
                        <div>
                         <div><img class="bedImg" id="bed6" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('6')"/></div>
                         <div style="font-size : 12px;">침상 6번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed7" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('7')"/></div>
                         <div style="font-size : 12px;">침상 7번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed8" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('8')"/></div>
                         <div style="font-size : 12px;">침상 8번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed9" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('9')"/></div>
                         <div style="font-size : 12px;">침상 9번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed10" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('10')"/></div>
                         <div style="font-size : 12px;">침상 10번</div>
                         </div>
                     </div>
                     
                     <div style="display: flex;">
                        <div>
                         <div><img class="bedImg" id="bed11" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('11')"/></div>
                         <div style="font-size : 12px;">침상 11번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed12" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('12')"/></div>
                         <div style="font-size : 12px;">침상 12번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed13" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('13')"/></div>
                         <div style="font-size : 12px;">침상 13번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed14" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('14')"/></div>
                         <div style="font-size : 12px;">침상 14번</div>
                         </div>
                        <div>
                         <div><img class="bedImg" id="bed15" src="/resources/images/bed.png" alt="침상사진" onclick="BedClick('15')"/></div>
                         <div style="font-size : 12px;">침상 15번</div>
                         </div>
                     </div>
                  </div>
                  
                  
                  <div id="bedDiv" style="width: 400px;"> 

            <div style="margin-top : 30px;">
               <div class="row mb-1" style="display:flex;">
                   <div class="col-sm-4">
                       <label class="col-form-label" for="">침상번호</label>
                   </div>
                   <div class="col-sm-4">
                       <input type="text" class="form-control form-control-sm" id="bedNo2" name="bedNo2" style="width:150%" readonly>
                   </div>
               </div>
               
               <div class="row mb-1" style="display:flex;">
                   <div class="col-sm-4">
                       <label class="col-form-label" for="">환자명</label>
                   </div>
                   <div class="col-sm-4">
                       <input type="text" class="form-control form-control-sm" id="patName2" name="patName2" style="width:150%" readonly>
                   </div>
               </div>
               
               <div class="row mb-1" style="display:flex;">
                   <div class="col-sm-4">
                       <label class="col-form-label" for="">생년월일</label>
                   </div>
                   <div class="col-sm-4">
                       <input type="text" class="form-control form-control-sm" id="patBrthdy2" name="patBrthdy2" style="width:150%" readonly>
                   </div>
               </div>
               
               <div class="row mb-1" style="display:flex;">
                   <div class="col-sm-4">
                       <label class="col-form-label" for="">성별</label>
                   </div>
                   <div class="col-sm-4">
                       <input type="text" class="form-control form-control-sm" id="patGenCode2" name="patGenCode2" style="width:150%" readonly>
                       <input type="hidden" class="form-control form-control-sm" id="treatNoo" name="treatNo"  readonly>
                   </div>
               </div>
               </div>
               
               <div class="row mb-1" style="display:flex;">
                   <div class="col-sm-4">
                       <label class="col-form-label" for="">치료내용</label>
                   </div>
                   <div class="col-sm-4" style="margin-right:10px;width:100px;" id="physioContentArea"></div>
               </div>
               
               <div  class="row mb-4" style="display:flex;justify-content: right;margin-right: 60px; margin-top: 2vw;">
                      <button id="pTempBtn" class="btn btn-xs btn-info" style="width: 4vw;margin-right: 10px;">임시저장</button>
                      <button onclick="pEndBtn()" id="pEndBtn" class="btn btn-xs btn-secondary" style="width: 4vw;" >치료완료</button>
               </div>
               
               </div>
            </div>

                  </div>
                  
                  </div>
                  
                  </div>
             </div>
      </div>`;
   /////////////////////////////// 칭상 배정 끝  /////////////////////////////////////
   
   /////////////////////////////// 오더내역 시작  /////////////////////////////////////
   let gridStack4 = `
   <div style="background-color:white; width:100%; height:100%;">
      <div class="card-body" style="width:100%; height:100%; padding:20px 20px 20px 20px;">
      <div style="display:flex;">
       <div>
           <h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold;">오더내용 </h5>
       </div>
       </div>
      
       <div class="col-xl-12" >
       <div class="nav-align-top mb-4">
         <ul class="nav nav-tabs" role="tablist" >
           <li class="nav-item" role="presentation">
             <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#physioListArea" aria-controls="navs-top-home" aria-selected="false" tabindex="-1">오더내용</button>
           </li>
           <li class="nav-item" role="presentation">
             <button type="button" class="nav-link " role="tab" data-bs-toggle="tab" data-bs-target="#physioHistoryArea" aria-controls="navs-top-profile" aria-selected="true">치료내역</button>
           </li>
         </ul>
         <div class="tab-content" style="padding: 1rem; width:100%; "  >
           <div class="tab-pane fade active show" id="physioListArea" role="tabpanel" >
           </div>
           
           <div class="tab-pane fade " id="physioHistoryArea" role="tabpanel">
           </div>

         </div>
       </div>
     </div>
                  </div>
   
   </div>`;
   /////////////////////////////// 오더내역 끝  /////////////////////////////////////
      
   /////////////////////////////// 치료 현황 시작  /////////////////////////////////////
   let gridStack5 = `
      <div style="background-color:white; width:100%; height:100%;">
      <div class="card-body" style="width:100%; height:100%; padding:20px 20px 20px 20px;">
      <div style="display:flex;">
       <div>
           <h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold;">치료현황 </h5>
       </div>
       </div>
       
       <div class="col-xl-6">
       <div class="nav-align-top mb-4">
         <div class="tab-content" style="padding: 1rem; width:200%;" >
           
           <div id="physioStatArea" style="max-height: 100%;  overflow-y: scroll;">
           </div>

         </div>
       </div>
     </div>
                  </div>
   
   </div>`;
   /////////////////////////////// 치료 현황 끝  /////////////////////////////////////
   
// 그리드 스택 아이템 배열
var items = [
    { w: 2, h: 5, float: false, content: gridStack1 },
    { w: 3, h: 3, float: false, content: gridStack2 },
    { w: 7, h: 3, float: false, content: gridStack3 },
    { w: 3, h: 2, float: false, content: gridStack4 },
    { w: 7, h: 2, float: false, content: gridStack5 }

];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
const physioWaitList = $('#gr1Content');


const waitTotal = $('#waitTotal');  //대기환자목록
const waitTBody = $('#waitTBody');  //대기환자목록

var empNm = "${ empVO.empNm}";
console.log(empNm);

// 대기환자
function physiotherapyWait (){
   $.ajax({
      url :'/physio/physioWait',
      type : 'get',
      dataType : 'JSON',
      success : function(rslt){
    	  
//     	 console.log("테스트2 : " + "${empVO2.empNm}");
    	 let empNm = "${empVO2.empNm}";
    	 
         let top = "";
	     let text = "";
         top += `
        	  <h5 class='pb-2 border-bottom mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold; border-bottom:none !important;'>
				<div style="display:flex;">
					<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
					<p style="margin: 8px 0px 0px 6px;">치료대기 : \${rslt.length}명</p>
				</h5>
				</div>
				<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: -15px 120px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;"> 물리치료과 | 담당 :${empVO2.empNm} </span>`;
          waitTotal.html(top);
//           console.log("치료대기 목록 출력 ", rslt);
          
          if(rslt.length == 0){
//               console.log("하이")           
//               $("#waitTBody td").removeAttr("style");
              $("#waitTBody").find('tr').text('');
           }
          
          
          $.each(rslt, function(i,item){
//         	 console.log("들어오낭???ㅡㅡ" + item.patWait);
             if(item.patWait == "치료대기"){      
//         	  console.log("들어오낭????2" + item.patWait);
               text += `
            	   <tr>
			        <td style="padding:1rem;">
			       		 <h5 class="mb-0" style="margin-left:5px; margin-top:5px;"><strong>\${rslt[i].patName}</strong> <small>| \${rslt[i].patBrthdy}</small></h5>
				        <div style="display: flex; justify-content: space-between; align-items: center;">
							<div>
								<h6 class="mb-0" style="margin-left : 4px;"><small>\${rslt[i].patGen} | \${rslt[i].patFirst} | \${rslt[i].patHsptlzStatus} </small></h6>
							</div>
				            <div style="margin-right: 5px; margin-top:5px;">
				            <button id="${item.patCode}" class="btn btn-xs btn-info" style="margin-bottom:10px; margin-right:80px; margin-top : -20px;" onclick="waitClick(\${item.patCode},\${item.treatNo},\${item.detailNo},this)">\${item.patWait}</button>
				            </div>
				        </div>
			   		</td>
		        </tr>
               `; 
               
               
             }else if(item.patWait == "치료중") {
                 text += `
              	   <tr>
  			        <td style="padding:1rem;">
  			       		 <h5 class="mb-0" style="margin-left:5px; margin-top:5px;"><strong>\${rslt[i].patName}</strong> <small>| \${rslt[i].patBrthdy}</small></h5>
  				        <div style="display: flex; justify-content: space-between; align-items: center;">
  							<div>
  								<h6 class="mb-0" style="margin-left : 4px;"> <small>\${rslt[i].patGen} | \${rslt[i].patFirst} | \${rslt[i].patHsptlzStatus} </small></h6>
  							</div>
  				            <div style="margin-right: 5px; margin-top:5px;">
  				            <button id="${item.patCode}" class="btn btn-xs btn-secondary" style="margin-bottom:10px; margin-right:80px; margin-top : -20px;" onclick="waitClick(\${item.patCode},\${item.treatNo},\${item.detailNo},this)">\${item.patWait}</button>
  				            </div>
  				        </div>
  			   		</td>
  		        </tr>
                 `;
             } 
             waitTBody.html(text);
         });
             // 웹소켓으로 일정등록을 연락!
             let msg = {
                to: "물리치료사",
                from: "원무과",
                cmd: "ingPhysio"
             }
             webSocket.send(JSON.stringify(msg));
         physioWaitList.html(text);
      },
      error: function (xhr, status, error) {
             console.log("code: " + xhr.status);
             console.log("message: " + xhr.responseText);
             console.log("error: " + error);
          }
   });
}

// 치료대기 버튼 클릭
let isGo=true; // 전역으로 변수선언
function waitClick(patCode,treatNo, detailNo,pThis){

   // "치료중"환자 침상 배정 중복 방지
   isGo = true;
   if(pThis.innerHTML == "치료중"){
      isGo = false;
   }

   $("treatNo").val(treatNo);

   let xhr = new XMLHttpRequest();
   let patInfoUrl = "/physio/main/"+patCode+"/"+treatNo;
   xhr.open("get",patInfoUrl,true);
   xhr.onreadystatechange = function(){
       if(xhr.readyState == 4 && xhr.status == 200){
         let patientVO = xhr.responseText;
         if(patientVO){
            patientVO = JSON.parse(patientVO); // json문자열로

            $("#patCode0").val(patientVO.patCode);
            $("#patName0").val(patientVO.patName);
            $("#patTel0").val(patientVO.patTel);
            $("#patGenCode0").val(patientVO.patGenCode);
            $("#patAddr0").val(patientVO.patAddr);
            $("#patDtlAddr0").val(patientVO.patDtlAddr);
            $("#patZip0").val(patientVO.patZip);
            $("#patAge0").val(patientVO.patBrthdy);

            if(patientVO.patFrgnrYn = '부'){
                   var frgnrYn = '내국인';
                }else{
                   var frgnrYn = '외국인';
                }

            var patName = patientVO.patName;
            var genCode = patientVO.patGenCode;
            var Brthdy = patientVO.patBrthdy;
            var patHsptlzStatus = patientVO.patHsptlzStatus;
            
            // 테스트 | 19980813 | 여 | 내국인 | 외래
            var test = patName + " " + "|" + " " + Brthdy + " " + "|" + " " +genCode + " " + "|" + " " +frgnrYn + " " + "|" + " " +patHsptlzStatus;
            $("#patName0").val(test);

            var patAddr = patientVO.patAddr;
            var patZip = patientVO.patZip;
            
            // 대전 서구 만년로35 (35201)
            var test2 = patAddr + " " + "(" + patZip + ")";
            $("#patAddr0").val(test2);

            
                $("#patFirstDate0").val(patientVO.patFirstDate);
                $("#patLastDate0").val(patientVO.patLastDate);  

               let patCode = patientVO.patCode;
         }
      } 
       physiotherapyWait();
      
   }
   xhr.send();
   
   // 오더내용
   //위 아작스의 결과값이 필요하지 않으면 AJAX는 분리시켜 동작시키는 것이 유리 
//    console.log("체킁:",treatNo);
   $.ajax({
         url : `/physio/physioList/\${treatNo}`,
         type : "post",
         dataType : "json",
         success : function(res){
//             console.log("성공했니?",res);
            
            let treatNo = res.treatNo;
            let newRow = orderListTH();
            
            newRow += "<tbody>";
            $.each(res, function(index, item){
                       newRow += "<tr >";
                       newRow += "<td style='font-size:0.75rem;width:27%;'>" + item.physoDate +"</td>";
                       newRow += "<td style='font-size:0.75rem; width:27%;'>" + item.treatNo + "</td>";
                       newRow += "<td style='font-size:0.75rem;width:27%;'>" + item.physioCode+ "</td>";
                       newRow += "<td style='font-size:0.75rem;width:35%;'>" + item.physioContent +"</td>";
                       newRow += "</tr>";
            });
            newRow += "</tbody>";
            
            $("#physioListArea").html(newRow);
         },
         error : function(xhr){
               console.log("code: " + xhr.status);
                console.log("message: " + xhr.responseText);
                console.log("error: " + xhr.error);
         }
      });

      // 치료내역
      $.ajax({
         url : `/physio/physioHistory/\${patCode}`,
         type : "POST",
         dataType : "json",
         success : function(res){
            
//             console.log("치료내역 success: " + res);
            
              if (res.length === 0) {
                  // 데이터가 없는 경우 "값없음" 메시지를 표시
                  $("#physioHistoryArea").html("<p>치료내역이 없습니다.</p>");
              } else {
                  let treatNo = res.treatNo;
                  let newRow = physioListTH();

                  newRow += "<tbody>";
                  $.each(res, function (index, item) {
                      newRow += "<tr>";
                      newRow += "<td style='font-size:0.75rem;width:27%;'>" + item.physoDate + "</td>";
                      newRow += "<td style='font-size:0.75rem;width:27%;'>" + item.treatNo + "</td>";
                      newRow += "<td style='font-size:0.75rem;width:27%;'>" + item.physioCode + "</td>";
                      newRow += "<td style='font-size:0.75rem;width:35%;'>" + item.physioContent + "</td>";
                      newRow += "</tr>";
                  });
                  newRow += "</tbody>";

                  $("#physioHistoryArea").html(newRow);
              }
          },
          error: function (xhr) {
              console.log("code: " + xhr.status);
              console.log("message: " + xhr.responseText);
              console.log("error: " + xhr.error);
          }
      });
   
   

}

// 오더내용 목록 
function orderListTH(){
   let row = `
      <thead><tr>
      <th style='font-size:1rem; '>치료일자</th>
      <th >진료번호</th>
      <th>치료코드</th>
      <th>치료내용</th>
   `;
   return row;
}

// 치료내용 목록 
function physioListTH(){
   let row = `
      <thead><tr>
      <th style='font-size:1rem; '>치료일자</th>
      <th>진료번호</th>
      <th>치료코드</th>
      <th>치료내용</th>
   `;
   return row;
}

//치료현황
function physioStatTH(){
   let statRow = 
   `<thead><tr>
   <th style="margin-bottom : 20px;">침상번호</th>
   <th>환자코드</th>
   <th>환자명</th>
   <th>생년월일</th>
   <th>치료코드</th>
   <th>치료내용</th>
   <th>진행상태</th>
   `;
   return statRow;
}

//치료현황 함수
function physioStatFunc(){
   $.ajax({
       url: "/physio/physioStat",
       type: "post",
       dataType: "json",
       success: function (res) {
           console.log("치료현황 찍어보자 : ", res);
   
           if (res.length === 0) {
              $("#physioStatArea").html("<p>치료현황이 존재하지 않습니다.</p>");
           } else {
               let newRow = physioStatTH();
   
               newRow += "<tbody>";
               $.each(res, function (index, item) {
                   newRow += "<tr>";
                   newRow += "<td style='width:10%'>" + item.bedNo + "</td>";
                   newRow += "<td style='width:15%'>" + item.patCode + "</td>";
                   newRow += "<td style='width:10%'>" + item.patName + "</td>";
                   newRow += "<td style='width:15%'>" + item.patBrthdy + "</td>";
                   newRow += "<td style='width:22%'>" + item.physioCode + "</td>";
                   newRow += "<td style='width:22%'>" + item.physioContent + "</td>";
                   if (item.clnicSttusCode == "PING") {
                        newRow += "<td style='width:20%'>진행중</td>";
                      } else {
                        newRow += "<td style='width:20%'>" + item.clnicSttusCode + "</td>";
                      }
                   newRow += "</tr>";
               });
               newRow += "</tbody>";
   
               $("#physioStatArea").html(newRow);
           }
       },
       error: function (xhr, status, error) {
           console.log("code: " + xhr.status);
           console.log("message: " + xhr.responseText);
           console.log("error: " + error);
       }
   });
}


// 침상클릭
let bedNo;
let newRow = physioStatTH();

function BedClick(idx){
   
   // 침상배정  중복 방지
   if(!isGo){
      Swal.fire({
         icon: 'info',
         title: '침상중복배정',
         text: '이미 치료중인 환자입니다.',
      });
      return;
   }
   
   bedNo = Number(idx);  // 침상 넘버
    let bedColor = $("#bed"+ idx).attr("src").includes("black")?"black":"white";
    let patCode = $("#patCode0").val()
    let data = {"patCode":patCode,"bedNo":bedNo};
    

   // patCode가 없으면  && whiteBed 이면 alert
   // patCode가 없으면  && blackbed이면 침상정보가 뜬당
   // patCode가 있으면  && whiteBed 이면  값을 넣고-> 검정색으로 바뀌어야 함
   // patCode가 있으면  && blackbed이면 안된다공 메세징!
   
//    console.log("체킁2:",patCode,bedColor);
   if(patCode=="" && bedColor=="white"){ // patCode가 없으면  && whiteBed 이면 alert
       Swal.fire({
         icon: 'info',
         title: '치료대상환자선택',
         text: '치료대상환자를 선택해주세요',
      });
       
   }else if(patCode=="" && bedColor=="black"){  // patCode가 없으면  && blackbed이면 침상정보가 뜬당
      
//       console.log("침상정보 div에 찍기");   
      
      $.ajax({
         url : "/physio/getReceiptInfo",
         contentType:"application/json;charset=utf-8",
         data:JSON.stringify(data),
         dataType:"json",
         type:"post",
         success:function(res){
             
//             console.log("성공찍히나 보자 " +JSON.stringify(res));
            
             // 결과에서 필요한 데이터 추출
             var resultData = res;
             // 침상번호
             $("#bedNo2").val(resultData.bedStatusVO[0].bedNo);
             // 환자명
             $("#patName2").val(resultData.patientVO.patName);
             // 생년월일
             $("#patBrthdy2").val(resultData.patientVO.patBrthdy);
             // treatNo 히든
             $("#treatNoo").val(resultData.clinicVO.treatNo);
             
//              console.log("treatNoo", $("#treatNoo").val());
             // 성별
            var patGenCode = resultData.patientVO.patGenCode;

             if (patGenCode == "F"){
                   var patGenCode = "여성";
                }else{
                   var patGenCode = "남성";
                }
             $("#patGenCode2").val(patGenCode);
             
             
             var physioContentArea = $("#physioContentArea"); 
             physioContentArea.empty(); // 기존 내용 지우기
             
             //침상번호에 저장된 치료내용
             let chkStr = localStorage.getItem("bed"+resultData.bedStatusVO[0].bedNo);
//              console.log(resultData.bedStatusVO[0].bedNo + "침상번호에 저장된 치료내용 : " + chkStr)
         
             for (var i = 0; i < resultData.bedStatusVO.length; i++) {
                 var physioContentValue = resultData.bedStatusVO[i].physioContent;
         
                 // 라벨 요소 생성 및 설정
                 var label = $('<label>').text(physioContentValue);
                
                 var checkbox = $('<input class="form-check-input" type="checkbox" name="physioContent" data-bedno="'+resultData.bedStatusVO[0].bedNo+'" id="checkboxInfo" class="physio-content-checkbox">');
                  checkbox.val(physioContentValue);
                 
                 // 침상 체크박스 선택 유지하기 위해 value 비교
//                   console.log("chkStr : " + chkStr);
                 
                 //TB_BED_STATUS 테이블의 PHYSIO_YN의 값이 Y이면 체크 처리
                 let physioYn = resultData.bedStatusVO[i].physioYn;
//                  console.log("physioYn : " + physioYn);
                 if(physioYn=="Y"){
                	 checkbox.prop('checked',true);
                 }
         
                 // 각 항목을 감싸는 <div> 요소 생성
                 var containerDiv = $('<div>');
                                                                                             
                 containerDiv.css('text-align', 'left');
                 containerDiv.append(checkbox);
                 containerDiv.append(label);

                 physioContentArea.append(containerDiv);
                 
             }
             
//              //치료내용 체크박스 처리
//              $(".physio-content-checkbox").change(function() {
//                 let bedno = $(this).data("bedno");
//                  // 체크박스 상태를 localStorage에 저장
//                  let chkStr = "";
//                  $("input[name='physioContent']").each(function(i){
//                     if($(this).is(":checked")){
//                        chkStr += $(this).val() + ",";
//                     }
//                  });
//                  console.log("chkStr : " + chkStr);
//                  //bed1번에 "견인치료,아쿠아치료,"
//                  localStorage.setItem("bed"+bedno, chkStr);
//                  console.log("체크 저장했나요");
//              });

         },
         error: function (xhr, status, error) {
              console.log("code: " + xhr.status);
              console.log("message: " + xhr.responseText);
              console.log("error: " + error);
          }
      });
      

   }else if(patCode && bedColor=="white"){ // patCode가 있으면  && whiteBed 이면  값을 넣고-> 검정색으로 바뀌어야 함
//       alert("값 넣고 침대 색 바꾸기");
      $.ajax({
         url:"/physio/bedStatus",
         contentType:"application/json;charset=utf-8",
         data:JSON.stringify(data),
         dataType:"json",
         type:"post",
         success:function(result){
            //result : List<BedVO>
//             console.log("result : " + JSON.stringify(result));

            $.each(result,function(i,bedVO){
//                console.log("bedNo : " + bedVO.bedNo + ", bedStat : " + bedVO.bedStat);
               
               if(bedVO.bedStat=='EMPT'){
                  $("#bed"+bedVO.bedNo).attr("src","/resources/images/bed.png");
               }else{
                  $("#bed"+bedVO.bedNo).attr("src","/resources/images/blackBed.jpg");
               }
            });
            
            // 여기서 값 비우기
            $("#patInfoDiv input").val("");
            $("#physioListArea").empty();
            $("#physioHistoryArea").empty();
            
            physioStatFunc();
         }
      });
      
   }else if(patCode && bedColor=="black"){ // patCode가 있으면  && blackbed이면 alert
       Swal.fire({
         icon: 'error',
         title: '선택불가',
         text: '이미 치료중인 환자가 있습니다.',
      });
      
   }

}


function pEndBtn(){
   let phlength = $("input[name=physioContent]").length;
    console.log("physioContent의 길이",phlength);
   
   if($("input[name=physioContent]:checked").length == phlength){
   
   let treatNoo = $("#treatNoo").val()
   
    console.log("treatNo 진짜",treatNoo)
   
   //치료완료 시 bed에 저장된 치료내용checkbox를 초기화 함
     //localStorage.setItem("bed"+bedno, "");
   
   $.ajax({
      url : `/physio/updateStat/\${treatNoo}/\${bedNo}`,
      type : "post",
      dataType : "json",
      success : function(res){
//          console.log("버튼 눌리나 보자궁 : " + res);

         Swal.fire({
              icon: 'success',
              title: '치료완료',
              text: '해당환자의 치료가 완료되었습니다.',
          })
          
//          console.log("bedNo:",$("#bed"+bedNo)[0]);
         $("#bed"+bedNo).attr("src","/resources/images/bed.png");
         
         $("#bedDiv input").val('');
         
         var physioContentArea = $("#physioContentArea"); 
          physioContentArea.empty(); // 기존 내용 지우기
          
          physioStatFunc(); // 치료현황 리스트
          physiotherapyWait(); // 대기환자 리스트
          
          
         // 웹소켓으로 일정등록을 연락!
         let msg = {
            to: "물리치료사",
            from: "간호사, 원무과",
            cmd: "endPhysio"
         }
         webSocket.send(JSON.stringify(msg));
          
          
      }, 
      error: function (xhr, status, error) {
            console.log("code: " + xhr.status);
            console.log("message: " + xhr.responseText);
            console.log("error: " + error);
         }

   });

   
   
   }else{
       Swal.fire({
            icon: 'warning',
            title: '미완료치료 있음',
            text: '치료완료 후 선택해주세요.',
        });
   }
}
 // ------------ 웹소켓 ---------------------
 function fMessage(){
    let serverMsg = JSON.parse(event.data);
    
    if(serverMsg.cmd == "alarm"){
       getNotiList();
    }
    if(serverMsg.cmd == "plzPhysio"){
       physiotherapyWait();
    }
 }
 // ------------ 웹소켓 ---------------------


   





</script>
</body>
</html>


